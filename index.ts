import { pipeline } from "@huggingface/transformers";
import similarity from "compute-cosine-similarity";
import OpenAI from "openai";

// Create pipeline once at module level to reuse the same model instance
const extractor = await pipeline(
  "feature-extraction",
  //"Xenova/all-MiniLM-L6-v2"
  //"Xenova/bge-base-en-v1.5",
  "Xenova/e5-large-v2",
  { dtype: "fp32" }
);

const generateEmbeddings = async (text: string): Promise<number[]> => {
  const output = await extractor(text, { pooling: "mean", normalize: true });
  return Array.from(output.data);
};

const openai = new OpenAI({ apiKey: process.env.openAiKey });
const generateEmbeddings2 = async (texts: string[]) => {
  const response = await openai.embeddings.create({
    model: "text-embedding-3-large",
    input: texts,
  });
  return response.data.map((item) => item.embedding);
};

// warm start download model
await generateEmbeddings("Your input text here.");

import data from "./data2.json";
for (const d of data) {
  //console.log(d.college);
  //console.log(d.department);
  const contents = await Bun.file(d.summary).text();
  (d as any).text = contents;
  //(d as any).vector = await generateEmbeddings(contents);
}

const texts = data.map((d) => ` ${d.college}\n${d.department}\n${d.summary} `);
const embeddings = await generateEmbeddings2(texts);
data.forEach((d, i) => {
  (d as any).vector = embeddings[i];
});

//await new Promise((resolve) => setTimeout(resolve, 60_000));
await Bun.write("./src/embeddings.json", JSON.stringify(data, null, 4));

const queries = [
  "veterans",
  "sustainability",
  "entrepreneurship",
  "mental health",
  "arts",
  "engineering",
  "scholarships",
  "rural",
  "innovation",
  "disabilities",
  "cybersecurity",
  "climate",
  "medicine",
  "athletics",
  "international",
  "women",
  "technology",
  "community",
  "research",
  "leadership",
  "I want to support students who are the first in their family to attend college",
  "Where can I fund programs that help students start their own businesses",
  "I'm looking for initiatives that address food insecurity on campus",
  "I want to support research that could lead to medical breakthroughs",
  "Show me programs that help veterans transition to civilian careers",
  "I'm interested in funding study abroad opportunities for underprivileged students",
  "I want to support faculty who are doing groundbreaking work in artificial intelligence",
  "Where can I help expand access to mental health resources for students",
  "I'm looking for programs that bridge the gap between academia and industry",
  "I want to fund scholarships for students pursuing careers in public service",
  "Show me initiatives that promote diversity in STEM fields",
  "I want to support programs that help students develop leadership skills",
  "I'm interested in funding research that addresses climate change solutions",
  "Where can I help improve campus infrastructure and facilities",
  "I want to support programs that connect students with local community organizations",
  "I'm looking for initiatives that help students pay for basic needs like housing and textbooks",
  "I want to fund programs that prepare students for careers in emerging technologies",
  "Show me ways to support faculty research in renewable energy",
  "I'm interested in programs that help students develop critical thinking skills",
  "I want to support initiatives that make college more affordable for middle-class families",
];

const queryEmbeddings = await generateEmbeddings2(queries);
await Bun.write(
  "./src/queryEmbeddings.json",
  JSON.stringify(
    Object.fromEntries(queries.map((q, i) => [q, queryEmbeddings[i]])),
    null,
    4
  )
);

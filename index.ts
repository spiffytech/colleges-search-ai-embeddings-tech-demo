import { pipeline } from "@huggingface/transformers";
import similarity from "compute-cosine-similarity";

const generateEmbeddings = async (text: string): Promise<number[]> => {
  const extractor = await pipeline(
    "feature-extraction",
    //"Xenova/all-MiniLM-L6-v2"
    "Xenova/bge-base-en-v1.5"
  );
  const output = await extractor(text, { pooling: "mean", normalize: true });
  return Array.from(output.data);
};

// warm start download model
await generateEmbeddings("Your input text here.");

console.time("generateEmbeddings");
const embeddings = await generateEmbeddings("Your input text here.");
console.timeEnd("generateEmbeddings");
console.log(embeddings);

console.log(similarity(embeddings, embeddings));

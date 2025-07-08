<script setup lang="ts">
import { ref, computed, onMounted } from "vue";

import { pipeline } from "@huggingface/transformers";
import similarity from "compute-cosine-similarity";

import dataRaw from "./embeddings.json";
import queryEmbeddings from "./queryEmbeddings.json";

const data: {
  college: string;
  department: string;
  summary: string;
  text: string;
  vector: number[];
  similarityScore: number;
}[] = dataRaw as unknown as any;

let extractor;
const ready = ref(false);

onMounted(async () => {
  // Create pipeline once at module level to reuse the same model instance
  extractor = await pipeline(
    "feature-extraction",
    //"Xenova/all-MiniLM-L6-v2"
    //"Xenova/bge-base-en-v1.5",
    "Xenova/e5-large-v2",
    { dtype: "fp32" }
  );
  ready.value = true;
});

const generateEmbeddings = async (text: string): Promise<number[]> => {
  const output = await extractor!(text, { pooling: "mean", normalize: true });
  return Array.from(output.data);
};

const query = ref("");

const data2 = ref(data);

const onQuery = async () => {
  if (!query.value) {
    data2.value = data;
    return;
  }

  //const vector = await generateEmbeddings(query.value);
  const vector = queryEmbeddings[query.value as keyof typeof queryEmbeddings]!;
  console.log(vector);
  const withSimilarity = data.map((d) => {
    const similarityScore = similarity(vector, d.vector) ?? 0;
    return { ...d, similarityScore };
  });
  withSimilarity.sort((a, b) => b.similarityScore - a.similarityScore);
  const results = withSimilarity.filter((d) => d.similarityScore > 0.0);

  data2.value = results;
};
</script>

<template>
  <p>{{ ready }}</p>

  <button
    type="button"
    v-for="q in Object.keys(queryEmbeddings)"
    @click="
      query = q;
      onQuery();
    "
  >
    {{ q }}
  </button>

  <div v-for="d in data2">
    <header v-if="d.department">{{ d.department }}</header>
    <header>{{ d.college }}</header>
    <p>Match %: {{ d.similarityScore }}</p>
    <p v-for="t in d.text.split('\n')">{{ t }}</p>
  </div>
</template>

<style scoped>
header {
  font-size: 1.5rem;
  font-weight: bold;
}
header + header {
  font-size: 1rem;
  font-weight: bold;
  font-style: italic;
}
</style>

<script setup lang="ts">
import { ref } from "vue";

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

const data2 = ref(data);
const activeQuery = ref<string>("");

const searchForQuery = async (query: keyof typeof queryEmbeddings) => {
  activeQuery.value = query;

  if (!query) {
    data2.value = data;
    return;
  }

  const vector = queryEmbeddings[query as keyof typeof queryEmbeddings]!;
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
  <p>
    <a
      href="https://github.com/spiffytech/colleges-search-ai-embeddings-tech-demo"
    >
      Source
    </a>
  </p>

  <button
    type="button"
    v-for="q in Object.keys(queryEmbeddings) as Array<keyof typeof queryEmbeddings>"
    @click="searchForQuery(q)"
  >
    {{ q }}
  </button>

  <p id="query">Query: {{ activeQuery || "None" }}</p>

  <div v-for="d in data2">
    <header v-if="d.department">{{ d.department }}</header>
    <header>{{ d.college }}</header>
    <p>Match %: {{ d.similarityScore }}</p>
    <p v-for="t in d.text.split('\n')">{{ t }}</p>
  </div>
</template>

<style scoped>
#query {
  font-size: 1.5rem;
  font-weight: bold;
}

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

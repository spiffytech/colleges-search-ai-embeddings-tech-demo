[View the web app](https://college-depts-ai-embedding-demo.netlify.app)

# ⚠️ WARNING: ⚠️: Terrible code ahead!

This is a mega-hacky tech demo of using AI embeddings to search through a list
of colleges and departments.

I've made zero effort to make either the code or the interface any good. I just
wanted to prove whether the idea had any merit. It does!

# How

`scraped_html/` contains the HTML pgaes for all (?) of the departments at NC
State University.

`summaries2/` contains text summaries of the content on each page. It was
generated like so:

```fish
$ for file in *.html
      set basename (basename $file .html)
      cat $file | llm -m gpt-4.1-nano 'Synthesize a summary of the college/department, including its values, objectives, and activities. Focus on the department\'s unique value - skip generic traits that could apply to most colleges or departments. These summaries are competing with each other for attention and money; they should be selling themselves. Write out a new file for each in summaries/. Write in plain text (no Markdown). Write 3 paragraphs.' > ../summaries2/$basename.txt
  end
```

followed by a little massaging to remove GPT Nano's "why certainly, I'd love to
help you out!" prologues.

I had an LLM agent (Kilo Code) look through the HTML and summary filenames and
generate `data.json`, associating each summary file with a college & department.

`index.ts` shows how I read in `data.json` and added in AI embeddings, using
OpenAI's `text-embedding-3-large` model.

I also generated embeddings for a bunch of sample search terms to
`queryEmbeddings.json`. In a real project you'd have a search box and generate
that live, but I wanted a static demo, so hardcoded data was fine. I had AI
generate the suggested queries.

`src/App.vue` is the frontend code. I import the hardcoded data files and find
search results using cosine similarity. I just order matches by similarity
without applying a cutoff since
it's a tech demo.
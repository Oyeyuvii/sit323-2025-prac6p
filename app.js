// app.js
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello from Kubernetes + Node.js!');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});

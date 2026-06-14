const express = require("express");
const path = require("path");
const session = require("express-session");
const bcrypt = require("bcryptjs");
const sqlite3 = require("sqlite3").verbose();

const app = express();
const PORT = process.env.PORT || 3000;

// DB
const dbFile = path.join(__dirname, "database.sqlite");
const db = new sqlite3.Database(dbFile);
db.serialize(() => {
  db.run(`CREATE TABLE IF NOT EXISTS users (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		username TEXT,
		email TEXT UNIQUE,
		password_hash TEXT,
		created_at DATETIME DEFAULT CURRENT_TIMESTAMP
	)`);
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(
  session({
    secret: "cambiar_esto_en_produccion",
    resave: false,
    saveUninitialized: false,
    cookie: { maxAge: 1000 * 60 * 60 * 24 },
  }),
);

// Static files
app.use(express.static(path.join(__dirname)));

// API: register
app.post("/api/register", (req, res) => {
  const { username, email, password } = req.body;
  if (!email || !password)
    return res.status(400).json({ error: "Faltan campos" });
  db.get("SELECT id FROM users WHERE email = ?", [email], (err, row) => {
    if (err) return res.status(500).json({ error: "Error en base de datos" });
    if (row) return res.status(400).json({ error: "Email ya registrado" });
    const hash = bcrypt.hashSync(password, 10);
    db.run(
      "INSERT INTO users (username,email,password_hash) VALUES (?,?,?)",
      [username, email, hash],
      function (err) {
        if (err)
          return res.status(500).json({ error: "Error al guardar usuario" });
        return res.json({ ok: true, id: this.lastID });
      },
    );
  });
});

// API: login
app.post("/api/login", (req, res) => {
  const { email, password } = req.body;
  if (!email || !password)
    return res.status(400).json({ error: "Faltan campos" });
  db.get(
    "SELECT id,username,email,password_hash FROM users WHERE email = ?",
    [email],
    (err, user) => {
      if (err) return res.status(500).json({ error: "Error en base de datos" });
      if (!user)
        return res.status(400).json({ error: "Usuario no encontrado" });
      const ok = bcrypt.compareSync(password, user.password_hash);
      if (!ok) return res.status(401).json({ error: "Contraseña incorrecta" });
      // set session
      req.session.user = {
        id: user.id,
        username: user.username,
        email: user.email,
      };
      return res.json({ ok: true, user: req.session.user });
    },
  );
});

// API: current user
app.get("/api/user", (req, res) => {
  if (req.session && req.session.user)
    return res.json({ user: req.session.user });
  return res.status(401).json({ error: "No autenticado" });
});

// API: logout
app.post("/api/logout", (req, res) => {
  req.session.destroy(() => {
    res.json({ ok: true });
  });
});

// Fallback: serve index
app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "index.html"));
});

app.listen(PORT, () =>
  console.log(`Server running on http://localhost:${PORT}`),
);

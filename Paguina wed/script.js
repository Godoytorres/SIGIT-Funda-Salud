const $ = (sel) => document.querySelector(sel);

const showLoginBtn = $("#show-login");
const showRegisterBtn = $("#show-register");
const loginSection = $("#login-section");
const registerSection = $("#register-section");
const userPanel = $("#user-panel");
const messageEl = $("#message");

function showMessage(text, type = "success") {
  messageEl.textContent = text;
  messageEl.className = `message ${type}`;
  messageEl.classList.remove("hidden");
  setTimeout(() => messageEl.classList.add("hidden"), 4000);
}

showLoginBtn.addEventListener("click", () => {
  showLoginBtn.classList.add("active");
  showRegisterBtn.classList.remove("active");
  loginSection.classList.remove("hidden");
  registerSection.classList.add("hidden");
});

showRegisterBtn.addEventListener("click", () => {
  showRegisterBtn.classList.add("active");
  showLoginBtn.classList.remove("active");
  registerSection.classList.remove("hidden");
  loginSection.classList.add("hidden");
});

// Register
$("#register-form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const form = e.target;
  const data = {
    username: form.username.value.trim(),
    email: form.email.value.trim(),
    password: form.password.value,
  };
  try {
    const res = await fetch("/api/register", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
    });
    const json = await res.json();
    if (res.ok) {
      showMessage("Registro exitoso. Ya puedes iniciar sesión.", "success");
      showLoginBtn.click();
      form.reset();
    } else {
      showMessage(json.error || "Error en registro", "error");
    }
  } catch (err) {
    showMessage("Error de red", "error");
  }
});

// Login
$("#login-form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const form = e.target;
  const data = {
    email: form.email.value.trim(),
    password: form.password.value,
  };
  try {
    const res = await fetch("/api/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
    });
    const json = await res.json();
    if (res.ok) {
      showMessage("Inicio de sesión correcto", "success");
      form.reset();
      renderUser(json.user);
    } else {
      showMessage(json.error || "Credenciales inválidas", "error");
    }
  } catch (err) {
    showMessage("Error de red", "error");
  }
});

function renderUser(user) {
  if (!user) return;
  $("#user-name").textContent = user.username || user.email;
  userPanel.classList.remove("hidden");
  loginSection.classList.add("hidden");
  registerSection.classList.add("hidden");
  showLoginBtn.classList.remove("active");
  showRegisterBtn.classList.remove("active");
}

$("#logout").addEventListener("click", async () => {
  await fetch("/api/logout", { method: "POST" });
  userPanel.classList.add("hidden");
  showLoginBtn.classList.add("active");
  loginSection.classList.remove("hidden");
  showMessage("Sesión cerrada", "success");
});

// On load, check session
(async function () {
  try {
    const res = await fetch("/api/user");
    if (res.ok) {
      const json = await res.json();
      renderUser(json.user);
    }
  } catch (e) {
    /* ignore */
  }
})();

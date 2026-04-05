document.addEventListener("turbo:load", () => {

  const loginForm = document.getElementById("loginForm");
  if (loginForm) {
    loginForm.addEventListener("submit", async (e) => {
      e.preventDefault();

      const email = document.getElementById("email").value;
      const password = document.getElementById("password").value;

      const res = await fetch("/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email, password })
      });

      const data = await res.json();

      if (res.ok) {
        localStorage.setItem("token", data.auth_token);
        window.location.href = "/dashboard";
      } else {
        document.getElementById("error").innerText =
          data.message || "Invalid email or password";
      }
    });
  }

  const signupForm = document.getElementById("signupForm");
  if (signupForm) {
    signupForm.addEventListener("submit", async (e) => {
      e.preventDefault();

      document.getElementById("error").innerText = ""; 

      const body = {
        user: {
          name: document.getElementById("name").value,
          email: document.getElementById("email").value,
          password: document.getElementById("password").value,
          password_confirmation: document.getElementById("password_confirmation").value
        }
      };

      const res = await fetch("/signup", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body)
      });

      const data = await res.json();

      if (res.ok) {

        localStorage.setItem("token", data.auth_token);

        window.location.href = "/dashboard";
      } else {
        document.getElementById("error").innerText =
          data.message || data.errors?.join(", ") || "Signup failed";
      }
    });
  }
  });

  function logout() {
    localStorage.removeItem("token");
    window.location.href = "/login";
  }
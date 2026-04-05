document.addEventListener("turbo:load", () => {
  const token = localStorage.getItem("token");

  async function fetchPlayers() {
    const list = document.getElementById("playersList");
    if (!list) return;

    const res = await fetch("/players", { headers: { Authorization: token } });
    const players = await res.json();
    list.innerHTML = "";

    players.forEach(p => {
      list.innerHTML += `
        <tr>
          <td>${p.id}</td>
          <td>${p.name}</td>
          <td>${p.phone}</td>
          <td>${p.wins || 0}</td>
          <td>${p.losses || 0}</td>
          <td>${p.created_by_id || "-"}</td>
          <td>${p.updated_by_id || "-"}</td>
          <td>
            <a href="/players/${p.id}/edit">Edit</a>
            <button onclick="deletePlayer(${p.id})">Delete</button>
          </td>
        </tr>
      `;
    });
  }

  window.deletePlayer = async function(id) {
    await fetch(`/players/${id}`, {
      method: "DELETE",
      headers: { Authorization: token }
    });
    fetchPlayers();
  };

  fetchPlayers(); 

  const createForm = document.getElementById("createPlayerForm");
  if (createForm) {
    createForm.addEventListener("submit", async (e) => {
      e.preventDefault();
      const name = document.getElementById("name").value;
      const phone = document.getElementById("phone").value;

      const res = await fetch("/players", {
        method: "POST",
        headers: { "Content-Type": "application/json", Authorization: token },
        body: JSON.stringify({ player: { name, phone } })
      });

      const data = await res.json().catch(() => ({}));
      if (res.ok) {
        window.location.href = "/players-page";
      } else {
        document.getElementById("error").innerText = data.errors?.join(", ") || data.error;
      }
    });
  }

  const editForm = document.getElementById("editPlayerForm");
  if (editForm) {
    const pathParts = window.location.pathname.split("/");
    const playerId = pathParts[2];

    async function loadPlayer(playerId) {
      const input = document.getElementById("name");
      const phoneInput = document.getElementById("phone");
      if (!input) return;

      const res = await fetch("/players", { headers: { Authorization: token } });
      const players = await res.json();
      const player = players.find(p => p.id == playerId);

      if (player) {
        input.value = player.name;
        if (phoneInput) phoneInput.value = player.phone || "";
        input.focus();
        input.setSelectionRange(input.value.length, input.value.length);
      }
    }

    loadPlayer(playerId);

    editForm.addEventListener("submit", async (e) => {
      e.preventDefault();

      const res = await fetch(`/players/${playerId}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json", Authorization: token },
        body: JSON.stringify({
          player: {
            name: document.getElementById("name").value,
            phone: document.getElementById("phone").value
          }
        })
      });

      const data = await res.json().catch(() => ({}));

      if (res.ok) {
        window.location.href = "/players-page";
      } else {
        document.getElementById("error").innerText = data.errors?.join(", ") || data.error;
      }
    });
  }
});
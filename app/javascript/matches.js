document.addEventListener("turbo:load", () => {
  const form = document.getElementById("matchForm");
  if (!form) return;

  const token = localStorage.getItem("token");

  const playerA = document.getElementById("playerA");
  const playerB = document.getElementById("playerB");
  const winner = document.getElementById("winner");
  const errorBox = document.getElementById("error");

  async function loadPlayers() {
    const res = await fetch("/players", {
      headers: { Authorization: token }
    });

    const players = await res.json();

    [playerA, playerB, winner].forEach(select => {
      select.innerHTML = `<option value="">Select Player</option>`;
      players.forEach(p => {
        select.innerHTML += `<option value="${p.id}">
          ${p.name} (ID: ${p.id})
        </option>`;
      });
    });
  }

  loadPlayers();

  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    errorBox.innerText = "";

    const body = {
      match: {
        player_a_id: playerA.value,
        player_b_id: playerB.value,
        winner_id: winner.value
      }
    };

    const res = await fetch("/matches", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: token
      },
      body: JSON.stringify(body)
    });

    const data = await res.json();

    if (res.ok) {
      alert("Match created successfully");
      form.reset();
    } else {
      errorBox.innerText =
        data.error || data.errors?.join(", ") || "Something went wrong";
    }
  });
});
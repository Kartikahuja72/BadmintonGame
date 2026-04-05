document.addEventListener("turbo:load", () => {
  fetchLeaderboard();
});

async function fetchLeaderboard() {
  const table = document.getElementById("leaderboardTable");
  const error = document.getElementById("error");

  if (!table) return;

  const token = localStorage.getItem("token");

  const res = await fetch("/stats/leaderboard", {
    headers: {
      Authorization: token
    }
  });

  table.innerHTML = "";
  error.innerText = "";

  if (!res.ok) {
    error.innerText = "Failed to load leaderboard";
    return;
  }

  const data = await res.json();

  if (!data.leaderboard || data.leaderboard.length === 0) {
    table.innerHTML = `<tr><td colspan="5">No data available</td></tr>`;
    return;
  }

  data.leaderboard.forEach(p => {
    table.innerHTML += `
      <tr>
        <td>${p.rank}</td>
        <td>${p.id}</td>
        <td>${p.name}</td>
        <td>${p.phone}</td>
        <td>${p.wins}</td>
        <td>${p.losses}</td>
        <td>${p.win_percentage}</td>
      </tr>
    `;
  });
}
function voteWeather(weather) {
    console.log(`Vote registered for weather: ${weather}`);
    // Simulate a successful fetch response
    setTimeout(() => {
        console.log({ status: 'ok' });
    }, 1000);
}

window.addEventListener('message', function(event) {
    if (event.data.action === 'open') {
        document.getElementById('weather-vote').style.display = 'block';
    } else if (event.data.action === 'close') {
        document.getElementById('weather-vote').style.display = 'none';
    } else if (event.data.action === 'updateVotes') {
        document.getElementById('clear-votes').innerText = event.data.votes.CLEAR || 0;
        document.getElementById('extrasunny-votes').innerText = event.data.votes.EXTRASUNNY || 0;
        document.getElementById('clouds-votes').innerText = event.data.votes.CLOUDS || 0;
        document.getElementById('overcast-votes').innerText = event.data.votes.OVERCAST || 0;
        document.getElementById('rain-votes').innerText = event.data.votes.RAIN || 0;
        document.getElementById('clearing-votes').innerText = event.data.votes.CLEARING || 0;
        document.getElementById('thunder-votes').innerText = event.data.votes.THUNDER || 0;
        document.getElementById('smog-votes').innerText = event.data.votes.SMOG || 0;
        document.getElementById('foggy-votes').innerText = event.data.votes.FOGGY || 0;
        document.getElementById('xmas-votes').innerText = event.data.votes.XMAS || 0;
        document.getElementById('snowlight-votes').innerText = event.data.votes.SNOWLIGHT || 0;
        document.getElementById('blizzard-votes').innerText = event.data.votes.BLIZZARD || 0;
    } else if (event.data.action === 'updateTimer') {
        document.getElementById('time-left').innerText = event.data.timeLeft;
    }
});
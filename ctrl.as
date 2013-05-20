estartbtn.onRelease = function () {
	estopd = false;
	stopd = false;
}
pstartbtn.onRelease = function () {
	pstopd = false;
	stopd = false;
}
resetbtn.onRelease = function () {
	estopd = true;
	pstopd = true;
	stopd = false;
	reset();
}
pausebtn.onRelease = function () {
	if (!stopd) {
		stopd = true;
		pawstxt.text = "Resume";
	}
	else {
		container.clear();
		stopd = false;
		ghosts2 = false;
		pawstxt.text = "Pause";
	}
}
setcar1varsbtn.onRelease = function () {
	car1.velocity = parseInt(vel1txt.text);
}

setcar2varsbtn.onRelease = function () {
	car2.acceleration = parseInt(acel2txt.text);
}
setspeedbtn.onRelease = function () {
	speedlimit = parseInt(speedtxt.text);
}

ghostbtn.onRelease = function () {
	if (stopd) {
		drawGhosts();
		ghosts2 = false;
	}
}

ghostbtn2.onRelease = function () {
	if (stopd) {
		drawGhosts2();
	}
}
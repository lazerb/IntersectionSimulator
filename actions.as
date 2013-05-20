stopd = false;
estopd = true;
pstopd = true;
resetd = false;
var pcords = [car2._x, car2._y, car2._rotation]
var ccords = [car1._x, car1._y, car1._rotation]

function stopSim () {
	stopd = true;
	pawstxt.text = "Resume";
}

function testHits () {
	if (ecar.hitTest(pcar)) {
		stopSim();
	}
}

function moveecar () {
	eg._x += exv/10;
	eg._y += eyv/10;
	if (eg._x > egx - 4 + Math.sqrt(Math.pow(pxv*10, 2) + Math.pow(pyv*10, 2))) {
		eg._x = egx;
		eg._y = egy;
	}
}

function movepcar () {
	pg._x += pxv/10;
	pg._y += pyv/10;
	if (pg._x < pgx + pxv*10 || pg._y < pgy + pyv*10) {
		pg._x = pgx;
		pg._y = pgy;
		eg._x = egx;
		eg._y = egy;
	}
}

function reset () {
	car1.j=0;
	car2.j=0;
	//ecar ease
	car1._x = ccords[0];
	car1._y = ccords[1];
	car1._rotation = ccords[2];
	//pcar ease
	car2._x = pcords[0];
	car2._y = pcords[1];
	car2._rotation = pcords[2];
	
	pcar._x = pcords[0];
	pcar._y = pcords[1];
	pcar._rotation = pcords[2];
	
	ecar._x = ccords[0];
	ecar._y = ccords[1];
	ecar._rotation = ccords[2];
	
	pawstxt.text = "Pause";
	resetd = true;
	container.clear();
}

distBox._alpha = 0;

onEnterFrame = function () {
	testHits();
	if (showghosts) {
		movepcar();
		moveecar();
		distBox._alpha = 100;
		distBox.box.text = Math.sqrt(Math.pow(eg._x-pg._x, 2) + Math.pow(eg._y-pg._y, 2));
		distBox._x = pg._x;
		distBox._y = pg._y + pg._height/2 + 30;
	}
	else {
		distBox._alpha = 0;
	}
	
	if (!stopd) {
		ecar._alpha = 100;
		pcar._alpha = 100;
		removeMovieClip(eg);
		removeMovieClip(pg);
		showghosts = false;
		if (!pstopd) {
			gfx(car2, funx, funy, pvel, pacel, pvel, pacel);
			ease(pcar, car2);
		}
		if (!estopd) {
			ease(ecar, car1);
			gfx(car1, efunx, efuny, car1vel, 0, car1vel, 0);
		}
	}
	if (ghosts2) {
		if (!pstopd) {
			gfx2(car2, funx, funy, pvel, pacel, pvel, pacel,car1.j);
			ease(pcar, car2);
		}
		if (!estopd) {
			ease(ecar, car1);
			gfx2(car1, efunx, efuny, car1vel, 0, car1vel, 0, car2.j);
		}
	}
}
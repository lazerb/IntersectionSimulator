createEmptyMovieClip("container", this.getNextHighestDepth());
container.lineStyle(1, 0x000000, 100);

function drawGhosts() {
	container.lineStyle(1, 0xFFFFFF, 100);
	showghosts = true;
	duplicateMovieClip(ecar, "eg", this.getNextHighestDepth());
	duplicateMovieClip(pcar, "pg", this.getNextHighestDepth());
	egv = 20;
	pgv = 20;
	egr = ecar._rotation;
	pgr = pcar._rotation;
	egx = ecar._x;
	egy = ecar._y;
	pgx = pcar._x;
	pgy = pcar._y;
	
	eg._alpha = 50;
	pg._alpha = 50;
	//
	eg._rotation = ecar._rotation;
	eg._x = ecar._x;
	eg._y = ecar._y;
	//
	pg._rotation = pcar._rotation;
	pg._x = pcar._x;
	pg._y = pcar._y;
	exv = egv*Math.cos(egr*Math.PI/180);
	eyv = egv*Math.sin(egr*Math.PI/180);
	
	container.moveTo(egx, egy);
	container.lineTo(egx + exv*10, egy + eyv*10);
	
	pxv = pgv*Math.cos(pgr*Math.PI/180);
	pyv = pgv*Math.sin(pgr*Math.PI/180);
	
	container.moveTo(pgx, pgy);
	container.lineTo(pgx + pxv*10, pgy + pyv*10);
	//trace("enemy" + Math.sqrt(Math.pow(exv*10, 2) + Math.pow(eyv*10, 2)));
	//trace(Math.sqrt(Math.pow(pxv*10, 2) + Math.pow(pyv*10, 2)));
}

function drawGhosts2() {
	duplicateMovieClip(ecar, "eg", this.getNextHighestDepth());
	duplicateMovieClip(pcar, "pg", this.getNextHighestDepth());
	egr = ecar._rotation;
	pgr = pcar._rotation;
	egx = ecar._x;
	egy = ecar._y;
	pgx = pcar._x;
	pgy = pcar._y;
	ecar._alpha = 50;
	pcar._alpha = 50;
	ghosts2 = true;
}

var funx:Array = new Array();
var funy:Array = new Array();

var efunx:Array = new Array();
var efuny:Array = new Array();

exi = car1._x;
eyi = car1._y;


xi = car2._x;
yi = car2._y;
container.moveTo(xi, yi);

car1vel = 30;

//functions for "enemy" car trajectory
for (k=0;k<Stage.width - 200;k+=.1) {
	eex = exi+k;
	eey = eyi;
	efunx.push(eex);
	efuny.push(eey);
}


//functions for player car trajectory
vertlin = 130;
radius = 150;
mult = Math.E-.2;
for (i=0;i<vertlin+2*Math.PI*radius/4+(Stage.width-(vertlin+2*Math.PI*radius/4) - 500);i+=.1) {
	if (i < vertlin) {
		ex = xi;
		ey = yi-i;
		//container.lineTo(ex, ey);
		funx.push(ex);
		funy.push(ey);
	}

	else if (i > vertlin && i < vertlin+radius*Math.PI/2) {
		container.lineStyle(1, 0xFFFFFF, 50);
		//function
		ex = xi - radius + mult*Math.cos((i - vertlin)/radius)*180/Math.PI + 6;
		ey = yi - vertlin - mult*Math.sin((i - vertlin)/radius)*180/Math.PI;
		//ex = xi - Math.abs(vertlin-i);
		//ey = yi - Math.sqrt(Math.pow(radius, 2) - Math.pow((vertlin*2-i - (vertlin - radius)),2)) - vertlin;
		//container.lineTo(ex, ey);
		funx.push(ex);
		funy.push(ey);
		finishedCircle = ex;
	}
	if (i > vertlin+radius*Math.PI/2) {
		container.lineStyle(1, 0x000000, 50);
		ex = finishedCircle - Math.abs(vertlin+radius*Math.PI/2-i);
		//ey = yi;
		//container.lineTo(ex, ey);
		funx.push(ex);
		funy.push(ey);
	}
}

car1.j = 0;
car2.j = 0;
car1.velocity = parseInt(vel1txt.text);
car2.velocity = 0;
car2.acceleration = parseInt(acel2txt.text);
car1.acceleration = 0;
pvel = 0;
pacel = .5;
car1vel = 15;

speedlimit = 20;
function gfx (car, arrayx, arrayy, velocity, acceleration, orig_vel, orig_acel) {
	//reset to original values
	if (resetd) {
		car.velocity = parseInt(vel1txt.text);
		car.acceleration = parseInt(acel2txt.text);
		resetd = false;
	}
	if (car.velocity > speedlimit) {
		car.acceleration = 0;
	}
	
	car.velocity += car.acceleration;
	car.j += Math.ceil(car.velocity);
	car._x = arrayx[car.j];
	car._y = arrayy[car.j];
	car._rotation = 180/Math.PI*Math.atan2(arrayy[car.j]-arrayy[car.j-1], arrayx[car.j]-arrayx[car.j-1]);
	
}

function gfx2 (car, arrayx, arrayy, velocity, acceleration, orig_vel, orig_acel, origJ) {
	//reset to original values
	if (resetd) {
		car.velocity = parseInt(vel1txt.text);
		car.acceleration = parseInt(acel2txt.text);
		resetd = false;
	}
	if (car.velocity > speedlimit) {
		car.acceleration = 0;
	}
	
	car.velocity += car.acceleration;
	car.j += Math.ceil(car.velocity);
	car._x = arrayx[car.j];
	car._y = arrayy[car.j];
	car._rotation = 180/Math.PI*Math.atan2(arrayy[car.j]-arrayy[car.j-1], arrayx[car.j]-arrayx[car.j-1]);
	
	if (car.j > arrayx.length - 10) {
		j = origJ;
		car._x = arrayx[origJ];
		car._y = arrayy[origJ];
	}
}


function ease (car, car2) {
	car._x += (car2._x - car._x) / 10;
	if (car2._rotation - car._rotation > 90) {
		car._rotation += (car2._rotation - car._rotation - 360) / 10;
	}
	else {
		car._rotation += (car2._rotation - car._rotation) / 10;
	}
	car._y += (car2._y - car._y) / 10;
}
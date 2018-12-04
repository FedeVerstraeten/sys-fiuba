close all;
clear all;
clc;

order = 200;

filtro1 = fill1(order, 8000, 697 - 30, 697 + 30);		%filtro para obtener f=697
filtro2 = fill1(order, 8000, 770 - 30, 770 + 30);		%filtro para obtener f=697
filtro3 = fill1(order, 8000, 852 - 30, 852 + 30);		%filtro para obtener f=697
filtro4 = fill1(order, 8000, 941 - 30, 941 + 30);		%filtro para obtener f=697

filtro5 = fill1(order, 8000, 1209 - 30, 1209 + 30);		%filtro para obtener f=697
filtro6 = fill1(order, 8000, 1336 - 30, 1336 + 30);		%filtro para obtener f=697
filtro7 = fill1(order, 8000, 1477 - 30, 1477 + 30);		%filtro para obtener f=697
filtro8 = fill1(order, 8000, 1633 - 30, 1633 + 30);		%filtro para obtener f=697

zplane(filtro1);
zplane(filtro2);
zplane(filtro3);
zplane(filtro4);

zplane(filtro5);
zplane(filtro6);
zplane(filtro7);
zplane(filtro8);


phasez(filtro1);
phasez(filtro2);
phasez(filtro3);
phasez(filtro4);
phasez(filtro5);
phasez(filtro6);
phasez(filtro7);
phasez(filtro8);

freqz(filtro1);
freqz(filtro2);
freqz(filtro3);
freqz(filtro4);
freqz(filtro5);
freqz(filtro6);
freqz(filtro7);
freqz(filtro8);
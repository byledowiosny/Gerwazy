QT += core
QT -= gui

CONFIG += c++11

TARGET = ssaFULL
CONFIG += console
CONFIG += debug
CONFIG -= app_bundle

TEMPLATE = app

SOURCES += main.cpp \
timeseries.cpp \
ssaalgo.cpp

INCLUDEPATH += /usr/include/eigen3/

HEADERS += \
timeseries.h \
measurement.h \
ssaalgo.h

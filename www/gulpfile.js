'use strict';

var gulp = require('gulp'),
    watch = require('gulp-watch'),
    prefixer = require('gulp-autoprefixer'),
    uglify = require('gulp-uglify'),
    sourcemaps = require('gulp-sourcemaps'),
    concat = require('gulp-concat'),
    rigger = require('gulp-rigger'),
    cleanCSS = require('gulp-clean-css'),
    imagemin = require('gulp-imagemin'),
    pngquant = require('imagemin-pngquant'),
    rimraf = require('rimraf'),
    browserSync = require("browser-sync"),
    reload = browserSync.reload;

var themePath = 'catalog/view/theme/acceptus';
var build = '/build';
var path = {
    src: { //Пути откуда брать исходники
        js: themePath + '/js/*.js',//В стилях и скриптах нам понадобятся только main файлы
        style: themePath + '/stylesheet/*.css',
        img: themePath + '/image/**/*.*', //Синтаксис img/**/*.* означает - взять все файлы всех расширений из папки и из вложенных каталогов
        fonts: themePath + '/fonts/**/*.*'
    },
    build: { //Тут мы укажем куда складывать готовые после сборки файлы
        js: themePath + build + '/js/',
        css: themePath + build + '/css/',
        img: themePath + build + '/image/',
        fonts: themePath + build + '/fonts/'
    },
    watch: { //Тут мы укажем, за изменением каких файлов мы хотим наблюдать
        js: themePath + '/js/*.js',
        style: themePath + '/stylesheet/',
        img: themePath + '/image/**/*.*',
        fonts: themePath + '/fonts/**/*.*'
    },
    clean: themePath + build
};

gulp.task('js:build', function () {
    gulp.src(path.src.js) //Найдем наш main файл
        .pipe(rigger()) //Прогоним через rigger
        .pipe(concat('final.js'))
        .pipe(sourcemaps.init()) //Инициализируем sourcemap
        .pipe(uglify()) //Сожмем наш js
        .pipe(sourcemaps.write()) //Пропишем карты
        .pipe(gulp.dest(path.build.js)); //Выплюнем готовый файл в build
});

gulp.task('style:build', function () {
    gulp.src(path.src.style) //Выберем наш main.css

        .pipe(sourcemaps.init())
        .pipe(cleanCSS())
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(path.build.css)); //И в build
});

gulp.task('image:build', function () {
    gulp.src(path.src.img) //Выберем наши картинки
        .pipe(imagemin({ //Сожмем их
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [pngquant()],
            interlaced: true
        }))
        .pipe(gulp.dest(path.build.img)); //И бросим в build
});

gulp.task('fonts:build', function() {
    gulp.src(path.src.fonts)
        .pipe(gulp.dest(path.build.fonts))
});

gulp.task('build', [
    'js:build',
    'style:build',
    'fonts:build',
    'image:build'
]);

gulp.task('watch', function(){
    watch([path.watch.style], function(event, cb) {
        gulp.start('style:build');
    });
    watch([path.watch.js], function(event, cb) {
        gulp.start('js:build');
    });
    watch([path.watch.img], function(event, cb) {
        gulp.start('image:build');
    });
    watch([path.watch.fonts], function(event, cb) {
        gulp.start('fonts:build');
    });
});

gulp.task('clean', function (cb) {
    rimraf(path.clean, cb);
});

gulp.task('default', ['build', 'watch']);
'use strict';

var gulp = require('gulp'),
    watch = require('gulp-watch'),
    prefixer = require('gulp-autoprefixer'),
    uglify = require('gulp-uglify'),
    sourcemaps = require('gulp-sourcemaps'),
    sass = require('gulp-sass'),
    concat = require('gulp-concat'),
    rigger = require('gulp-rigger'),
    cleanCSS = require('gulp-clean-css'),
    imagemin = require('gulp-imagemin'),
    pngquant = require('imagemin-pngquant'),
    rimraf = require('rimraf'),
    browserSync = require("browser-sync"),
    reload = browserSync.reload;

var themePath = 'catalog/view/theme/acceptus';
var themePathRu = '../ru/catalog/view/theme/acceptus';
var buildPath = '/build';
var path = getPath();
function getPath (customThemePath) {
    var themePath = 'catalog/view/theme/acceptus';
    var customThemePath = customThemePath || themePath;
    return {
        src: { //Пути откуда брать исходники
            js: themePath + '/js/*.js',//В стилях и скриптах нам понадобятся только main файлы
            style: [themePath + '/sass/app.scss', themePath + '/sass/ie.scss'],
            img: themePath + '/image/**/*.*', //Синтаксис img/**/*.* означает - взять все файлы всех расширений из папки и из вложенных каталогов
            fonts: themePath + '/fonts/**/*.*'
        },
        build: { //Тут мы укажем куда складывать готовые после сборки файлы
            js: customThemePath + buildPath + '/js/',
            css: customThemePath + buildPath + '/css/',
            img: customThemePath + buildPath + '/image/',
            fonts: customThemePath + buildPath + '/fonts/'
        },
        watch: { //Тут мы укажем, за изменением каких файлов мы хотим наблюдать
            js: themePath + '/js/*.js',
            style: themePath + '/sass/*.scss',
            img: themePath + '/image/**/*.*',
            fonts: themePath + '/fonts/**/*.*'
        },
        clean: customThemePath + buildPath
    }
}

var jsTask = function (path) {
    gulp.src(path.src.js) //Найдем наш main файл
        .pipe(rigger()) //Прогоним через rigger
        .pipe(concat('final.js'))
        .pipe(sourcemaps.init()) //Инициализируем sourcemap
        .pipe(uglify()) //Сожмем наш js
        .pipe(sourcemaps.write()) //Пропишем карты
        .pipe(gulp.dest(path.build.js)); //Выплюнем готовый файл в build
};

var styleTask = function (path) {
    gulp.src(path.src.style) //Выберем наш main.scss
        .pipe(sourcemaps.init()) //То же самое что и с js
        .pipe(sass()) //Скомпилируем
        .pipe(prefixer()) //Добавим вендорные префиксы
        .pipe(cleanCSS()) //Сожмем
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(path.build.css)); //И в build
};

var imageTask = function (path) {
    gulp.src(path.src.img) //Выберем наши картинки
        .pipe(imagemin({ //Сожмем их
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [pngquant()],
            interlaced: true
        }))
        .pipe(gulp.dest(path.build.img)); //И бросим в build
};

var fontsTask = function (path) {
    gulp.src(path.src.fonts)
        .pipe(gulp.dest(path.build.fonts))
};

gulp.task('js:build', function () {
    jsTask(getPath());
    jsTask(getPath(themePathRu));
});

gulp.task('style:build', function () {
    styleTask(getPath());
    styleTask(getPath(themePathRu));
});

gulp.task('image:build', function () {
    imageTask(getPath());
    imageTask(getPath(themePathRu));
});

gulp.task('fonts:build', function() {
    fontsTask(getPath());
    fontsTask(getPath(themePathRu));
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
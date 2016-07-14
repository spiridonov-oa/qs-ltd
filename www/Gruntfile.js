module.exports = function(grunt) {

    var themePath = 'catalog/view/theme/acceptus';
    var build = '/build';
    var path = {
        src: { //Пути откуда брать исходники
            js: themePath + '/js/*.js',//В стилях и скриптах нам понадобятся только main файлы
            style: themePath + '/stylesheet/',
            img: themePath + '/image/**/*.*', //Синтаксис img/**/*.* означает - взять все файлы всех расширений из папки и из вложенных каталогов
            fonts: themePath + '/fonts/**/*.*'
        },
        build: { //Тут мы укажем куда складывать готовые после сборки файлы
            js: themePath + build + '/js/*.js',
            css: themePath + build + '/css/*.css',
            img: themePath + build + '/image/**/*.*',
            fonts: themePath + build + '/fonts/**/*.*'
        },
        watch: { //Тут мы укажем, за изменением каких файлов мы хотим наблюдать
            js: themePath + '/js/*.js',
            style: themePath + '/stylesheet/',
            img: themePath + '/image/**/*.*',
            fonts: themePath + '/fonts/**/*.*'
        },
        clean: './build'
    };

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        concatJs: {
            dist: {
                src: [
                    'catalog/view/theme/acceptus/js/*.js'
                ],
                dest: 'catalog/view/theme/acceptus/build/js/production.js'
            }
        },
        uglify: {
            build: {
                src: 'catalog/view/theme/acceptus/build/js/production.js',
                dest: 'catalog/view/theme/acceptus/build/js/production.min.js'
            }
        }

    });

    grunt.loadNpmTasks('grunt-contrib-concat');

    grunt.registerTask('default', ['concatJs', 'uglify']);

};
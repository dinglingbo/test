'use strict';
(function (win) {
    var config = {
        baseUrl: './js/',
        paths: {
        text: 'lib/text' ,
        jquery: 'https://cdn.bootcss.com/jquery/2.2.4/jquery.min',
        director: 'https://cdn.bootcss.com/Director/1.2.8/director.min',
        template: 'lib/artTemplate',
        axios: 'https://cdn.bootcss.com/axios/0.18.0/axios.min',
        api: 'api'
        },
        shim: {
          jquery : {
            exports: '$'
          },
          director: {
            exports: 'Router'
          }
        }
    }

    require.config(config);
    require(
      ['jquery', 'template', 'router', 'store'], 
      function($, template, router, store, app){
      win.$ = $
      win.appView = $('#container')
      win.template = template
      win.store = store
      router.init('/')
      // app()
    });
})(window);
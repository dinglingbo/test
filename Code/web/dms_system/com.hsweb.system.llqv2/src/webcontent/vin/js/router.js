define(['director'], function (Router) {

  //先设置一个路由信息表，可以由html直出，纯字符串配置
  var routes = {
      '/': 'js/index/app.js',
      '/ac': 'js/ac/index.js',                                                         //  “ /?([^\/]*) ”  这样的一段表示一个可选参数，接受非斜杠/的任意字符
      '/bi/:auth': 'js/bi/index.js'
  }

  var currentController = null;

  //用于把字符串转化为一个函数，而这个也是路由的处理核心
  var routeHandler = function (config) {
      return function () {
          var url = config;
          var params = arguments;
          console.log(params)
          require([url], function (controller) {
              if(currentController && currentController !== controller){
                  currentController.onRouteChange && currentController.onRouteChange();
              }
              currentController = controller;
              controller.apply(null, params);
          });
      }
  };

  for (var key in routes) {
      routes[key] = routeHandler(routes[key]);
  }



  //学习记录
  return Router(routes);
});
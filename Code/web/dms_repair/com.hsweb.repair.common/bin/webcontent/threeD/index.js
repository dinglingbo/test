const { Scene, Label, Sprite, Path, Group } = spritejs
const scene = new Scene('#baoan', {viewport: ['auto', 'auto'], resolution: [640, 360]});

const layer = scene.layer();

let isloaderImg = false; // 图片是否加载完
let activeImgindex = 0; // 当前图片索引
let rate = 3; // 原图 与 场景  3 : 1
let imgs = null;
let activeCarPart 
let isRenderChejia = false;

const partList = getCarParts()
const images = [
  './image/rs7_0000.png',
  './image/rs7_0001.png',
  './image/rs7_0002.png',
  './image/rs7_0003.png',
  './image/rs7_0004.png',
  './image/rs7_0005.png',
  './image/rs7_0006.png',
  './image/rs7_0007.png',
  './image/rs7_0008.png',
  './image/rs7_0009.png',
  './image/rs7_0010.png',
  './image/rs7_0011.png',
  './image/rs7_0012.png',
  './image/rs7_0013.png',
  './image/rs7_0014.png',
  './image/rs7_0015.png',
  './image/rs7_0016.png',
  './image/rs7_0017.png',
  './image/rs7_0018.png',
  './image/rs7_0019.png',
  './image/rs7_0020.png',
  './image/rs7_0021.png',
  './image/rs7_0022.png',
  './image/rs7_0023.png',
  './image/rs7_0024.png',
  './image/rs7_0025.png',
  './image/rs7_0026.png',
  './image/rs7_0027.png',
  './image/rs7_0028.png',
  './image/rs7_0029.png',
  './image/rs7_0030.png',
  './image/rs7_0031.png',
  './image/rs7_0032.png',
  './image/rs7_0033.png',
  './image/rs7_0034.png',
  './image/rs7_0035.png'
];

const label = new Label('加载中... 0 / 36');
label.attr({
  anchor: [0.5, 0.5],
  font: '20px Arial',
  color: '#fff',
  pos: [320, 180],
});
layer.append(label);

const carBody = new Sprite();
carBody.attr({
  anchor: [0.5, 0.5],
  pos: [320, 180],
  size: [640, 360],
});
layer.append(carBody);

const groupPart = new Group();
groupPart.attr({
  anchor: [0.5, 0.5],
  pos: [320, 180],
  size: [640, 360],
});
layer.append(groupPart);

const groupPartDot = new Group();
groupPartDot.attr({
  anchor: [0.5, 0.5],
  pos: [320, 180],
  size: [640, 360],
});
layer.append(groupPartDot);


loadRes();

let offsetX = 0
let startPosX = 0
let isDrag = false
let index = 0
carBody.on('mousedown', evt => {
  if (!isloaderImg) return;
  isDrag = true
  startPosX = evt.x
})
carBody.on('mousemove', evt => {
  if (!isloaderImg || !isDrag) return;
  groupPart.children.forEach(item => item.remove())
  groupPartDot.children.forEach(item => item.remove())
  offsetX = evt.x - startPosX 
  updateCarBody(offsetX)
})
carBody.on('mouseup', evt => {
  if (!isloaderImg) return;
  isDrag = false
  activeImgindex = index
  getActiveCarPart()
  updatePartGemo()
  updatePartCententDot()
})
carBody.on('mouseleave', evt => {
  if (!isloaderImg) return;
  isDrag = false
  activeImgindex = index
  getActiveCarPart()
  updatePartGemo()
  updatePartCententDot()
})


groupPart.on('click', evt => {
  try {
    const code = evt.targetSprites[0].attributes.code
    $(`.j_part-title-${code}`).addClass('active').siblings().removeClass('active')
    redenerPartDetail(code)
    updateSinglePartCenterDot(code)
  } catch (err) {}
})

$('.j_carPart-bar').on('click', '.j_part-title', function() {
  $(this).addClass('active').siblings().removeClass('active')
  redenerPartDetail($(this).data('code'))
  updateSinglePartCenterDot($(this).data('code'))
})

$('.j_carPart-main').on('click', '.j_part-item', function() {
  console.log($(this))
})


$('.j_menu').on('click', 'button', function () {
  const index = $(this).index()
  $('.j_car-show').hide().eq(index).show()
  if (index === 0) {
    redenerPart()
  } else {
    if (!isRenderChejia) {
      renderChejia()
    }
    redenerPart1()
  }
  $('.j_carPart-main').html()
})

function updateCarBody (offsetX) {

  // 转动的角度， 从左滑倒右为180°， 即18张图片
  const key = Math.round((offsetX * 180) / (640 * 10))

  if (activeImgindex + key > imgs.length - 1) {
    index = activeImgindex + key - imgs.length
  } else if (activeImgindex + key < 0) {
    index = activeImgindex + key + imgs.length - 1
  } else {
    index = activeImgindex + key
  }

  console.log("渲染的图片", index, imgs[index].texture)
  carBody.attr({
    textures: imgs[index].texture
  })
}

function getActiveCarPart () {
  const activeImg = images[activeImgindex]
  let activeCarBody
  let activeCarPartTemp = []

  for (const key in body) {
    if (body.hasOwnProperty(key) && activeImg.indexOf(key) !== -1) {
      activeCarBody = body[key]
    }
  }

  activeCarBody.forEach(item => {
    item.spot.map(aa => {
      activeCarPartTemp.push({
        code: item.code,
        img: item.img,
        label: item.label,
        cententDot: getGeomCenterDot(aa.onespot),
        path: aa.onespot.map((pos, index) => (`${index === 0 ? 'M' : 'L'}${(pos.x / rate).toFixed(2)} ${(pos.y / rate).toFixed(2)}`)).join(' ') + ' Z'
      })
    })
  })
  activeCarPart = activeCarPartTemp
}

function updatePartCententDot () {
  const parts = activeCarPart.map(item => {
      const part = new Sprite()
      part.attr({
        code: item.code,
        anchor: [0.5, 0.5],
        size: [10, 10],
        pos: [item.cententDot.x, item.cententDot.y],
        bgcolor: 'red',
        borderRadius: 10,
      })
      return part
    })

  groupPartDot.append(...parts)
}

function updateSinglePartCenterDot (code) {
  groupPartDot.children.forEach(part => {
    if (part.attributes.code == code) {
      part.attr({
        border: '6px solid #e68356'
      })
    } else {
      part.attr({
        border: '0'
      })
    }
  })
}

function updatePartGemo () {
  const parts = activeCarPart.map(item => {
    const part = new Path()
    part.attr({
      code: item.code,
      label: item.label,
      path: item.path,
      strokeColor: 'rgba(255, 0, 0, 0)',
      lineWidth: 0
    })
    return part
  })
  groupPart.append(...parts)
}

function getCarParts () {
  const parts = []
  for (const key in body) {
    if (body.hasOwnProperty(key)) {
      const item = body[key];
      item.forEach(item => {
        if (!parts.find(part => part.code == item.code)) {
          parts.push({
            code: item.code,
            img: item.img, 
            label: item.label,
            sublabel: item.sublabel
          })
        }
      })
    }
  }
  parts.sort((a, b) => a.code > b.code)
  return parts
}

function redenerPart () {
  let html = ''
  partList.forEach(part => {
    html += `
      <div class="part-title j_part-title j_part-title-${part.code}" data-code="${part.code}">
        <img src="./body/${part.img}">
        ${part.label}
      </div>
    `
  })
  $('.j_carPart-bar').html(html)
}

function redenerPartDetail (code) {
  const part = partList.find(part => part.code == code)
  let html = ''
  part.sublabel.forEach(name => {
    html += `
      <div class="part-item j_part-item" data-name="${name}">
        ${name}
      </div>
    `
  })
  $('.j_carPart-main').html(html)
}

// 获取几何的中心点
function getGeomCenterDot (posList) {
  const x = posList.reduce((total, item) => total + item.x, 0) / (rate * posList.length)
  const y = posList.reduce((total, item) => total + item.y, 0) / (rate * posList.length)

  return {x, y}
}

async function loadRes() {

  scene.on('preload', (evt) => {
    label.text = `加载中... ${evt.loaded.length} / ${evt.resources.length}`;
  });

  imgs = await scene.preload(...images);
  

  isloaderImg = true

  label.remove();

  // carBody.animate(imgs.map(img =>({textures: img.texture})), {
  //   duration: 4000,
  //   iterations: 1,
  // });
  carBody.attr({
    textures: imgs[0].texture
  })
  $('#main').show()
  $('.j_menu').show()
  getActiveCarPart()
  updatePartGemo()
  updatePartCententDot()
  redenerPart()
}




/**
 * 车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架
 * 车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架
 * 车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架
 * 车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架
 * 车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架
 * 车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架
 * 车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架车架
 */
let sceneChejia
let layer1
let carjia
let groupPart1
let groupPartDot1
function renderChejia() {
  isRenderChejia = true
  sceneChejia = new Scene('#baoan1', {viewport: ['auto', 'auto'], resolution: [640, 360]});
  layer1 = sceneChejia.layer();

  // 车架
  carjia = new Sprite('./chassis.png');
  carjia.attr({
    anchor: [0.5, 0.5],
    pos: [320, 180],
    size: [640, 360],
  });
  layer1.append(carjia);


  groupPart1 = new Group();
  groupPart1.attr({
    anchor: [0.5, 0.5],
    pos: [320, 180],
    size: [640, 360],
  });
  layer1.append(groupPart1);

  groupPartDot1 = new Group();
  groupPartDot1.attr({
    anchor: [0.5, 0.5],
    pos: [320, 180],
    size: [640, 360],
  });
  layer1.append(groupPartDot1);

  groupPart1.on('click', evt => {
    try {
      const code = evt.targetSprites[0].attributes.code
      $(`.j_part-title1-${code}`).addClass('active').siblings().removeClass('active')
      redenerPartDetail1(code)
      updateSinglePartCenterDot1(code)
    } catch (err) {}
  })

  $('.j_carPart-bar').on('click', '.j_part-title1', function() {
    $(this).addClass('active').siblings().removeClass('active')
    redenerPartDetail1($(this).data('code'))
    updateSinglePartCenterDot1($(this).data('code'))
  })


  getActiveCarPart1()
  updatePartGemo1()
  updatePartCententDot1()

}

function getActiveCarPart1 () {

  chassis.forEach(item => {
    item.spot.forEach(aa => {
      item.cententDot = getGeomCenterDot(aa.onespot);
      item.path = aa.onespot.map((pos, index) => (`${index === 0 ? 'M' : 'L'}${(pos.x / rate).toFixed(2)} ${(pos.y / rate).toFixed(2)}`)).join(' ') + ' Z';
    })
  })
}

function updatePartCententDot1 () {
  const parts = chassis.map(item => {
      const part = new Sprite()
      part.attr({
        code: item.code,
        anchor: [0.5, 0.5],
        size: [10, 10],
        pos: [item.cententDot.x, item.cententDot.y],
        bgcolor: 'red',
        borderRadius: 10,
      })
      return part
    })

  groupPartDot1.append(...parts)
}

function updateSinglePartCenterDot1 (code) {
  groupPartDot1.children.forEach(part => {
    if (part.attributes.code == code) {
      part.attr({
        border: '6px solid #e68356'
      })
    } else {
      part.attr({
        border: '0'
      })
    }
  })
}

function updatePartGemo1 () {
  const parts = chassis.map(item => {
    const part = new Path()
    part.attr({
      code: item.code,
      label: item.label,
      path: item.path,
      strokeColor: 'rgba(255, 0, 0, 0)',
      lineWidth: 0
    })
    return part
  })
  groupPart1.append(...parts)
}

function redenerPart1 () {
  let html = ''
  chassis.forEach(part => {
    html += `
      <div class="part-title j_part-title1 j_part-title1-${part.code}" data-code="${part.code}">
        <img src="./chassis/${part.img}">
        ${part.label}
      </div>
    `
  })
  $('.j_carPart-bar').html(html)
}

function redenerPartDetail1 (code) {
  const part = chassis.find(part => part.code == code)
  let html = ''
  part.sublabel.forEach(name => {
    html += `
      <div class="part-item j_part-item" data-name="${name}">
        ${name}
      </div>
    `
  })
  $('.j_carPart-main').html(html)
}
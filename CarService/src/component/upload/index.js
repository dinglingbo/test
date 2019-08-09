import Upload from './upload.vue'
import UploadBtn from './btn.vue'
import UploadFile from './file.vue'

Upload.install = function (Vue) {
  Vue.component(Upload.name, Upload)
  Vue.component(UploadBtn.name, UploadBtn)
  Vue.component(UploadFile.name, UploadFile)
}

Upload.Btn = UploadBtn
Upload.File = UploadFile

export default Upload

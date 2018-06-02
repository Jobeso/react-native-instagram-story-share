import { NativeModules } from 'react-native'

const { RNInstagramStoryShare } = NativeModules

/* const ERROR_TYPES = {
  NOT_INSTALLED: RNInstagramStoryShare.NOT_INSTALLED,
  INTERNAL_ERROR: RNInstagramStoryShare.INTERNAL_ERROR,
  NO_BASE64_IMAGE: RNInstagramStoryShare.NO_BASE64_IMAGE,
  INVALID_PARAMETER: RNInstagramStoryShare.INVALID_PARAMETER,
}

const shareToInstagramStory = options =>
  new Promise((resolve, reject) =>
    RNInstagramStoryShare.share(options, error => reject(error), resolve)
  )

module.exports = { share: shareToInstagramStory, ERROR_TYPES }
module.exports.shareToInstagramStory = shareToInstagramStory
module.exports.ERROR_TYPES = ERROR_TYPES */

module.exports = RNInstagramStoryShare

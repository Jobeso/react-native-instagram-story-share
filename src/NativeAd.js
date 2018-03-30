import React from 'react'
import { requireNativeComponent } from 'react-native'
import PropTypes from 'prop-types'

const TellAd = requireNativeComponent('NativeTellAd', NativeAd)

class NativeAd extends React.Component {
  render() {
    return <TellAd {...this.props} />
  }
}

// TODO: add isRequired
NativeAd.propTypes = {
  onLoadedEvent: PropTypes.func,
  onErrorEvent: PropTypes.func,
  size: PropTypes.shape({
    height: PropTypes.number,
    width: PropTypes.number,
  }),
  unitId: PropTypes.string,
}

module.exports = NativeAd

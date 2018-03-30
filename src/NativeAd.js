import React from 'react' // eslint-disable-line
import { Dimensions, requireNativeComponent } from 'react-native' // eslint-disable-line
import PropTypes from 'prop-types'

const TellAd = requireNativeComponent('NativeTellAd', NativeAd)

class NativeAd extends React.Component {
  render() {
    return <TellAd {...this.props} style={{ ...this.props.size }} />
  }
}

// TODO: add isRequired
NativeAd.defaultProps = {
  layout: 'small',
  onClick: () => {},
  onFailure: () => {},
  onImpression: () => {},
  onSuccess: () => {},
  size: {
    height: 200,
    width: Dimensions.get('window').width,
  },
}

NativeAd.propTypes = {
  layout: PropTypes.string,
  onClick: PropTypes.func,
  onFailure: PropTypes.func,
  onImpression: PropTypes.func,
  onSuccess: PropTypes.func,
  size: PropTypes.shape({
    height: PropTypes.number,
    width: PropTypes.number,
  }),
  unitId: PropTypes.string.isRequired,
}

module.exports = NativeAd

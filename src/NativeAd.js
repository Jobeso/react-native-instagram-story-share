import React from 'react' // eslint-disable-line
import { Dimensions, requireNativeComponent, View } from 'react-native' // eslint-disable-line
import PropTypes from 'prop-types'

const NativeComponent = requireNativeComponent('NativeAd', NativeAd)

class NativeAd extends React.Component {
  render() {
    return (
      <View style={{ ...this.props.style }}>
        <NativeComponent {...this.props} style={{ ...this.props.size }} />
      </View>
    )
  }
}

NativeAd.defaultProps = {
  layout: 'small',
  onClick: () => {},
  onFailure: () => {},
  onImpression: () => {},
  onSuccess: () => {},
  size: {
    height: 400,
    width: Math.floor(Dimensions.get('window').width),
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

export default NativeAd

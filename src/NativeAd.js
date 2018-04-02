import React from 'react' // eslint-disable-line
import { Dimensions, requireNativeComponent, View } from 'react-native' // eslint-disable-line
import PropTypes from 'prop-types'

const NativeComponent = requireNativeComponent('NativeAd', NativeAd)

const LAYOUT = {
  BIG: 'BIG',
  SMALL: 'SMALL',
}

const DIMENSIONS = {
  [LAYOUT.BIG]: {
    height: 400,
    width: Math.floor(Dimensions.get('window').width),
  },
  [LAYOUT.SMALL]: {
    height: 200,
    width: Math.floor(Dimensions.get('window').width),
  },
}

class NativeAd extends React.Component {
  static DIMENSIONS = DIMENSIONS
  static LAYOUT = LAYOUT

  render() {
    const { layout, style } = this.props

    return (
      <View style={{ ...style }}>
        <NativeComponent {...this.props} style={{ ...DIMENSIONS[layout] }} />
      </View>
    )
  }
}

NativeAd.defaultProps = {
  layout: LAYOUT.BIG,
  onClick: () => {},
  onFailure: () => {},
  onImpression: () => {},
  onSuccess: () => {},
}

NativeAd.propTypes = {
  layout: PropTypes.string,
  onClick: PropTypes.func,
  onFailure: PropTypes.func,
  onImpression: PropTypes.func,
  onSuccess: PropTypes.func,
  unitId: PropTypes.string.isRequired,
}

export default NativeAd

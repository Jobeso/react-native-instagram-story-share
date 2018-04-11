import React from 'react' // eslint-disable-line
import {
  Dimensions,
  Platform,
  requireNativeComponent,
  View,
} from 'react-native' // eslint-disable-line
import PropTypes from 'prop-types'

const NativeComponent =
  Platform.OS === 'ios'
    ? requireNativeComponent('RNTView', NativeAd)
    : requireNativeComponent('NativeAd', NativeAd)

const LAYOUT = {
  BIG: 'BIG',
  MEDIUM: 'MEDIUM',
  SMALL: 'SMALL',
}

const DIMENSIONS = {
  [LAYOUT.BIG]: {
    height: 360,
    width: Dimensions.get('window').width,
  },
  [LAYOUT.MEDIUM]: {
    height: 241,
    width: Dimensions.get('window').width,
  },
  [LAYOUT.SMALL]: {
    height: 137,
    width: Dimensions.get('window').width,
  },
}

class NativeAd extends React.Component {
  static DIMENSIONS = DIMENSIONS
  static LAYOUT = LAYOUT

  state = { isAdRendered: true }

  render() {
    const { isAdRendered } = this.state
    return (
      <View
        style={{
          ...this.props.style,
          height: isAdRendered ? this.props.height : 0,
        }}
      >
        <NativeComponent
          {...this.props}
          onSuccess={e => {
            this.setState({ isAdRendered: true })
            this.props.onSuccess(e)
          }}
          style={DIMENSIONS[this.props.layout.toUpperCase()]}
          unitID={this.props.unitId}
        />
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

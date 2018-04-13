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
  MOPUB_NATIVEAD_BIG: 'MOPUB_NATIVEAD_BIG',
  MOPUB_NATIVEAD_BIG_DARK: 'MOPUB_NATIVEAD_BIG_DARK',
  MOPUB_NATIVEAD_MEDIUM: 'MOPUB_NATIVEAD_MEDIUM',
  MOPUB_NATIVEAD_MEDIUM_DARK: 'MOPUB_NATIVEAD_MEDIUM_DARK',
  MOPUB_NATIVEAD_SMALL: 'MOPUB_NATIVEAD_SMALL',
  MOPUB_NATIVEAD_SMALL_DARK: 'MOPUB_NATIVEAD_SMALL_DARK',
}

const getDimensions = layout => {
  const { width } = Dimensions.get('window')
  switch (layout) {
    case LAYOUT.MOPUB_NATIVEAD_BIG:
    case LAYOUT.MOPUB_NATIVEAD_BIG_DARK:
      return {
        height: 360,
        width,
      }
    case LAYOUT.MOPUB_NATIVEAD_MEDIUM:
    case LAYOUT.MOPUB_NATIVEAD_MEDIUM_DARK:
      return {
        height: 241,
        width,
      }
    case LAYOUT.MOPUB_NATIVEAD_SMALL:
    case LAYOUT.MOPUB_NATIVEAD_SMALL_DARK:
    default:
      return {
        height: 137,
        width,
      }
  }
}

class NativeAd extends React.Component {
  static getDimensions = getDimensions
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
          style={getDimensions(this.props.layout.toUpperCase())}
          unitID={this.props.unitId}
        />
      </View>
    )
  }
}

NativeAd.defaultProps = {
  layout: LAYOUT.MOPUB_NATIVEAD_SMALL,
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

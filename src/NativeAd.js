import React from "react"
import { requireNativeComponent } from "react-native"

const TellAd = requireNativeComponent("NativeTellAd", NativeTellAdView)

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

export default NativeAd

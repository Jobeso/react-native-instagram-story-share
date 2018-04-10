import React, {Component, PropTypes} from 'react';
import { requireNativeComponent, View, StyleSheet } from 'react-native'; 

const BannerPropTypes = {
  adUnitId: PropTypes.string.isRequired,
  testing: PropTypes.bool,
  autoRefresh: PropTypes.bool,
  keywords: PropTypes.string,
  localExtras: PropTypes.object,
  onLoaded: PropTypes.func,
  onFailed: PropTypes.func,
  onClicked: PropTypes.func,
  onExpanded: PropTypes.func,
  onCollapsed: PropTypes.func,
  ...View.propTypes
};

const Banner = requireNativeComponent('RNMoPubBanner', {name: 'Banner', propTypes: { ...BannerPropTypes }} );

export default class MoPubBanner extends Component {

  static propTypes = {
    ...BannerPropTypes
  };

  render() {
    return (
      <View style={styles.bannerContainer}>
        <Banner 
          adUnitId={this.props.adUnitId}
          testing={this.props.testing}
          autoRefresh={this.props.autoRefresh}
          keywords={this.props.keywords}
          localExtras={this.props.localExtras}
          onLoaded={this.props.onLoaded}
          onFailed={this.props.onFailed}
          onClicked={this.props.onClicked}
          onExpanded={this.props.onExpanded}
          onCollapsed={this.props.onCollapsed}
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  bannerContainer: {
    height: 50,
    minWidth: 320
  }
});
import { View, StyleSheet } from 'react-native';
import type { NativeProps } from './RenderLynxViewNativeComponent';
import RenderLynxViewNativeComponent from './RenderLynxViewNativeComponent';

export default function RenderLynxView(props: NativeProps) {
  const bundleUrl = props.bundleUrl || 'main.lynx.bundle';

  return (
    <View {...props} style={[styles.container, props.style]}>
      <RenderLynxViewNativeComponent
        bundleUrl={bundleUrl}
        style={styles.native}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    overflow: 'hidden',
  },
  native: {
    flex: 1,
  },
});

import { View, StyleSheet, Platform } from 'react-native';
import type { NativeProps } from './RenderLynxViewNativeComponent';
import RenderLynxViewNativeComponent from './RenderLynxViewNativeComponent';

export default function RenderLynxView(props: NativeProps) {
  const defaultBundleName = props.bundleName || 'main.lynx.bundle';
  const bundleName = Platform.select({
    ios: defaultBundleName.replace('.bundle', ''),
    default: defaultBundleName,
  });

  return (
    <View {...props} style={[styles.container, props.style]}>
      <RenderLynxViewNativeComponent
        bundleName={bundleName}
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

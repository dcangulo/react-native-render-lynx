import { View, StyleSheet, Platform } from 'react-native';
import RenderLynxView from 'react-native-render-lynx';

export default function App() {
  return (
    <View style={styles.container}>
      <RenderLynxView
        style={styles.viewStyle}
        bundleUrl={Platform.select({
          android: 'noimage.lynx.bundle',
          default: 'main.lynx.bundle',
        })}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 50,
  },
  viewStyle: {
    height: 700,
    width: 300,
    marginTop: 32,
  },
});

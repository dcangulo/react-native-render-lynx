import { View, StyleSheet, Text } from 'react-native';
import { RenderLynxView } from 'react-native-render-lynx';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={{ fontSize: 24 }}>Text Component</Text>
      <View style={{ height: 700, width: 300, marginTop: 32 }}>
        <RenderLynxView color="#32a852" style={styles.box} />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 40,
    // alignItems: 'center',
    // justifyContent: 'center',
  },
  box: {
    // width: 60,
    // height: 60,
    // marginVertical: 20,
    flex: 1,
  },
});

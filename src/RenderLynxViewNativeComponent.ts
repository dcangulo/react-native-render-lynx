import { type HostComponent, type ViewProps } from 'react-native';
import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';

export interface NativeProps extends ViewProps {
  bundleName: string;
}

export default codegenNativeComponent<NativeProps>(
  'RenderLynxView'
) as HostComponent<NativeProps>;

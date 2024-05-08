Shader "Hidden/VideoDecodeAndroid"
{
  Properties
  {
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: RGBAExternal_To_RGBA
    {
      Name "RGBAExternal_To_RGBA"
      Tags
      { 
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #line 1
      
      
      
      
      
      
      
      
      uniform float4x4 unity_ObjectToWorld;
      
      uniform float4x4 unity_WorldToObject;
      
      uniform float4x4 unity_MatrixVP;
      
      uniform float4x4 unity_MatrixV;
      
      uniform float4x4 unity_MatrixInvV;
      
      uniform float4x4 UNITY_MATRIX_P;
      
      uniform float4 _Time;
      
      uniform float4 _SinTime;
      
      uniform float4 _CosTime;
      
      uniform float4 _ProjectionParams;
      
      uniform float4 _ScreenParams;
      
      uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float4 _LightPositionRange;
      
      uniform float4 _MainTex_ST;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION;
          
          float3 normal : NORMAL;
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord[1] : TEXCOORD[1];
          
          float2 textureCoord : ;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 textureCoord : ;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      
      
      float3x3 transpose(float3x3 mtx)
      {
          
          float3 c0 = mtx[0];
          
          float3 c1 = mtx[1];
          
          float3 c2 = mtx[2];
          
          
          return float3x3( float3(c0.x, c1.x, c2.x), float3(c0.y, c1.y, c2.y), float3(c0.z, c1.z, c2.z) );
      
      }
      
      float4x4 transpose(float4x4 mtx)
      {
          
          float4 c0 = mtx[0];
          
          float4 c1 = mtx[1];
          
          float4 c2 = mtx[2];
          
          float4 c3 = mtx[3];
          
          
          return float4x4( float4(c0.x, c1.x, c2.x, c3.x), float4(c0.y, c1.y, c2.y, c3.y), float4(c0.z, c1.z, c2.z, c3.z), float4(c0.w, c1.w, c2.w, c3.w) );
      
      }
      
      
      
      #line 54
      
      #line 12
      
      #line 4
      
      #line 1
      
      
      
      
      float saturate(float x)
      {
          
          return max(0.0, min(1.0, x));
      
      }
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      float2 ParallaxOffset( float h, float height, float3 viewDir )
      {
          
          h = h * height - height/2.0;
          
          float3 v = normalize(viewDir);
          
          v.z += 0.42;
          
          return h * (v.xy / v.z);
      
      }
      
      
      
      
      float Luminance( float3 c )
      {
          
          return dot( c, float3(0.22, 0.707, 0.071) );
      
      }
      
      
      
      
      #line 5
      
      #line 12
      
      
      
      
      
      
      
      
      
      
      
      
      #define CODE_BLOCK_VERTEX
      
      
      
      float3 WorldSpaceLightDir( float4 v )
      {
          
          float3 worldPos = (unity_ObjectToWorld * v).xyz;
          
          #ifndef USING_LIGHT_MULTI_COMPILE
          return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
          
          #else
          #ifndef USING_DIRECTIONAL_LIGHT
          return _WorldSpaceLightPos0.xyz - worldPos;
          
          #else
          return _WorldSpaceLightPos0.xyz;
          
          #endif
          #endif
      }
      
      
      
      float3 ObjSpaceLightDir( float4 v )
      {
          
          float3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
          
          #ifndef USING_LIGHT_MULTI_COMPILE
          return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
          
          #else
          #ifndef USING_DIRECTIONAL_LIGHT
          return objSpaceLightPos.xyz - v.xyz;
          
          #else
          return objSpaceLightPos.xyz;
          
          #endif
          #endif
      }
      
      
      
      float3 WorldSpaceViewDir( float4 v )
      {
          
          return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
      
      }
      
      
      
      float3 ObjSpaceViewDir( float4 v )
      {
          
          float3 objSpaceCameraPos = (unity_WorldToObject * float4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
          
          return objSpaceCameraPos - v.xyz;
      
      }
      
      
      
      
      
      
      
      
      
      
      
      
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          out_v.vertex = (unity_MatrixVP * unity_ObjectToWorld) * in_v.vertex;
          
          out_v.textureCoord = TRANSFORM_TEX_ST(in_v.texcoord, _MainTex_ST);
      
      }
      
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      
      
      float4 AdjustForColorSpace(float4 color)
      {
          
          #if defined(UNITY_COLORSPACE_GAMMA)
      || !defined(ADJUST_TO_LINEARSPACE)
          return color;
          
          #else
          
          float3 sRGB = color.rgb;
          
          return float4(sRGB * (sRGB * (sRGB * 0.305306011 + 0.682171111) + 0.012522878), color.a);
          
          #endif
      }
      
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          out_f.color = AdjustForColorSpace(texture2D(_MainTex, in_f.textureCoord));
      
      }
      
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: RGBASplitExternal_To_RGBA
    {
      Name "RGBASplitExternal_To_RGBA"
      Tags
      { 
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #line 1
      
      
      
      
      
      
      
      
      uniform float4x4 unity_ObjectToWorld;
      
      uniform float4x4 unity_WorldToObject;
      
      uniform float4x4 unity_MatrixVP;
      
      uniform float4x4 unity_MatrixV;
      
      uniform float4x4 unity_MatrixInvV;
      
      uniform float4x4 UNITY_MATRIX_P;
      
      uniform float4 _Time;
      
      uniform float4 _SinTime;
      
      uniform float4 _CosTime;
      
      uniform float4 _ProjectionParams;
      
      uniform float4 _ScreenParams;
      
      uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float4 _LightPositionRange;
      
      uniform float4 _MainTex_ST;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION;
          
          float3 normal : NORMAL;
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord[1] : TEXCOORD[1];
          
          float3 textureCoordSplit : ;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 textureCoordSplit : ;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      
      
      float3x3 transpose(float3x3 mtx)
      {
          
          float3 c0 = mtx[0];
          
          float3 c1 = mtx[1];
          
          float3 c2 = mtx[2];
          
          
          return float3x3( float3(c0.x, c1.x, c2.x), float3(c0.y, c1.y, c2.y), float3(c0.z, c1.z, c2.z) );
      
      }
      
      float4x4 transpose(float4x4 mtx)
      {
          
          float4 c0 = mtx[0];
          
          float4 c1 = mtx[1];
          
          float4 c2 = mtx[2];
          
          float4 c3 = mtx[3];
          
          
          return float4x4( float4(c0.x, c1.x, c2.x, c3.x), float4(c0.y, c1.y, c2.y, c3.y), float4(c0.z, c1.z, c2.z, c3.z), float4(c0.w, c1.w, c2.w, c3.w) );
      
      }
      
      
      
      #line 54
      
      #line 61
      
      #line 4
      
      #line 1
      
      
      
      
      float saturate(float x)
      {
          
          return max(0.0, min(1.0, x));
      
      }
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      float2 ParallaxOffset( float h, float height, float3 viewDir )
      {
          
          h = h * height - height/2.0;
          
          float3 v = normalize(viewDir);
          
          v.z += 0.42;
          
          return h * (v.xy / v.z);
      
      }
      
      
      
      
      float Luminance( float3 c )
      {
          
          return dot( c, float3(0.22, 0.707, 0.071) );
      
      }
      
      
      
      
      #line 5
      
      #line 61
      
      
      
      
      
      
      
      
      
      
      
      
      #define CODE_BLOCK_VERTEX
      
      
      
      float3 WorldSpaceLightDir( float4 v )
      {
          
          float3 worldPos = (unity_ObjectToWorld * v).xyz;
          
          #ifndef USING_LIGHT_MULTI_COMPILE
          return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
          
          #else
          #ifndef USING_DIRECTIONAL_LIGHT
          return _WorldSpaceLightPos0.xyz - worldPos;
          
          #else
          return _WorldSpaceLightPos0.xyz;
          
          #endif
          #endif
      }
      
      
      
      float3 ObjSpaceLightDir( float4 v )
      {
          
          float3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
          
          #ifndef USING_LIGHT_MULTI_COMPILE
          return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
          
          #else
          #ifndef USING_DIRECTIONAL_LIGHT
          return objSpaceLightPos.xyz - v.xyz;
          
          #else
          return objSpaceLightPos.xyz;
          
          #endif
          #endif
      }
      
      
      
      float3 WorldSpaceViewDir( float4 v )
      {
          
          return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
      
      }
      
      
      
      float3 ObjSpaceViewDir( float4 v )
      {
          
          float3 objSpaceCameraPos = (unity_WorldToObject * float4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
          
          return objSpaceCameraPos - v.xyz;
      
      }
      
      
      
      
      
      
      
      
      
      
      
      
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          out_v.vertex = (unity_MatrixVP * unity_ObjectToWorld) * in_v.vertex;
          
          out_v.textureCoordSplit.xz = float2(0.5 * in_v.texcoord.x * _MainTex_ST.x, in_v.texcoord.y * _MainTex_ST.y) + _MainTex_ST.zw;
          
          out_v.textureCoordSplit.y = out_v.textureCoordSplit.x + 0.5 * _MainTex_ST.x;
      
      }
      
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      
      
      float4 AdjustForColorSpace(float4 color)
      {
          
          #if defined(UNITY_COLORSPACE_GAMMA)
      || !defined(ADJUST_TO_LINEARSPACE)
          return color;
          
          #else
          
          float3 sRGB = color.rgb;
          
          return float4(sRGB * (sRGB * (sRGB * 0.305306011 + 0.682171111) + 0.012522878), color.a);
          
          #endif
      }
      
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          out_f.color.rgb = AdjustForColorSpace(texture2D(_MainTex, in_f.textureCoordSplit.xz)).rgb;
          
          out_f.color.a = texture2D(_MainTex, in_f.textureCoordSplit.yz).g;
      
      }
      
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

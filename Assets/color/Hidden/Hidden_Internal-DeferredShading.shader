Shader "Hidden/Internal-DeferredShading"
{
  Properties
  {
    _LightTexture0 ("", any) = "" {}
    _LightTextureB0 ("", 2D) = "" {}
    _ShadowMapTexture ("", any) = "" {}
    _SrcBlend ("", float) = 1
    _DstBlend ("", float) = 1
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "SHADOWSUPPORT" = "true"
      }
      ZWrite Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float _LightAsQuad;
      
      uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 _ZBufferParams;
      
      uniform float4 unity_CameraToWorld[4];
      
      uniform float4 _LightPos;
      
      uniform float4 _LightColor;
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _LightTextureB0;
      
      uniform sampler2D _CameraGBufferTexture0;
      
      uniform sampler2D _CameraGBufferTexture1;
      
      uniform sampler2D _CameraGBufferTexture2;
      
      uniform sampler2D unity_NHxRoughness;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float4 u_xlat2;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.vertex = u_xlat1;
          
          u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
          
          u_xlat2.xzw = u_xlat1.xwy * float3(0.5, 0.5, 0.5);
          
          out_v.texcoord.zw = u_xlat1.zw;
          
          out_v.texcoord.xy = u_xlat2.zz + u_xlat2.xw;
          
          u_xlat1.xyz = u_xlat0.yyy * unity_MatrixV[1].xyz;
          
          u_xlat1.xyz = unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
          
          u_xlat0.xyz = unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
          
          u_xlat0.xyz = unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
          
          u_xlat1.xyz = u_xlat0.xyz * float3(-1.0, -1.0, 1.0);
          
          u_xlat0.xyz = (-u_xlat0.xyz) * float3(-1.0, -1.0, 1.0) + in_v.normal.xyz;
          
          out_v.texcoord1.xyz = float3(_LightAsQuad) * u_xlat0.xyz + u_xlat1.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float2 u_xlat1_d;
      
      float3 u_xlat16_1;
      
      float3 u_xlat2_d;
      
      float4 u_xlat16_2;
      
      float3 u_xlat3;
      
      float3 u_xlat16_3;
      
      float3 u_xlat4;
      
      float3 u_xlat16_5;
      
      float3 u_xlat16_6;
      
      float u_xlat15;
      
      float u_xlat21;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = _ProjectionParams.z / in_f.texcoord1.z;
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * in_f.texcoord1.xyz;
          
          u_xlat1_d.xy = in_f.texcoord.xy / in_f.texcoord.ww;
          
          u_xlat21 = texture(_CameraDepthTexture, u_xlat1_d.xy).x;
          
          u_xlat21 = _ZBufferParams.x * u_xlat21 + _ZBufferParams.y;
          
          u_xlat21 = float(1.0) / u_xlat21;
          
          u_xlat0_d.xyz = float3(u_xlat21) * u_xlat0_d.xyz;
          
          u_xlat2_d.xyz = u_xlat0_d.yyy * unity_CameraToWorld[1].xyz;
          
          u_xlat0_d.xyw = unity_CameraToWorld[0].xyz * u_xlat0_d.xxx + u_xlat2_d.xyz;
          
          u_xlat0_d.xyz = unity_CameraToWorld[2].xyz * u_xlat0_d.zzz + u_xlat0_d.xyw;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz + unity_CameraToWorld[3].xyz;
          
          u_xlat2_d.xyz = u_xlat0_d.xyz + (-_WorldSpaceCameraPos.xyz);
          
          u_xlat0_d.xyz = u_xlat0_d.xyz + (-_LightPos.xyz);
          
          u_xlat21 = dot(u_xlat2_d.xyz, u_xlat2_d.xyz);
          
          u_xlat21 = inversesqrt(u_xlat21);
          
          u_xlat2_d.xyz = float3(u_xlat21) * u_xlat2_d.xyz;
          
          u_xlat16_3.xyz = texture(_CameraGBufferTexture2, u_xlat1_d.xy).xyz;
          
          u_xlat3.xyz = u_xlat16_3.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
          
          u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
          
          u_xlat21 = inversesqrt(u_xlat21);
          
          u_xlat3.xyz = float3(u_xlat21) * u_xlat3.xyz;
          
          u_xlat21 = dot((-u_xlat2_d.xyz), u_xlat3.xyz);
          
          u_xlat21 = u_xlat21 + u_xlat21;
          
          u_xlat2_d.xyz = u_xlat3.xyz * (-float3(u_xlat21)) + (-u_xlat2_d.xyz);
          
          u_xlat21 = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          
          u_xlat15 = inversesqrt(u_xlat21);
          
          u_xlat21 = u_xlat21 * _LightPos.w;
          
          u_xlat21 = texture(_LightTextureB0, float2(u_xlat21)).x;
          
          u_xlat4.xyz = float3(u_xlat21) * _LightColor.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * float3(u_xlat15);
          
          u_xlat21 = dot(u_xlat2_d.xyz, (-u_xlat0_d.xyz));
          
          u_xlat0_d.x = dot(u_xlat3.xyz, (-u_xlat0_d.xyz));
          
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          u_xlat16_5.xyz = u_xlat0_d.xxx * u_xlat4.xyz;
          
          u_xlat0_d.x = u_xlat21 * u_xlat21;
          
          u_xlat0_d.x = u_xlat0_d.x * u_xlat0_d.x;
          
          u_xlat16_2 = texture(_CameraGBufferTexture1, u_xlat1_d.xy);
          
          u_xlat16_1.xyz = texture(_CameraGBufferTexture0, u_xlat1_d.xy).xyz;
          
          u_xlat0_d.y = (-u_xlat16_2.w) + 1.0;
          
          u_xlat0_d.x = texture(unity_NHxRoughness, u_xlat0_d.xy).x;
          
          u_xlat0_d.x = u_xlat0_d.x * 16.0;
          
          u_xlat16_6.xyz = u_xlat0_d.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
          
          u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
          
          u_xlat16_0.w = 1.0;
          
          out_f.color = exp2((-u_xlat16_0));
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
      }
      ZTest Always
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 255
      } 
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform sampler2D _LightBuffer;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_LightBuffer, in_f.texcoord.xy);
          
          u_xlat0_d = log2(u_xlat16_0);
          
          out_f.color = (-u_xlat0_d);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

Shader "Hidden/Internal-CombineDepthNormals"
{
  Properties
  {
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
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _CameraNormalsTexture_ST;
      
      uniform float4 _ZBufferParams;
      
      uniform float4 unity_WorldToCamera[4];
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _CameraNormalsTexture;
      
      
      
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
          
          out_v.texcoord.xy = in_v.texcoord.xy * _CameraNormalsTexture_ST.xy + _CameraNormalsTexture_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float3 u_xlat16_0;
      
      float3 u_xlat1_d;
      
      int u_xlatb3;
      
      float u_xlat4;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.xyz = texture(_CameraNormalsTexture, in_f.texcoord.xy).xyz;
          
          u_xlat0_d.xyz = u_xlat16_0.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
          
          u_xlat1_d.xyz = u_xlat0_d.yyy * unity_WorldToCamera[1].xyz;
          
          u_xlat0_d.xyw = unity_WorldToCamera[0].xyz * u_xlat0_d.xxx + u_xlat1_d.xyz;
          
          u_xlat0_d.xyz = unity_WorldToCamera[2].xyz * u_xlat0_d.zzz + u_xlat0_d.xyw;
          
          u_xlat4 = (-u_xlat0_d.z) + 1.0;
          
          u_xlat0_d.xy = u_xlat0_d.xy / float2(u_xlat4);
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.281262308, 0.281262308) + float2(0.5, 0.5);
          
          u_xlat1_d.x = texture(_CameraDepthTexture, in_f.texcoord.xy).x;
          
          u_xlat1_d.x = _ZBufferParams.x * u_xlat1_d.x + _ZBufferParams.y;
          
          u_xlat1_d.x = float(1.0) / u_xlat1_d.x;
          
          u_xlatb3 = u_xlat1_d.x<0.999984622;
          
          u_xlat1_d.xz = u_xlat1_d.xx * float2(1.0, 255.0);
          
          u_xlat1_d.xz = fract(u_xlat1_d.xz);
          
          u_xlat0_d.z = (-u_xlat1_d.z) * 0.00392156886 + u_xlat1_d.x;
          
          u_xlat0_d.w = u_xlat1_d.z;
          
          u_xlat0_d = (int(u_xlatb3)) ? u_xlat0_d : float4(0.5, 0.5, 1.0, 1.0);
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

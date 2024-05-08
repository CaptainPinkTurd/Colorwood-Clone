Shader "Hidden/FrameDebuggerRenderTargetDisplay"
{
  Properties
  {
    _MainTex ("", any) = "black" {}
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
      
      uniform int _UndoOutputSRGB;
      
      uniform int _ShouldYFlip;
      
      uniform float4 _Levels;
      
      uniform float4 _Channels;
      
      uniform float _MainTexWidth;
      
      uniform float _MainTexHeight;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord : TEXCOORD0;
      
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
          
          out_v.texcoord.xyz = in_v.texcoord.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      
      float4 u_xlat0_d;
      
      int4 u_xlatu0;
      
      float u_xlat16_1;
      
      float3 u_xlat2;
      
      float3 u_xlat3;
      
      float u_xlat6;
      
      int u_xlatb6;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = (-in_f.texcoord.y) + 1.0;
          
          u_xlat0_d.y = (_ShouldYFlip != 0) ? u_xlat0_d.x : in_f.texcoord.y;
          
          u_xlat0_d.x = in_f.texcoord.x;
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(_MainTexWidth, _MainTexHeight);
          
          u_xlatu0.xy = int2(int2(u_xlat0_d.xy));
          
          u_xlatu0.z = int(0);
          
          u_xlatu0.w = int(0);
          
          u_xlat0_d = texelFetch(_MainTex, int2(u_xlatu0.xy), int(u_xlatu0.w));
          
          u_xlat0_d = u_xlat0_d + (-_Levels.xxxx);
          
          u_xlat16_1 = (-_Levels.x) + _Levels.y;
          
          u_xlat0_d = u_xlat0_d / float4(u_xlat16_1);
          
          u_xlat0_d = u_xlat0_d * _Channels;
          
          u_xlat2.x = dot(u_xlat0_d, float4(1.0, 1.0, 1.0, 1.0));
          
          u_xlat6 = dot(_Channels, float4(1.0, 1.0, 1.0, 1.0));
          
          u_xlatb6 = u_xlat6==1.0;
          
          u_xlat0_d = (int(u_xlatb6)) ? u_xlat2.xxxx : u_xlat0_d;
          
          u_xlat2.xyz = u_xlat0_d.xyz;
          
          u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
          
          u_xlat3.xyz = u_xlat2.xyz * float3(0.305306017, 0.305306017, 0.305306017) + float3(0.682171106, 0.682171106, 0.682171106);
          
          u_xlat3.xyz = u_xlat2.xyz * u_xlat3.xyz + float3(0.0125228781, 0.0125228781, 0.0125228781);
          
          u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
          
          out_f.color.xyz = (_UndoOutputSRGB != 0) ? u_xlat2.xyz : u_xlat0_d.xyz;
          
          out_f.color.w = u_xlat0_d.w;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

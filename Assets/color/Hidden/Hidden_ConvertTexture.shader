Shader "Hidden/ConvertTexture"
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
      
      float4 ImmCB_1[10];
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float _faceIndex;
      
      uniform samplerCUBE _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
      
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
      
      float3 u_xlat2;
      
      float3 u_xlat3;
      
      int u_xlati4;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          ImmCB_1[0] = float4(0.0,0.0,-1.0,0.0);
          
          ImmCB_1[1] = float4(0.0,0.0,1.0,0.0);
          
          ImmCB_1[2] = float4(1.0,0.0,0.0,0.0);
          
          ImmCB_1[3] = float4(1.0,0.0,0.0,0.0);
          
          ImmCB_1[4] = float4(1.0,0.0,0.0,-1.0);
          
          ImmCB_1[5] = float4(-1.0,0.0,0.0,-1.0);
          
          ImmCB_1[6] = float4(0.0,0.0,1.0,0.0);
          
          ImmCB_1[7] = float4(0.0,0.0,-1.0,0.0);
          
          ImmCB_1[8] = float4(0.0,0.0,0.0,-1.0);
          
          ImmCB_1[9] = float4(0.0,0.0,0.0,-1.0);
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat0.x = 0.0;
          
          u_xlat1.z = 0.0;
          
          u_xlati4 = int(_faceIndex);
          
          u_xlat1.xy = ImmCB_1[u_xlati4].zx * ImmCB_1[u_xlati4 + 4].wz;
          
          u_xlat2.xz = ImmCB_1[u_xlati4 + 4].zw;
          
          u_xlat2.y = ImmCB_1[u_xlati4].z;
          
          u_xlat0.z = ImmCB_1[u_xlati4].x;
          
          u_xlat0.xzw = (-u_xlat2.xyz) * u_xlat0.xxz + u_xlat1.xyz;
          
          u_xlat1.y = 0.0;
          
          u_xlat2.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          u_xlat2.xy = u_xlat2.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          u_xlat1.xz = ImmCB_1[u_xlati4].xz;
          
          u_xlat3.yz = ImmCB_1[u_xlati4 + 4].wz;
          
          u_xlat0.xyz = u_xlat2.xxx * u_xlat1.xyz + u_xlat0.xzw;
          
          u_xlat3.x = 0.0;
          
          out_v.texcoord.xyz = u_xlat2.yyy * u_xlat3.xyz + u_xlat0.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xyz);
          
          out_f.color = u_xlat16_0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

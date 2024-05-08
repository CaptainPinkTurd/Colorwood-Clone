Shader "Hidden/Internal-DepthNormalsTexture"
{
  Properties
  {
    _MainTex ("", 2D) = "white" {}
    _Cutoff ("", float) = 0.5
    _Color ("", Color) = (1,1,1,1)
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "Opaque"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixInvV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat2;
      
      float u_xlat6;
      
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
          
          u_xlat2 = u_xlat0.y * unity_MatrixV[1].z;
          
          u_xlat0.x = unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
          
          u_xlat0.x = unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
          
          u_xlat0.x = u_xlat0.x * _ProjectionParams.w;
          
          out_v.texcoord.w = (-u_xlat0.x);
          
          u_xlat0.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[0].yyy;
          
          u_xlat0.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[0].xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[0].zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[0].www + u_xlat0.xyz;
          
          u_xlat0.x = dot(u_xlat0.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[1].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[1].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[1].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[1].www + u_xlat1.xyz;
          
          u_xlat0.y = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[2].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[2].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[2].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[2].www + u_xlat1.xyz;
          
          u_xlat0.z = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          out_v.texcoord.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float2 u_xlat1_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = in_f.texcoord.z + 1.0;
          
          u_xlat0_d.xy = in_f.texcoord.xy / u_xlat0_d.xx;
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.281262308, 0.281262308) + float2(0.5, 0.5);
          
          u_xlat1_d.xy = in_f.texcoord.ww * float2(1.0, 255.0);
          
          u_xlat1_d.xy = fract(u_xlat1_d.xy);
          
          u_xlat0_d.z = (-u_xlat1_d.y) * 0.00392156886 + u_xlat1_d.x;
          
          u_xlat0_d.w = u_xlat1_d.y;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TransparentCutout"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TransparentCutout"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixInvV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float _Cutoff;
      
      uniform float4 _Color;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat2;
      
      float u_xlat6;
      
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
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          u_xlat2 = u_xlat0.y * unity_MatrixV[1].z;
          
          u_xlat0.x = unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
          
          u_xlat0.x = unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
          
          u_xlat0.x = u_xlat0.x * _ProjectionParams.w;
          
          out_v.texcoord1.w = (-u_xlat0.x);
          
          u_xlat0.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[0].yyy;
          
          u_xlat0.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[0].xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[0].zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[0].www + u_xlat0.xyz;
          
          u_xlat0.x = dot(u_xlat0.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[1].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[1].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[1].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[1].www + u_xlat1.xyz;
          
          u_xlat0.y = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[2].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[2].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[2].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[2].www + u_xlat1.xyz;
          
          u_xlat0.z = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          out_v.texcoord1.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float u_xlat16_0;
      
      int u_xlatb0;
      
      float u_xlat16_1;
      
      float2 u_xlat2_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy).w;
          
          u_xlat16_1 = u_xlat16_0 * _Color.w + (-_Cutoff);
          
          u_xlatb0 = u_xlat16_1<0.0;
          
          if(u_xlatb0)
      {
              discard;
      }
          
          u_xlat0_d.x = in_f.texcoord1.z + 1.0;
          
          u_xlat0_d.xy = in_f.texcoord1.xy / u_xlat0_d.xx;
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.281262308, 0.281262308) + float2(0.5, 0.5);
          
          u_xlat2_d.xy = in_f.texcoord1.ww * float2(1.0, 255.0);
          
          u_xlat2_d.xy = fract(u_xlat2_d.xy);
          
          u_xlat0_d.z = (-u_xlat2_d.y) * 0.00392156886 + u_xlat2_d.x;
          
          u_xlat0_d.w = u_xlat2_d.y;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TreeBark"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TreeBark"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _Time;
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixInvV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _TreeInstanceScale;
      
      uniform float4 _SquashPlaneNormal;
      
      uniform float _SquashAmount;
      
      uniform float4 _Wind;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float4 u_xlat2;
      
      float3 u_xlat3;
      
      float u_xlat4;
      
      float u_xlat8;
      
      float u_xlat12;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.x = dot(unity_ObjectToWorld[3].xyz, float3(1.0, 1.0, 1.0));
          
          u_xlat0.y = u_xlat0.x + in_v.color.x;
          
          u_xlat8 = u_xlat0.y + in_v.color.y;
          
          u_xlat1.xyz = in_v.vertex.xyz * _TreeInstanceScale.xyz;
          
          u_xlat0.x = dot(u_xlat1.xyz, float3(u_xlat8));
          
          u_xlat0 = u_xlat0.xxyy + _Time.yyyy;
          
          u_xlat0 = u_xlat0 * float4(1.97500002, 0.792999983, 0.375, 0.193000004);
          
          u_xlat0 = fract(u_xlat0);
          
          u_xlat0 = u_xlat0 * float4(2.0, 2.0, 2.0, 2.0) + float4(-0.5, -0.5, -0.5, -0.5);
          
          u_xlat0 = fract(u_xlat0);
          
          u_xlat0 = u_xlat0 * float4(2.0, 2.0, 2.0, 2.0) + float4(-1.0, -1.0, -1.0, -1.0);
          
          u_xlat2 = abs(u_xlat0) * abs(u_xlat0);
          
          u_xlat0 = -abs(u_xlat0) * float4(2.0, 2.0, 2.0, 2.0) + float4(3.0, 3.0, 3.0, 3.0);
          
          u_xlat0 = u_xlat0 * u_xlat2;
          
          u_xlat0.xy = u_xlat0.yw + u_xlat0.xz;
          
          u_xlat2.xyz = u_xlat0.yyy * _Wind.xyz;
          
          u_xlat2.xyz = u_xlat2.xyz * in_v.texcoord1.yyy;
          
          u_xlat3.y = u_xlat0.y * in_v.texcoord1.y;
          
          u_xlat4 = in_v.color.y * 0.100000001;
          
          u_xlat3.xz = float2(u_xlat4) * in_v.normal.xz;
          
          u_xlat0.z = 0.300000012;
          
          u_xlat0.xyz = u_xlat0.xzx * u_xlat3.xyz + u_xlat2.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz * _Wind.www + u_xlat1.xyz;
          
          u_xlat0.xyz = in_v.texcoord1.xxx * _Wind.xyz + u_xlat0.xyz;
          
          u_xlat12 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
          
          u_xlat12 = u_xlat12 + _SquashPlaneNormal.w;
          
          u_xlat1.xyz = (-float3(u_xlat12)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
          
          u_xlat0.xyz = float3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
          
          u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
          
          u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          u_xlat4 = u_xlat0.y * unity_MatrixV[1].z;
          
          u_xlat0.x = unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
          
          u_xlat0.x = unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
          
          u_xlat0.x = u_xlat0.x * _ProjectionParams.w;
          
          out_v.texcoord1.w = (-u_xlat0.x);
          
          u_xlat0.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[0].yyy;
          
          u_xlat0.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[0].xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[0].zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[0].www + u_xlat0.xyz;
          
          u_xlat12 = dot(in_v.normal.xyz, in_v.normal.xyz);
          
          u_xlat12 = inversesqrt(u_xlat12);
          
          u_xlat1.xyz = float3(u_xlat12) * in_v.normal.xyz;
          
          u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
          
          u_xlat2.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[1].yyy;
          
          u_xlat2.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[1].xxx + u_xlat2.xyz;
          
          u_xlat2.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[1].zzz + u_xlat2.xyz;
          
          u_xlat2.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[1].www + u_xlat2.xyz;
          
          u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
          
          u_xlat2.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[2].yyy;
          
          u_xlat2.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[2].xxx + u_xlat2.xyz;
          
          u_xlat2.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[2].zzz + u_xlat2.xyz;
          
          u_xlat2.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[2].www + u_xlat2.xyz;
          
          u_xlat0.z = dot(u_xlat2.xyz, u_xlat1.xyz);
          
          u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat12 = inversesqrt(u_xlat12);
          
          out_v.texcoord1.xyz = float3(u_xlat12) * u_xlat0.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float2 u_xlat1_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = in_f.texcoord1.z + 1.0;
          
          u_xlat0_d.xy = in_f.texcoord1.xy / u_xlat0_d.xx;
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.281262308, 0.281262308) + float2(0.5, 0.5);
          
          u_xlat1_d.xy = in_f.texcoord1.ww * float2(1.0, 255.0);
          
          u_xlat1_d.xy = fract(u_xlat1_d.xy);
          
          u_xlat0_d.z = (-u_xlat1_d.y) * 0.00392156886 + u_xlat1_d.x;
          
          u_xlat0_d.w = u_xlat1_d.y;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TreeLeaf"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TreeLeaf"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _Time;
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixInvV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _TreeInstanceScale;
      
      uniform float4 _SquashPlaneNormal;
      
      uniform float _SquashAmount;
      
      uniform float4 _Wind;
      
      uniform float _Cutoff;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 tangent : TANGENT0;
          
          float3 normal : NORMAL0;
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float4 u_xlat2;
      
      float4 u_xlat3;
      
      float4 u_xlat4;
      
      float4 u_xlat5;
      
      float3 u_xlat6;
      
      float4 u_xlat7;
      
      float u_xlat24;
      
      float u_xlat25;
      
      float u_xlat26;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = unity_WorldToObject[1] * unity_MatrixInvV[1].yyyy;
          
          u_xlat0 = unity_WorldToObject[0] * unity_MatrixInvV[1].xxxx + u_xlat0;
          
          u_xlat0 = unity_WorldToObject[2] * unity_MatrixInvV[1].zzzz + u_xlat0;
          
          u_xlat0 = unity_WorldToObject[3] * unity_MatrixInvV[1].wwww + u_xlat0;
          
          u_xlat1 = u_xlat0 * in_v.normal.yyyy;
          
          u_xlat2 = unity_WorldToObject[1] * unity_MatrixInvV[0].yyyy;
          
          u_xlat2 = unity_WorldToObject[0] * unity_MatrixInvV[0].xxxx + u_xlat2;
          
          u_xlat2 = unity_WorldToObject[2] * unity_MatrixInvV[0].zzzz + u_xlat2;
          
          u_xlat2 = unity_WorldToObject[3] * unity_MatrixInvV[0].wwww + u_xlat2;
          
          u_xlat1 = in_v.normal.xxxx * u_xlat2 + u_xlat1;
          
          u_xlat24 = -abs(in_v.tangent.w) + 1.0;
          
          u_xlat3.xyz = u_xlat1.xyz * float3(u_xlat24) + in_v.vertex.xyz;
          
          u_xlat3.xyz = u_xlat3.xyz * _TreeInstanceScale.xyz;
          
          u_xlat26 = dot(unity_ObjectToWorld[3].xyz, float3(1.0, 1.0, 1.0));
          
          u_xlat4.y = u_xlat26 + in_v.color.x;
          
          u_xlat26 = u_xlat4.y + in_v.color.y;
          
          u_xlat4.x = dot(u_xlat3.xyz, float3(u_xlat26));
          
          u_xlat4 = u_xlat4.xxyy + _Time.yyyy;
          
          u_xlat4 = u_xlat4 * float4(1.97500002, 0.792999983, 0.375, 0.193000004);
          
          u_xlat4 = fract(u_xlat4);
          
          u_xlat4 = u_xlat4 * float4(2.0, 2.0, 2.0, 2.0) + float4(-0.5, -0.5, -0.5, -0.5);
          
          u_xlat4 = fract(u_xlat4);
          
          u_xlat4 = u_xlat4 * float4(2.0, 2.0, 2.0, 2.0) + float4(-1.0, -1.0, -1.0, -1.0);
          
          u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
          
          u_xlat4 = -abs(u_xlat4) * float4(2.0, 2.0, 2.0, 2.0) + float4(3.0, 3.0, 3.0, 3.0);
          
          u_xlat4 = u_xlat4 * u_xlat5;
          
          u_xlat4.xy = u_xlat4.yw + u_xlat4.xz;
          
          u_xlat5.xyz = u_xlat4.yyy * _Wind.xyz;
          
          u_xlat5.xyz = u_xlat5.xyz * in_v.texcoord1.yyy;
          
          u_xlat6.y = u_xlat4.y * in_v.texcoord1.y;
          
          u_xlat7 = unity_WorldToObject[1] * unity_MatrixInvV[2].yyyy;
          
          u_xlat7 = unity_WorldToObject[0] * unity_MatrixInvV[2].xxxx + u_xlat7;
          
          u_xlat7 = unity_WorldToObject[2] * unity_MatrixInvV[2].zzzz + u_xlat7;
          
          u_xlat7 = unity_WorldToObject[3] * unity_MatrixInvV[2].wwww + u_xlat7;
          
          u_xlat1 = in_v.normal.zzzz * u_xlat7 + u_xlat1;
          
          u_xlat25 = dot(u_xlat1, u_xlat1);
          
          u_xlat25 = inversesqrt(u_xlat25);
          
          u_xlat1.xyz = u_xlat1.xyz * float3(u_xlat25) + (-in_v.normal.xyz);
          
          u_xlat1.xyz = float3(u_xlat24) * u_xlat1.xyz + in_v.normal.xyz;
          
          u_xlat24 = in_v.color.y * 0.100000001;
          
          u_xlat6.xz = u_xlat1.xz * float2(u_xlat24);
          
          u_xlat4.z = 0.300000012;
          
          u_xlat4.xyz = u_xlat4.xzx * u_xlat6.xyz + u_xlat5.xyz;
          
          u_xlat3.xyz = u_xlat4.xyz * _Wind.www + u_xlat3.xyz;
          
          u_xlat3.xyz = in_v.texcoord1.xxx * _Wind.xyz + u_xlat3.xyz;
          
          u_xlat24 = dot(_SquashPlaneNormal.xyz, u_xlat3.xyz);
          
          u_xlat24 = u_xlat24 + _SquashPlaneNormal.w;
          
          u_xlat4.xyz = (-float3(u_xlat24)) * _SquashPlaneNormal.xyz + u_xlat3.xyz;
          
          u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
          
          u_xlat3.xyz = float3(_SquashAmount) * u_xlat3.xyz + u_xlat4.xyz;
          
          u_xlat4 = u_xlat3.yyyy * unity_ObjectToWorld[1];
          
          u_xlat4 = unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat4;
          
          u_xlat3 = unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat4;
          
          u_xlat3 = u_xlat3 + unity_ObjectToWorld[3];
          
          u_xlat4 = u_xlat3.yyyy * unity_MatrixVP[1];
          
          u_xlat4 = unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
          
          u_xlat4 = unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat24 = inversesqrt(u_xlat24);
          
          u_xlat1.xyz = float3(u_xlat24) * u_xlat1.xyz;
          
          u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
          
          u_xlat2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
          
          u_xlat2.z = dot(u_xlat7.xyz, u_xlat1.xyz);
          
          u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
          
          u_xlat0.x = inversesqrt(u_xlat0.x);
          
          out_v.texcoord1.xyz = u_xlat0.xxx * u_xlat2.xyz;
          
          u_xlat0.x = u_xlat3.y * unity_MatrixV[1].z;
          
          u_xlat0.x = unity_MatrixV[0].z * u_xlat3.x + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[2].z * u_xlat3.z + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[3].z * u_xlat3.w + u_xlat0.x;
          
          u_xlat0.x = u_xlat0.x * _ProjectionParams.w;
          
          out_v.texcoord1.w = (-u_xlat0.x);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float u_xlat16_0;
      
      int u_xlatb0;
      
      float u_xlat16_1;
      
      float2 u_xlat2_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy).w;
          
          u_xlat16_1 = u_xlat16_0 + (-_Cutoff);
          
          u_xlatb0 = u_xlat16_1<0.0;
          
          if(u_xlatb0)
      {
              discard;
      }
          
          u_xlat0_d.x = in_f.texcoord1.z + 1.0;
          
          u_xlat0_d.xy = in_f.texcoord1.xy / u_xlat0_d.xx;
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.281262308, 0.281262308) + float2(0.5, 0.5);
          
          u_xlat2_d.xy = in_f.texcoord1.ww * float2(1.0, 255.0);
          
          u_xlat2_d.xy = fract(u_xlat2_d.xy);
          
          u_xlat0_d.z = (-u_xlat2_d.y) * 0.00392156886 + u_xlat2_d.x;
          
          u_xlat0_d.w = u_xlat2_d.y;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "DisableBatching" = "true"
      "RenderType" = "TreeOpaque"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "DisableBatching" = "true"
        "RenderType" = "TreeOpaque"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixInvV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _TreeInstanceScale;
      
      uniform float4 _TerrainEngineBendTree[4];
      
      uniform float4 _SquashPlaneNormal;
      
      uniform float _SquashAmount;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat2;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.vertex.xyz * _TreeInstanceScale.xyz;
          
          u_xlat1.xyz = u_xlat0.yyy * _TerrainEngineBendTree[1].xyz;
          
          u_xlat1.xyz = _TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = _TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = (-in_v.vertex.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
          
          u_xlat0.xyz = in_v.color.www * u_xlat1.xyz + u_xlat0.xyz;
          
          u_xlat6 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
          
          u_xlat6 = u_xlat6 + _SquashPlaneNormal.w;
          
          u_xlat1.xyz = (-float3(u_xlat6)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
          
          u_xlat0.xyz = float3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
          
          u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
          
          u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat2 = u_xlat0.y * unity_MatrixV[1].z;
          
          u_xlat0.x = unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
          
          u_xlat0.x = unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
          
          u_xlat0.x = u_xlat0.x * _ProjectionParams.w;
          
          out_v.texcoord.w = (-u_xlat0.x);
          
          u_xlat0.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[0].yyy;
          
          u_xlat0.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[0].xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[0].zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[0].www + u_xlat0.xyz;
          
          u_xlat0.x = dot(u_xlat0.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[1].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[1].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[1].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[1].www + u_xlat1.xyz;
          
          u_xlat0.y = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[2].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[2].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[2].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[2].www + u_xlat1.xyz;
          
          u_xlat0.z = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          out_v.texcoord.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float2 u_xlat1_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = in_f.texcoord.z + 1.0;
          
          u_xlat0_d.xy = in_f.texcoord.xy / u_xlat0_d.xx;
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.281262308, 0.281262308) + float2(0.5, 0.5);
          
          u_xlat1_d.xy = in_f.texcoord.ww * float2(1.0, 255.0);
          
          u_xlat1_d.xy = fract(u_xlat1_d.xy);
          
          u_xlat0_d.z = (-u_xlat1_d.y) * 0.00392156886 + u_xlat1_d.x;
          
          u_xlat0_d.w = u_xlat1_d.y;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "DisableBatching" = "true"
      "RenderType" = "TreeTransparentCutout"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "DisableBatching" = "true"
        "RenderType" = "TreeTransparentCutout"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixInvV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _TreeInstanceScale;
      
      uniform float4 _TerrainEngineBendTree[4];
      
      uniform float4 _SquashPlaneNormal;
      
      uniform float _SquashAmount;
      
      uniform float _Cutoff;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float4 color : COLOR0;
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat2;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.vertex.xyz * _TreeInstanceScale.xyz;
          
          u_xlat1.xyz = u_xlat0.yyy * _TerrainEngineBendTree[1].xyz;
          
          u_xlat1.xyz = _TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = _TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = (-in_v.vertex.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
          
          u_xlat0.xyz = in_v.color.www * u_xlat1.xyz + u_xlat0.xyz;
          
          u_xlat6 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
          
          u_xlat6 = u_xlat6 + _SquashPlaneNormal.w;
          
          u_xlat1.xyz = (-float3(u_xlat6)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
          
          u_xlat0.xyz = float3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
          
          u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
          
          u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          u_xlat2 = u_xlat0.y * unity_MatrixV[1].z;
          
          u_xlat0.x = unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
          
          u_xlat0.x = unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
          
          u_xlat0.x = u_xlat0.x * _ProjectionParams.w;
          
          out_v.texcoord1.w = (-u_xlat0.x);
          
          u_xlat0.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[0].yyy;
          
          u_xlat0.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[0].xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[0].zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[0].www + u_xlat0.xyz;
          
          u_xlat0.x = dot(u_xlat0.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[1].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[1].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[1].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[1].www + u_xlat1.xyz;
          
          u_xlat0.y = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[2].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[2].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[2].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[2].www + u_xlat1.xyz;
          
          u_xlat0.z = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          out_v.texcoord1.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float u_xlat16_0;
      
      int u_xlatb0;
      
      float u_xlat16_1;
      
      float2 u_xlat2_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy).w;
          
          u_xlat16_1 = u_xlat16_0 + (-_Cutoff);
          
          u_xlatb0 = u_xlat16_1<0.0;
          
          if(u_xlatb0)
      {
              discard;
      }
          
          u_xlat0_d.x = in_f.texcoord1.z + 1.0;
          
          u_xlat0_d.xy = in_f.texcoord1.xy / u_xlat0_d.xx;
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.281262308, 0.281262308) + float2(0.5, 0.5);
          
          u_xlat2_d.xy = in_f.texcoord1.ww * float2(1.0, 255.0);
          
          u_xlat2_d.xy = fract(u_xlat2_d.xy);
          
          u_xlat0_d.z = (-u_xlat2_d.y) * 0.00392156886 + u_xlat2_d.x;
          
          u_xlat0_d.w = u_xlat2_d.y;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "DisableBatching" = "true"
        "RenderType" = "TreeTransparentCutout"
      }
      Cull Front
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixInvV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _TreeInstanceScale;
      
      uniform float4 _TerrainEngineBendTree[4];
      
      uniform float4 _SquashPlaneNormal;
      
      uniform float _SquashAmount;
      
      uniform float _Cutoff;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float4 color : COLOR0;
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat2;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.vertex.xyz * _TreeInstanceScale.xyz;
          
          u_xlat1.xyz = u_xlat0.yyy * _TerrainEngineBendTree[1].xyz;
          
          u_xlat1.xyz = _TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = _TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = (-in_v.vertex.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
          
          u_xlat0.xyz = in_v.color.www * u_xlat1.xyz + u_xlat0.xyz;
          
          u_xlat6 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
          
          u_xlat6 = u_xlat6 + _SquashPlaneNormal.w;
          
          u_xlat1.xyz = (-float3(u_xlat6)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
          
          u_xlat0.xyz = float3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
          
          u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
          
          u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          u_xlat2 = u_xlat0.y * unity_MatrixV[1].z;
          
          u_xlat0.x = unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
          
          u_xlat0.x = unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
          
          u_xlat0.x = u_xlat0.x * _ProjectionParams.w;
          
          out_v.texcoord1.w = (-u_xlat0.x);
          
          u_xlat0.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[0].yyy;
          
          u_xlat0.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[0].xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[0].zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[0].www + u_xlat0.xyz;
          
          u_xlat0.x = dot(u_xlat0.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[1].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[1].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[1].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[1].www + u_xlat1.xyz;
          
          u_xlat0.y = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[2].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[2].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[2].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[2].www + u_xlat1.xyz;
          
          u_xlat0.z = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          out_v.texcoord1.xyz = (-u_xlat0.xyz);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float u_xlat16_0;
      
      int u_xlatb0;
      
      float u_xlat16_1;
      
      float2 u_xlat2_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy).w;
          
          u_xlat16_1 = u_xlat16_0 + (-_Cutoff);
          
          u_xlatb0 = u_xlat16_1<0.0;
          
          if(u_xlatb0)
      {
              discard;
      }
          
          u_xlat0_d.x = in_f.texcoord1.z + 1.0;
          
          u_xlat0_d.xy = in_f.texcoord1.xy / u_xlat0_d.xx;
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.281262308, 0.281262308) + float2(0.5, 0.5);
          
          u_xlat2_d.xy = in_f.texcoord1.ww * float2(1.0, 255.0);
          
          u_xlat2_d.xy = fract(u_xlat2_d.xy);
          
          u_xlat0_d.z = (-u_xlat2_d.y) * 0.00392156886 + u_xlat2_d.x;
          
          u_xlat0_d.w = u_xlat2_d.y;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TreeBillboard"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TreeBillboard"
      }
      Cull Off
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
      
      uniform float3 _TreeBillboardCameraRight;
      
      uniform float4 _TreeBillboardCameraUp;
      
      uniform float4 _TreeBillboardCameraFront;
      
      uniform float4 _TreeBillboardCameraPos;
      
      uniform float4 _TreeBillboardDistances;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 texcoord : TEXCOORD0;
          
          float2 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      int u_xlatb0;
      
      float4 u_xlat1;
      
      int u_xlatb1;
      
      float u_xlat2;
      
      float u_xlat4;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.vertex.xyz + (-_TreeBillboardCameraPos.xyz);
          
          u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlatb0 = _TreeBillboardDistances.x<u_xlat0.x;
          
          u_xlat1.xy = in_v.texcoord1.xy;
          
          u_xlat1.z = in_v.texcoord.y;
          
          u_xlat0.xyz = (int(u_xlatb0)) ? float3(0.0, 0.0, 0.0) : u_xlat1.xyz;
          
          u_xlat4 = (-u_xlat0.y) + u_xlat0.z;
          
          u_xlat2 = _TreeBillboardCameraPos.w * u_xlat4 + u_xlat0.y;
          
          u_xlat1.xyz = float3(_TreeBillboardCameraRight.x, _TreeBillboardCameraRight.y, _TreeBillboardCameraRight.z) * u_xlat0.xxx + in_v.vertex.xyz;
          
          u_xlat0.xzw = abs(u_xlat0.xxx) * _TreeBillboardCameraFront.xyz;
          
          u_xlat1.xyz = _TreeBillboardCameraUp.xyz * float3(u_xlat2) + u_xlat1.xyz;
          
          u_xlat0.xyz = u_xlat0.xzw * _TreeBillboardCameraUp.www + u_xlat1.xyz;
          
          u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
          
          u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlatb1 = 0.0<in_v.texcoord.y;
          
          out_v.texcoord.y = u_xlatb1 ? 1.0 : float(0.0);
          
          out_v.texcoord.x = in_v.texcoord.x;
          
          u_xlat2 = u_xlat0.y * unity_MatrixV[1].z;
          
          u_xlat0.x = unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
          
          u_xlat0.x = unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
          
          u_xlat0.x = u_xlat0.x * _ProjectionParams.w;
          
          out_v.texcoord1.w = (-u_xlat0.x);
          
          out_v.texcoord1.xyz = float3(0.0, 0.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float u_xlat16_0;
      
      int u_xlatb0_d;
      
      float u_xlat16_1;
      
      float2 u_xlat2_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy).w;
          
          u_xlat16_1 = u_xlat16_0 + -0.00100000005;
          
          u_xlatb0_d = u_xlat16_1<0.0;
          
          if(u_xlatb0_d)
      {
              discard;
      }
          
          u_xlat0_d.x = in_f.texcoord1.z + 1.0;
          
          u_xlat0_d.xy = in_f.texcoord1.xy / u_xlat0_d.xx;
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.281262308, 0.281262308) + float2(0.5, 0.5);
          
          u_xlat2_d.xy = in_f.texcoord1.ww * float2(1.0, 255.0);
          
          u_xlat2_d.xy = fract(u_xlat2_d.xy);
          
          u_xlat0_d.z = (-u_xlat2_d.y) * 0.00392156886 + u_xlat2_d.x;
          
          u_xlat0_d.w = u_xlat2_d.y;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "GrassBillboard"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "GrassBillboard"
      }
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixInvV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _WavingTint;
      
      uniform float4 _WaveAndDistance;
      
      uniform float4 _CameraPosition;
      
      uniform float3 _CameraRight;
      
      uniform float3 _CameraUp;
      
      uniform float _Cutoff;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 tangent : TANGENT0;
          
          float3 normal : NORMAL0;
          
          float4 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      int u_xlatb0;
      
      float4 u_xlat1;
      
      float4 u_xlat2;
      
      float4 u_xlat3;
      
      float3 u_xlat16_4;
      
      float u_xlat5;
      
      float u_xlat15;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.vertex.xyz + (-_CameraPosition.xyz);
          
          u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlatb0 = _WaveAndDistance.w<u_xlat0.x;
          
          u_xlat0.xy = (int(u_xlatb0)) ? float2(0.0, 0.0) : in_v.tangent.xy;
          
          u_xlat0.xzw = u_xlat0.xxx * _CameraRight.xyz + in_v.vertex.xyz;
          
          u_xlat0.xyz = u_xlat0.yyy * _CameraUp.xyz + u_xlat0.xzw;
          
          u_xlat1.xy = u_xlat0.xz * _WaveAndDistance.yy;
          
          u_xlat2 = u_xlat1.yyyy * float4(0.00600000005, 0.0199999996, 0.0199999996, 0.0500000007);
          
          u_xlat1 = u_xlat1.xxxx * float4(0.0120000001, 0.0199999996, 0.0599999987, 0.0240000002) + u_xlat2;
          
          u_xlat1 = _WaveAndDistance.xxxx * float4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat1;
          
          u_xlat1 = fract(u_xlat1);
          
          u_xlat1 = u_xlat1 * float4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + float4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
          
          u_xlat2 = u_xlat1 * u_xlat1;
          
          u_xlat3 = u_xlat1 * u_xlat2;
          
          u_xlat1 = u_xlat3 * float4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat1;
          
          u_xlat3 = u_xlat2 * u_xlat3;
          
          u_xlat2 = u_xlat2 * u_xlat3;
          
          u_xlat1 = u_xlat3 * float4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat1;
          
          u_xlat1 = u_xlat2 * float4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat1;
          
          u_xlat1 = u_xlat1 * u_xlat1;
          
          u_xlat1 = u_xlat1 * u_xlat1;
          
          u_xlat2 = u_xlat1 * in_v.tangent.yyyy;
          
          u_xlat15 = dot(u_xlat1, float4(0.674199879, 0.674199879, 0.269679934, 0.134839967));
          
          u_xlat15 = u_xlat15 * 0.699999988;
          
          u_xlat1.x = dot(u_xlat2, float4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
          
          u_xlat1.z = dot(u_xlat2, float4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
          
          u_xlat0.xz = (-u_xlat1.xz) * _WaveAndDistance.zz + u_xlat0.xz;
          
          u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
          
          u_xlat2.xyz = u_xlat0.xyz + (-_CameraPosition.xyz);
          
          u_xlat5 = dot(u_xlat2.xyz, u_xlat2.xyz);
          
          u_xlat5 = (-u_xlat5) + _WaveAndDistance.w;
          
          u_xlat5 = dot(_CameraPosition.ww, float2(u_xlat5));
          
          u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
          
          out_v.color.w = u_xlat5;
          
          u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat1 = u_xlat1 + unity_ObjectToWorld[3];
          
          u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
          
          u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
          
          u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
          
          u_xlat16_4.xyz = _WavingTint.xyz + float3(-0.5, -0.5, -0.5);
          
          u_xlat16_4.xyz = float3(u_xlat15) * u_xlat16_4.xyz + float3(0.5, 0.5, 0.5);
          
          u_xlat16_4.xyz = u_xlat16_4.xyz * in_v.color.xyz;
          
          out_v.color.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          u_xlat0.x = u_xlat1.y * unity_MatrixV[1].z;
          
          u_xlat0.x = unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
          
          u_xlat0.x = u_xlat0.x * _ProjectionParams.w;
          
          out_v.texcoord1.w = (-u_xlat0.x);
          
          u_xlat0.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[0].yyy;
          
          u_xlat0.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[0].xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[0].zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[0].www + u_xlat0.xyz;
          
          u_xlat0.x = dot(u_xlat0.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[1].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[1].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[1].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[1].www + u_xlat1.xyz;
          
          u_xlat0.y = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[2].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[2].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[2].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[2].www + u_xlat1.xyz;
          
          u_xlat0.z = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          out_v.texcoord1.xyz = float3(u_xlat15) * u_xlat0.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float u_xlat16_0;
      
      int u_xlatb0_d;
      
      float u_xlat16_1;
      
      float2 u_xlat2_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy).w;
          
          u_xlat16_1 = u_xlat16_0 * in_f.color.w + (-_Cutoff);
          
          u_xlatb0_d = u_xlat16_1<0.0;
          
          if(u_xlatb0_d)
      {
              discard;
      }
          
          u_xlat0_d.x = in_f.texcoord1.z + 1.0;
          
          u_xlat0_d.xy = in_f.texcoord1.xy / u_xlat0_d.xx;
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.281262308, 0.281262308) + float2(0.5, 0.5);
          
          u_xlat2_d.xy = in_f.texcoord1.ww * float2(1.0, 255.0);
          
          u_xlat2_d.xy = fract(u_xlat2_d.xy);
          
          u_xlat0_d.z = (-u_xlat2_d.y) * 0.00392156886 + u_xlat2_d.x;
          
          u_xlat0_d.w = u_xlat2_d.y;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Grass"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "Grass"
      }
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixInvV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _WavingTint;
      
      uniform float4 _WaveAndDistance;
      
      uniform float4 _CameraPosition;
      
      uniform float _Cutoff;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float4 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float4 u_xlat2;
      
      float4 u_xlat3;
      
      float3 u_xlat16_4;
      
      float u_xlat15;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xy = in_v.vertex.xz * _WaveAndDistance.yy;
          
          u_xlat1 = u_xlat0.yyyy * float4(0.00600000005, 0.0199999996, 0.0199999996, 0.0500000007);
          
          u_xlat0 = u_xlat0.xxxx * float4(0.0120000001, 0.0199999996, 0.0599999987, 0.0240000002) + u_xlat1;
          
          u_xlat0 = _WaveAndDistance.xxxx * float4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
          
          u_xlat0 = fract(u_xlat0);
          
          u_xlat0 = u_xlat0 * float4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + float4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
          
          u_xlat1 = u_xlat0 * u_xlat0;
          
          u_xlat2 = u_xlat0 * u_xlat1;
          
          u_xlat0 = u_xlat2 * float4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
          
          u_xlat2 = u_xlat1 * u_xlat2;
          
          u_xlat1 = u_xlat1 * u_xlat2;
          
          u_xlat0 = u_xlat2 * float4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
          
          u_xlat0 = u_xlat1 * float4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
          
          u_xlat0 = u_xlat0 * u_xlat0;
          
          u_xlat0 = u_xlat0 * u_xlat0;
          
          u_xlat1.x = in_v.color.w * _WaveAndDistance.z;
          
          u_xlat1 = u_xlat0 * u_xlat1.xxxx;
          
          u_xlat0.x = dot(u_xlat0, float4(0.674199879, 0.674199879, 0.269679934, 0.134839967));
          
          u_xlat0.x = u_xlat0.x * 0.699999988;
          
          u_xlat2.x = dot(u_xlat1, float4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
          
          u_xlat2.z = dot(u_xlat1, float4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
          
          u_xlat1.xz = (-u_xlat2.xz) * _WaveAndDistance.zz + in_v.vertex.xz;
          
          u_xlat2 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
          
          u_xlat2 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
          
          u_xlat2 = u_xlat2 + unity_ObjectToWorld[3];
          
          u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
          
          u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
          
          u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
          
          u_xlat16_4.xyz = _WavingTint.xyz + float3(-0.5, -0.5, -0.5);
          
          u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + float3(0.5, 0.5, 0.5);
          
          u_xlat16_4.xyz = u_xlat16_4.xyz * in_v.color.xyz;
          
          out_v.color.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
          
          u_xlat1.y = in_v.vertex.y;
          
          u_xlat0.xyz = u_xlat1.xyz + (-_CameraPosition.xyz);
          
          u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat0.x = (-u_xlat0.x) + _WaveAndDistance.w;
          
          u_xlat0.x = dot(_CameraPosition.ww, u_xlat0.xx);
          
          u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          
          out_v.color.w = u_xlat0.x;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          u_xlat0.x = u_xlat2.y * unity_MatrixV[1].z;
          
          u_xlat0.x = unity_MatrixV[0].z * u_xlat2.x + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[2].z * u_xlat2.z + u_xlat0.x;
          
          u_xlat0.x = unity_MatrixV[3].z * u_xlat2.w + u_xlat0.x;
          
          u_xlat0.x = u_xlat0.x * _ProjectionParams.w;
          
          out_v.texcoord1.w = (-u_xlat0.x);
          
          u_xlat0.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[0].yyy;
          
          u_xlat0.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[0].xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[0].zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[0].www + u_xlat0.xyz;
          
          u_xlat0.x = dot(u_xlat0.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[1].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[1].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[1].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[1].www + u_xlat1.xyz;
          
          u_xlat0.y = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat1.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[2].yyy;
          
          u_xlat1.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[2].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[2].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[2].www + u_xlat1.xyz;
          
          u_xlat0.z = dot(u_xlat1.xyz, in_v.normal.xyz);
          
          u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          out_v.texcoord1.xyz = float3(u_xlat15) * u_xlat0.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float u_xlat16_0;
      
      int u_xlatb0;
      
      float u_xlat16_1;
      
      float2 u_xlat2_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy).w;
          
          u_xlat16_1 = u_xlat16_0 * in_f.color.w + (-_Cutoff);
          
          u_xlatb0 = u_xlat16_1<0.0;
          
          if(u_xlatb0)
      {
              discard;
      }
          
          u_xlat0_d.x = in_f.texcoord1.z + 1.0;
          
          u_xlat0_d.xy = in_f.texcoord1.xy / u_xlat0_d.xx;
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.281262308, 0.281262308) + float2(0.5, 0.5);
          
          u_xlat2_d.xy = in_f.texcoord1.ww * float2(1.0, 255.0);
          
          u_xlat2_d.xy = fract(u_xlat2_d.xy);
          
          u_xlat0_d.z = (-u_xlat2_d.y) * 0.00392156886 + u_xlat2_d.x;
          
          u_xlat0_d.w = u_xlat2_d.y;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

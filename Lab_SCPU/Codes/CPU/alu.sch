<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="kintex7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="A(31:0)" />
        <signal name="XLXN_12(31:0)" />
        <signal name="XLXN_22(31:0)" />
        <signal name="XLXN_23(31:0)" />
        <signal name="res(31:0)" />
        <signal name="N0" />
        <signal name="zero" />
        <signal name="XLXN_47(31:0)" />
        <signal name="N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,S(32)" />
        <signal name="XLXN_51(31:0)" />
        <signal name="B(31:0)" />
        <signal name="ALU_operation(2:0)" />
        <signal name="ALU_operation(2)" />
        <signal name="XLXN_55(31:0)" />
        <signal name="overflow" />
        <signal name="S(31:0)" />
        <signal name="S(32:0)" />
        <signal name="XLXN_11(31:0)" />
        <port polarity="Input" name="A(31:0)" />
        <port polarity="Output" name="res(31:0)" />
        <port polarity="Output" name="zero" />
        <port polarity="Input" name="B(31:0)" />
        <port polarity="Input" name="ALU_operation(2:0)" />
        <port polarity="Output" name="overflow" />
        <blockdef name="and32">
            <timestamp>2014-3-19T13:28:2</timestamp>
            <line x2="32" y1="-96" y2="-96" style="linewidth:W" x1="64" />
            <line x2="28" y1="-32" y2="-32" style="linewidth:W" x1="64" />
            <line x2="64" y1="-16" y2="-16" x1="144" />
            <line x2="64" y1="-16" y2="-112" x1="64" />
            <line x2="144" y1="-112" y2="-112" x1="64" />
            <arc ex="144" ey="-112" sx="144" sy="-16" r="48" cx="144" cy="-64" />
            <line x2="224" y1="-64" y2="-64" style="linewidth:W" x1="192" />
        </blockdef>
        <blockdef name="or32">
            <timestamp>2014-3-19T13:34:25</timestamp>
            <line x2="64" y1="-16" y2="-16" x1="128" />
            <arc ex="208" ey="-64" sx="128" sy="-16" r="88" cx="132" cy="-104" />
            <arc ex="128" ey="-112" sx="208" sy="-64" r="88" cx="132" cy="-24" />
            <line x2="236" y1="-64" y2="-64" style="linewidth:W" x1="208" />
            <line x2="64" y1="-112" y2="-112" x1="128" />
            <line x2="48" y1="-96" y2="-96" style="linewidth:W" x1="80" />
            <arc ex="64" ey="-112" sx="64" sy="-16" r="56" cx="32" cy="-64" />
            <line x2="48" y1="-32" y2="-32" style="linewidth:W" x1="80" />
        </blockdef>
        <blockdef name="nor32">
            <timestamp>2014-3-19T13:43:42</timestamp>
            <line x2="64" y1="-112" y2="-112" x1="128" />
            <arc ex="64" ey="-112" sx="64" sy="-16" r="56" cx="32" cy="-64" />
            <line x2="64" y1="-16" y2="-16" x1="128" />
            <arc ex="208" ey="-64" sx="128" sy="-16" r="88" cx="132" cy="-104" />
            <arc ex="128" ey="-112" sx="208" sy="-64" r="88" cx="132" cy="-24" />
            <line x2="224" y1="-64" y2="-64" style="linewidth:W" x1="256" />
            <circle style="linewidth:W" r="8" cx="216" cy="-64" />
            <line x2="48" y1="-96" y2="-96" style="linewidth:W" x1="80" />
            <line x2="48" y1="-32" y2="-32" style="linewidth:W" x1="80" />
        </blockdef>
        <blockdef name="srl32">
            <timestamp>2014-3-19T13:48:11</timestamp>
            <rect width="184" x="64" y="-128" height="128" />
            <line x2="32" y1="-96" y2="-96" style="linewidth:W" x1="64" />
            <line x2="32" y1="-32" y2="-32" style="linewidth:W" x1="64" />
            <line x2="288" y1="-64" y2="-64" style="linewidth:W" x1="248" />
        </blockdef>
        <blockdef name="xor32">
            <timestamp>2014-3-19T14:3:59</timestamp>
            <arc ex="80" ey="-112" sx="80" sy="-16" r="56" cx="48" cy="-64" />
            <line x2="80" y1="-112" y2="-112" x1="144" />
            <line x2="80" y1="-16" y2="-16" x1="144" />
            <arc ex="144" ey="-112" sx="224" sy="-64" r="88" cx="148" cy="-24" />
            <arc ex="60" ey="-112" sx="64" sy="-16" r="56" cx="32" cy="-64" />
            <arc ex="224" ey="-64" sx="144" sy="-16" r="88" cx="148" cy="-104" />
            <line x2="80" y1="-96" y2="-96" style="linewidth:W" x1="32" />
            <line x2="80" y1="-32" y2="-32" style="linewidth:W" x1="32" />
            <line x2="228" y1="-64" y2="-64" style="linewidth:W" x1="256" />
        </blockdef>
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="or_bit_32">
            <timestamp>2014-3-19T14:52:25</timestamp>
            <rect width="220" x="64" y="-104" height="112" />
            <line x2="32" y1="-48" y2="-48" style="linewidth:W" x1="64" />
            <arc ex="260" ey="-48" sx="180" sy="0" r="88" cx="184" cy="-88" />
            <line x2="116" y1="0" y2="0" x1="180" />
            <line x2="116" y1="-96" y2="-96" x1="180" />
            <arc ex="116" ey="-96" sx="116" sy="0" r="56" cx="84" cy="-48" />
            <arc ex="180" ey="-96" sx="260" sy="-48" r="88" cx="184" cy="-8" />
            <line x2="120" y1="-96" y2="-96" x1="184" />
            <line x2="88" y1="-80" y2="-80" x1="128" />
            <line x2="92" y1="-16" y2="-16" x1="132" />
            <line x2="304" y1="-48" y2="-48" x1="284" />
        </blockdef>
        <blockdef name="SignalExt_32">
            <timestamp>2014-6-26T12:2:4</timestamp>
            <line x2="76" y1="-32" y2="-32" x1="64" />
            <line x2="208" y1="-32" y2="-32" style="linewidth:W" x1="196" />
            <rect width="120" x="76" y="-52" height="40" />
        </blockdef>
        <blockdef name="ADC32">
            <timestamp>2014-6-26T17:20:37</timestamp>
            <line x2="48" y1="-256" y2="-256" style="linewidth:W" x1="64" />
            <line x2="48" y1="-128" y2="-128" style="linewidth:W" x1="64" />
            <line x2="64" y1="-224" y2="-300" x1="64" />
            <line x2="112" y1="-224" y2="-192" x1="64" />
            <line x2="112" y1="-160" y2="-192" x1="64" />
            <line x2="64" y1="-160" y2="-76" x1="64" />
            <line x2="224" y1="-76" y2="-140" x1="64" />
            <line x2="224" y1="-300" y2="-236" x1="64" />
            <line x2="224" y1="-140" y2="-236" x1="224" />
            <line x2="240" y1="-192" y2="-192" style="linewidth:W" x1="224" />
            <line x2="128" y1="-304" y2="-276" x1="128" />
        </blockdef>
        <blockdef name="MUX8T1_32">
            <timestamp>2015-12-29T14:54:6</timestamp>
            <rect width="68" x="12" y="-264" height="264" />
            <line x2="48" y1="-264" y2="-272" style="linewidth:W" x1="48" />
            <line x2="0" y1="-16" y2="-16" style="linewidth:W" x1="12" />
            <line x2="0" y1="-48" y2="-48" style="linewidth:W" x1="12" />
            <line x2="0" y1="-80" y2="-80" style="linewidth:W" x1="12" />
            <line x2="0" y1="-112" y2="-112" style="linewidth:W" x1="12" />
            <line x2="0" y1="-144" y2="-144" style="linewidth:W" x1="12" />
            <line x2="0" y1="-176" y2="-176" style="linewidth:W" x1="12" />
            <line x2="0" y1="-208" y2="-208" style="linewidth:W" x1="12" />
            <line x2="0" y1="-240" y2="-240" style="linewidth:W" x1="12" />
            <line x2="96" y1="-160" y2="-160" style="linewidth:W" x1="80" />
        </blockdef>
        <block symbolname="nor32" name="ALU_U4">
            <blockpin signalname="XLXN_11(31:0)" name="res(31:0)" />
            <blockpin signalname="A(31:0)" name="A(31:0)" />
            <blockpin signalname="B(31:0)" name="B(31:0)" />
        </block>
        <block symbolname="or32" name="ALU_U2">
            <blockpin signalname="XLXN_23(31:0)" name="res(31:0)" />
            <blockpin signalname="A(31:0)" name="A(31:0)" />
            <blockpin signalname="B(31:0)" name="B(31:0)" />
        </block>
        <block symbolname="and32" name="ALU_U1">
            <blockpin signalname="XLXN_22(31:0)" name="res(31:0)" />
            <blockpin signalname="A(31:0)" name="A(31:0)" />
            <blockpin signalname="B(31:0)" name="B(31:0)" />
        </block>
        <block symbolname="xor32" name="ALU_U3">
            <blockpin signalname="A(31:0)" name="A(31:0)" />
            <blockpin signalname="B(31:0)" name="B(31:0)" />
            <blockpin signalname="XLXN_12(31:0)" name="res(31:0)" />
        </block>
        <block symbolname="gnd" name="XLXI_13">
            <blockpin signalname="N0" name="G" />
        </block>
        <block symbolname="or_bit_32" name="ALU_Zero">
            <blockpin signalname="zero" name="o" />
            <blockpin signalname="res(31:0)" name="A(31:0)" />
        </block>
        <block symbolname="srl32" name="ALU_U5">
            <blockpin signalname="A(31:0)" name="A(31:0)" />
            <blockpin signalname="B(31:0)" name="B(31:0)" />
            <blockpin signalname="XLXN_47(31:0)" name="res(31:0)" />
        </block>
        <block symbolname="xor32" name="ALU_U7">
            <blockpin signalname="XLXN_55(31:0)" name="A(31:0)" />
            <blockpin signalname="B(31:0)" name="B(31:0)" />
            <blockpin signalname="XLXN_51(31:0)" name="res(31:0)" />
        </block>
        <block symbolname="SignalExt_32" name="SIignal1_32">
            <blockpin signalname="XLXN_55(31:0)" name="So(31:0)" />
            <blockpin signalname="ALU_operation(2)" name="S" />
        </block>
        <block symbolname="ADC32" name="ADC_32">
            <blockpin signalname="XLXN_51(31:0)" name="B(31:0)" />
            <blockpin signalname="A(31:0)" name="A(31:0)" />
            <blockpin signalname="ALU_operation(2)" name="C0" />
            <blockpin signalname="S(32:0)" name="S(32:0)" />
        </block>
        <block symbolname="MUX8T1_32" name="MUXALU">
            <blockpin signalname="ALU_operation(2:0)" name="s(2:0)" />
            <blockpin signalname="N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,S(32)" name="I7(31:0)" />
            <blockpin signalname="S(31:0)" name="I6(31:0)" />
            <blockpin signalname="XLXN_47(31:0)" name="I5(31:0)" />
            <blockpin signalname="XLXN_11(31:0)" name="I4(31:0)" />
            <blockpin signalname="XLXN_12(31:0)" name="I3(31:0)" />
            <blockpin signalname="S(31:0)" name="I2(31:0)" />
            <blockpin signalname="XLXN_23(31:0)" name="I1(31:0)" />
            <blockpin signalname="XLXN_22(31:0)" name="I0(31:0)" />
            <blockpin signalname="res(31:0)" name="o(31:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="1760" height="1360">
        <branch name="XLXN_22(31:0)">
            <wire x2="960" y1="128" y2="128" x1="784" />
            <wire x2="960" y1="128" y2="288" x1="960" />
            <wire x2="1264" y1="288" y2="288" x1="960" />
        </branch>
        <branch name="XLXN_23(31:0)">
            <wire x2="928" y1="240" y2="240" x1="784" />
            <wire x2="928" y1="240" y2="320" x1="928" />
            <wire x2="1264" y1="320" y2="320" x1="928" />
        </branch>
        <branch name="res(31:0)">
            <wire x2="1328" y1="656" y2="752" x1="1328" />
            <wire x2="1344" y1="752" y2="752" x1="1328" />
            <wire x2="1504" y1="656" y2="656" x1="1328" />
            <wire x2="1504" y1="368" y2="368" x1="1360" />
            <wire x2="1504" y1="368" y2="656" x1="1504" />
            <wire x2="1600" y1="368" y2="368" x1="1504" />
        </branch>
        <bustap x2="1184" y1="672" y2="672" x1="1088" />
        <branch name="zero">
            <wire x2="1648" y1="752" y2="752" x1="1616" />
        </branch>
        <instance x="1312" y="800" name="ALU_Zero" orien="R0">
        </instance>
        <iomarker fontsize="28" x="1648" y="752" name="zero" orien="R0" />
        <branch name="XLXN_12(31:0)">
            <wire x2="960" y1="672" y2="672" x1="800" />
            <wire x2="960" y1="384" y2="672" x1="960" />
            <wire x2="1264" y1="384" y2="384" x1="960" />
        </branch>
        <instance x="544" y="736" name="ALU_U3" orien="R0">
        </instance>
        <instance x="544" y="848" name="ALU_U4" orien="R0">
        </instance>
        <instance x="512" y="1008" name="ALU_U5" orien="R0">
        </instance>
        <branch name="N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,N0,S(32)">
            <wire x2="1264" y1="512" y2="512" x1="1072" />
            <wire x2="1072" y1="512" y2="672" x1="1072" />
            <wire x2="1088" y1="672" y2="672" x1="1072" />
        </branch>
        <branch name="XLXN_51(31:0)">
            <wire x2="592" y1="544" y2="544" x1="416" />
        </branch>
        <instance x="560" y="192" name="ALU_U1" orien="R0">
        </instance>
        <instance x="544" y="304" name="ALU_U2" orien="R0">
        </instance>
        <branch name="B(31:0)">
            <wire x2="192" y1="576" y2="576" x1="144" />
            <wire x2="144" y1="576" y2="816" x1="144" />
            <wire x2="448" y1="816" y2="816" x1="144" />
            <wire x2="592" y1="816" y2="816" x1="448" />
            <wire x2="448" y1="816" y2="976" x1="448" />
            <wire x2="544" y1="976" y2="976" x1="448" />
            <wire x2="448" y1="976" y2="976" x1="208" />
            <wire x2="592" y1="160" y2="160" x1="448" />
            <wire x2="448" y1="160" y2="272" x1="448" />
            <wire x2="592" y1="272" y2="272" x1="448" />
            <wire x2="448" y1="272" y2="704" x1="448" />
            <wire x2="448" y1="704" y2="816" x1="448" />
            <wire x2="576" y1="704" y2="704" x1="448" />
        </branch>
        <iomarker fontsize="28" x="208" y="976" name="B(31:0)" orien="R180" />
        <instance x="160" y="608" name="ALU_U7" orien="R0">
        </instance>
        <branch name="A(31:0)">
            <wire x2="528" y1="128" y2="128" x1="176" />
            <wire x2="528" y1="128" y2="208" x1="528" />
            <wire x2="592" y1="208" y2="208" x1="528" />
            <wire x2="528" y1="208" y2="416" x1="528" />
            <wire x2="528" y1="416" y2="640" x1="528" />
            <wire x2="528" y1="640" y2="752" x1="528" />
            <wire x2="528" y1="752" y2="912" x1="528" />
            <wire x2="544" y1="912" y2="912" x1="528" />
            <wire x2="592" y1="752" y2="752" x1="528" />
            <wire x2="576" y1="640" y2="640" x1="528" />
            <wire x2="592" y1="416" y2="416" x1="528" />
            <wire x2="592" y1="96" y2="96" x1="528" />
            <wire x2="528" y1="96" y2="128" x1="528" />
        </branch>
        <branch name="ALU_operation(2:0)">
            <wire x2="352" y1="48" y2="48" x1="304" />
            <wire x2="352" y1="48" y2="80" x1="352" />
            <wire x2="1312" y1="48" y2="48" x1="352" />
            <wire x2="1312" y1="48" y2="256" x1="1312" />
        </branch>
        <text x="76" y="512">B_Ctrl</text>
        <iomarker fontsize="28" x="176" y="128" name="A(31:0)" orien="R180" />
        <branch name="ALU_operation(2)">
            <wire x2="352" y1="336" y2="336" x1="320" />
            <wire x2="672" y1="336" y2="336" x1="352" />
            <wire x2="672" y1="336" y2="368" x1="672" />
            <wire x2="352" y1="192" y2="336" x1="352" />
        </branch>
        <bustap x2="352" y1="80" y2="192" x1="352" />
        <branch name="XLXN_55(31:0)">
            <wire x2="176" y1="336" y2="336" x1="160" />
            <wire x2="160" y1="336" y2="512" x1="160" />
            <wire x2="192" y1="512" y2="512" x1="160" />
        </branch>
        <iomarker fontsize="28" x="304" y="48" name="ALU_operation(2:0)" orien="R180" />
        <branch name="overflow">
            <wire x2="1584" y1="992" y2="992" x1="1440" />
        </branch>
        <iomarker fontsize="28" x="1584" y="992" name="overflow" orien="R0" />
        <instance x="384" y="304" name="SIignal1_32" orien="R180">
        </instance>
        <branch name="N0">
            <wire x2="1248" y1="672" y2="672" x1="1184" />
            <wire x2="1248" y1="672" y2="784" x1="1248" />
        </branch>
        <instance x="1184" y="912" name="XLXI_13" orien="R0" />
        <instance x="544" y="672" name="ADC_32" orien="R0">
        </instance>
        <branch name="S(32:0)">
            <wire x2="816" y1="480" y2="480" x1="784" />
        </branch>
        <bustap x2="912" y1="480" y2="480" x1="816" />
        <branch name="XLXN_47(31:0)">
            <wire x2="1024" y1="944" y2="944" x1="800" />
            <wire x2="1024" y1="448" y2="944" x1="1024" />
            <wire x2="1264" y1="448" y2="448" x1="1024" />
        </branch>
        <branch name="S(31:0)">
            <wire x2="928" y1="480" y2="480" x1="912" />
            <wire x2="1264" y1="480" y2="480" x1="928" />
            <wire x2="1264" y1="352" y2="352" x1="928" />
            <wire x2="928" y1="352" y2="480" x1="928" />
        </branch>
        <branch name="XLXN_11(31:0)">
            <wire x2="992" y1="784" y2="784" x1="800" />
            <wire x2="992" y1="416" y2="784" x1="992" />
            <wire x2="1264" y1="416" y2="416" x1="992" />
        </branch>
        <instance x="1264" y="528" name="MUXALU" orien="R0">
        </instance>
        <iomarker fontsize="28" x="1600" y="368" name="res(31:0)" orien="R0" />
    </sheet>
</drawing>
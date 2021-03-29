/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLADIfHa.aml, Mon Mar 29 02:42:22 2021
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x000248EA (149738)
 *     Revision         0x02
 *     Checksum         0x93
 *     OEM ID           "HPQOEM"
 *     OEM Table ID     "167C    "
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20060912 (537266450)
 */
DefinitionBlock ("", "DSDT", 2, "HPQOEM", "167C    ", 0x00000001)
{
    /*
     * iASL Warning: There were 2 external control methods found during
     * disassembly, but only 0 were resolved (2 unresolved). Additional
     * ACPI tables may be required to properly disassemble the code. This
     * resulting disassembler output file may not compile because the
     * disassembler did not know how many arguments to assign to the
     * unresolved methods. Note: SSDTs can be dynamically loaded at
     * runtime and may or may not be available via the host OS.
     *
     * To specify the tables needed to resolve external control method
     * references, the -e option can be used to specify the filenames.
     * Example iASL invocations:
     *     iasl -e ssdt1.aml ssdt2.aml ssdt3.aml -d dsdt.aml
     *     iasl -e dsdt.aml ssdt2.aml -d ssdt1.aml
     *     iasl -e ssdt*.aml -d dsdt.aml
     *
     * In addition, the -fe option can be used to specify a file containing
     * control method external declarations with the associated method
     * argument counts. Each line of the file must be of the form:
     *     External (<method pathname>, MethodObj, <argument count>)
     * Invocation:
     *     iasl -fe refs.txt -d dsdt.aml
     *
     * The following methods were unresolved and many not compile properly
     * because the disassembler had to guess at the number of arguments
     * required for each:
     */
    External (_PR_.CPU0._PPC, UnknownObj)
    External (_PR_.CPU0._PSS, IntObj)
    External (_SB_.PCI0.PEGP.DGFX.DD02, UnknownObj)
    External (_SB_.PCI0.PEGP.DGFX.SVID, UnknownObj)
    External (CFGD, UnknownObj)
    External (FPED, MethodObj)    // Warning: Unknown method, guessing 0 arguments
    External (PDC0, UnknownObj)
    External (PDC1, UnknownObj)
    External (PDC2, UnknownObj)
    External (PDC3, UnknownObj)
    External (PDC4, UnknownObj)
    External (PDC5, UnknownObj)
    External (PDC6, UnknownObj)
    External (PDC7, UnknownObj)
    External (WMAB, MethodObj)    // Warning: Unknown method, guessing 1 arguments

    Name (FMBL, 0x01)
    Name (LSTA, 0x00)
    Name (IDPM, 0x00)
    Method (\HPTS, 1, NotSerialized)
    {
        SLPT = Arg0
        \_SB.ODGW ((0x5400 | Arg0))
        If ((Arg0 == 0x05))
        {
            \_SB.SSMI (0xEA82, Arg0, 0x00, 0x00, 0x00)
        }

        If ((Arg0 > 0x00))
        {
            \_SB.SSMI (0xEA83, 0x00, 0x00, 0x00, 0x00)
            If ((Arg0 != 0x03))
            {
                \_SB.PCI0.LPCB.EC0.HSST = 0x00
            }

            PPTS (Arg0)
            If ((Arg0 != 0x05))
            {
                \_SB.PCI0.LPCB.EC0.BTDR (0x00)
                \_SB.NFBS = 0x01
                If ((Arg0 == 0x03))
                {
                    LSTA = \_SB.LID._LID ()
                    If (((PNHM & 0x000F0FF0) != 0x000106E0))
                    {
                        IDPM = \APMC
                    }
                }
            }
        }
    }

    Method (\HWAK, 1, NotSerialized)
    {
        SLPT = 0x00
        \_SB.ODGW ((0x5600 | Arg0))
        If ((Arg0 == 0x03))
        {
            \_SB.SSMI (0xEA80, 0x00, 0x00, 0x00, 0x00)
        }

        \_SB.PCI0.LPCB.EC0.ITLB ()
        \_SB.PCI0.LPCB.EC0.RPPC (0x01)
        If (\_SB.PCI0.LPCB.EC0.ECRG)
        {
            Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
            \_SB.PCI0.LPCB.EC0.ACPI = 0x01
            \_SB.PCI0.LPCB.EC0.SLPT = 0x00
            Release (\_SB.PCI0.LPCB.EC0.ECMX)
        }

        If ((Arg0 > 0x02))
        {
            \_TZ.RETD ()
            \_TZ.INTM (0x01)
            \_SB.NFBS = 0x01
            If ((Arg0 == 0x03))
            {
                Local0 = \_SB.LID._LID ()
                If ((Local0 ^ LSTA))
                {
                    \_SB.PCI0.GFX0.GLID (Local0)
                }

                If (((PNHM & 0x000F0FF0) != 0x000106E0))
                {
                    \APMC = IDPM /* \IDPM */
                }
            }

            If ((Arg0 == 0x04))
            {
                \_SB.WMID.WGWE (0x05, 0x00)
            }
        }

        If (((Arg0 == 0x04) || (\WCOS () == 0x01)))
        {
            Notify (\_SB.SLPB, 0x02) // Device Wake
        }

        Local2 = \_SB.PCI0.LPCB.EC0.GACS ()
        \_SB.PCI0.LPCB.EC0.PWUP (0x03, 0xFF)
        Local1 = \_SB.PCI0.LPCB.EC0.GBAP ()
        Local3 = \_SB.PCI0.LPCB.EC0.GACS ()
        PWRS = Local3
        Local3 ^= Local2
        If ((Arg0 > 0x02))
        {
            Notify (\_SB.AC, 0x80) // Status Change
            PCNT ()
        }

        If ((Local3 == 0x00))
        {
            If ((Arg0 == 0x04))
            {
                \_SB.ACST = (Local2 ^ 0x01)
            }
        }

        PWAK (Arg0)
        \_SB.VWAK (Arg0)
        Local0 = \_SB.HST1.GHID ()
        \_SB.PCI0.ACEL.ITAL ()
    }

    Method (PCNT, 0, Serialized)
    {
        If ((TCNT > 0x01))
        {
            If ((PDC0 & 0x18))
            {
                Notify (\_PR.CPU0, 0x81) // C-State Change
            }

            If ((PDC1 & 0x18))
            {
                Notify (\_PR.CPU1, 0x81) // C-State Change
            }

            If ((PDC2 & 0x18))
            {
                Notify (\_PR.CPU2, 0x81) // C-State Change
            }

            If ((PDC3 & 0x18))
            {
                Notify (\_PR.CPU3, 0x81) // C-State Change
            }

            If ((PDC4 & 0x18))
            {
                Notify (\_PR.CPU4, 0x81) // C-State Change
            }

            If ((PDC5 & 0x18))
            {
                Notify (\_PR.CPU5, 0x81) // C-State Change
            }

            If ((PDC6 & 0x18))
            {
                Notify (\_PR.CPU6, 0x81) // C-State Change
            }

            If ((PDC7 & 0x18))
            {
                Notify (\_PR.CPU7, 0x81) // C-State Change
            }
        }
        Else
        {
            Notify (\_PR.CPU0, 0x81) // C-State Change
        }
    }

    Mutex (MUTX, 0x00)
    Method (P8XH, 2, Serialized)
    {
        If ((Arg0 == 0x00))
        {
            \_SB.ODBG (Arg1)
            P80D = ((P80D & 0xFFFFFF00) | Arg1)
        }

        If ((Arg0 == 0x01))
        {
            \_SB.ODG1 (Arg1)
            P80D = ((P80D & 0xFFFF00FF) | (Arg1 << 0x08))
        }

        If ((Arg0 == 0x02))
        {
            P80D = ((P80D & 0xFF00FFFF) | (Arg1 << 0x10))
        }

        If ((Arg0 == 0x03))
        {
            P80D = ((P80D & 0x00FFFFFF) | (Arg1 << 0x18))
        }
    }

    OperationRegion (SPRT, SystemIO, 0xB2, 0x02)
    Field (SPRT, ByteAcc, Lock, Preserve)
    {
        SSMP,   8
    }

    Method (\_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
    {
        GPIC = Arg0
    }

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        HPTS (Arg0)
        If ((Arg0 == 0x03))
        {
            If ((DTSE && (TCNT > 0x01)))
            {
                TRAP (0x02, 0x1E)
            }
        }
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        HWAK (Arg0)
        \_SB.PCI0.POSC (OSCC, 0x00)
        If ((Arg0 == 0x03)){}
        If (((Arg0 == 0x03) || (Arg0 == 0x04)))
        {
            If ((DTSE && (TCNT > 0x01)))
            {
                TRAP (0x02, 0x14)
            }

            If ((CFGD & 0x01000000))
            {
                If (((CFGD & 0xF0) && ((OSYS == 0x07D1) && !(
                    PDC0 & 0x10))))
                {
                    TRAP (0x01, 0x48)
                }
            }

            If ((OSYS == 0x07D2))
            {
                If ((CFGD & 0x01))
                {
                    If ((\_PR.CPU0._PPC > 0x00))
                    {
                        \_PR.CPU0._PPC -= 0x01
                        PNOT ()
                        \_PR.CPU0._PPC += 0x01
                        PNOT ()
                    }
                    Else
                    {
                        \_PR.CPU0._PPC += 0x01
                        PNOT ()
                        \_PR.CPU0._PPC -= 0x01
                        PNOT ()
                    }
                }
            }
        }

        Return (Package (0x02)
        {
            0x00, 
            0x00
        })
    }

    Method (GETB, 3, Serialized)
    {
        Local0 = (Arg0 * 0x08)
        Local1 = (Arg1 * 0x08)
        CreateField (Arg2, Local0, Local1, TBF3)
        Return (TBF3) /* \GETB.TBF3 */
    }

    Method (PNOT, 0, Serialized)
    {
        If ((TCNT > 0x01))
        {
            If ((PDC0 & 0x08))
            {
                Notify (\_PR.CPU0, 0x80) // Performance Capability Change
                If ((PDC0 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU0, 0x81) // C-State Change
                }
            }

            If ((PDC1 & 0x08))
            {
                Notify (\_PR.CPU1, 0x80) // Performance Capability Change
                If ((PDC1 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU1, 0x81) // C-State Change
                }
            }

            If ((PDC2 & 0x08))
            {
                Notify (\_PR.CPU2, 0x80) // Performance Capability Change
                If ((PDC2 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU2, 0x81) // C-State Change
                }
            }

            If ((PDC3 & 0x08))
            {
                Notify (\_PR.CPU3, 0x80) // Performance Capability Change
                If ((PDC3 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU3, 0x81) // C-State Change
                }
            }

            If ((PDC4 & 0x08))
            {
                Notify (\_PR.CPU4, 0x80) // Performance Capability Change
                If ((PDC4 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU4, 0x81) // C-State Change
                }
            }

            If ((PDC5 & 0x08))
            {
                Notify (\_PR.CPU5, 0x80) // Performance Capability Change
                If ((PDC5 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU5, 0x81) // C-State Change
                }
            }

            If ((PDC6 & 0x08))
            {
                Notify (\_PR.CPU6, 0x80) // Performance Capability Change
                If ((PDC6 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU6, 0x81) // C-State Change
                }
            }

            If ((PDC7 & 0x08))
            {
                Notify (\_PR.CPU7, 0x80) // Performance Capability Change
                If ((PDC7 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU7, 0x81) // C-State Change
                }
            }
        }
        Else
        {
            Notify (\_PR.CPU0, 0x80) // Performance Capability Change
            Sleep (0x64)
            Notify (\_PR.CPU0, 0x81) // C-State Change
        }
    }

    Method (TRAP, 2, Serialized)
    {
        SMIF = Arg1
        If ((Arg0 == 0x01))
        {
            TRP0 = 0x00
        }

        If ((Arg0 == 0x02))
        {
            DTSF = Arg1
            TRPD = 0x00
            Return (DTSF) /* \DTSF */
        }

        Return (SMIF) /* \SMIF */
    }

    Scope (\_SB)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            OSYS = 0x07D0
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    OSYS = 0x03E8
                }

                If (_OSI ("Windows 2001"))
                {
                    OSYS = 0x07D1
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    OSYS = 0x07D1
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    OSYS = 0x07D2
                }

                If (_OSI ("Windows 2006"))
                {
                    OSYS = 0x07D6
                }

                If (_OSI ("Windows 2009"))
                {
                    OSYS = 0x07D9
                }
            }

            \_TZ.BOTT ()
            \_TZ.RETD ()
            PFLV = 0x01
        }
    }

    OperationRegion (GNVS, SystemMemory, 0xBCFBEB98, 0x019F)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16, 
        SMIF,   8, 
        PRM0,   8, 
        PRM1,   8, 
        SCIF,   8, 
        PRM2,   8, 
        PRM3,   8, 
        LCKF,   8, 
        PRM4,   8, 
        PRM5,   8, 
        P80D,   32, 
        LIDS,   8, 
        PWRS,   8, 
        DBGS,   8, 
        THOF,   8, 
        ACT1,   8, 
        ACTT,   8, 
        PSVT,   8, 
        TC1V,   8, 
        TC2V,   8, 
        TSPV,   8, 
        CRTT,   8, 
        DTSE,   8, 
        DTS1,   8, 
        DTS2,   8, 
        DTSF,   8, 
        Offset (0x28), 
        APIC,   8, 
        TCNT,   8, 
        PCP0,   8, 
        PCP1,   8, 
        PPCM,   8, 
        PPMF,   32, 
        C67L,   8, 
        NATP,   8, 
        CMAP,   8, 
        CMBP,   8, 
        LPTP,   8, 
        FDCP,   8, 
        CMCP,   8, 
        CIRP,   8, 
        SMSC,   8, 
        W381,   8, 
        SMC1,   8, 
        IGDS,   8, 
        TLST,   8, 
        CADL,   8, 
        PADL,   8, 
        CSTE,   16, 
        NSTE,   16, 
        SSTE,   16, 
        NDID,   8, 
        DID1,   32, 
        DID2,   32, 
        DID3,   32, 
        DID4,   32, 
        DID5,   32, 
        KSV0,   32, 
        KSV1,   8, 
        Offset (0x62), 
        DCLK,   16, 
        FSBF,   16, 
        Offset (0x67), 
        BLCS,   8, 
        BRTL,   8, 
        ALSE,   8, 
        ALAF,   8, 
        LLOW,   8, 
        LHIH,   8, 
        Offset (0x6E), 
        EMAE,   8, 
        EMAP,   16, 
        EMAL,   16, 
        Offset (0x74), 
        MEFE,   8, 
        DSTS,   8, 
        Offset (0x78), 
        TPMP,   8, 
        TPME,   8, 
        Offset (0x82), 
        GTF0,   56, 
        GTF2,   56, 
        IDEM,   8, 
        GTF1,   56, 
        BID,    8, 
        Offset (0xAA), 
        ASLB,   32, 
        IBTT,   8, 
        IPAT,   8, 
        ITVF,   8, 
        ITVM,   8, 
        IPSC,   8, 
        IBLC,   8, 
        IBIA,   8, 
        ISSC,   8, 
        I409,   8, 
        I509,   8, 
        I609,   8, 
        I709,   8, 
        IPCF,   8, 
        IDMS,   8, 
        IF1E,   8, 
        HVCO,   8, 
        NXD1,   32, 
        NXD2,   32, 
        NXD3,   32, 
        NXD4,   32, 
        NXD5,   32, 
        NXD6,   32, 
        NXD7,   32, 
        NXD8,   32, 
        GSMI,   8, 
        PAVP,   8, 
        Offset (0xE1), 
        OSCC,   8, 
        NEXP,   8, 
        SDGV,   8, 
        SDDV,   8, 
        Offset (0xEB), 
        DSEN,   8, 
        ECON,   8, 
        GPIC,   8, 
        CTYP,   8, 
        L01C,   8, 
        VFN0,   8, 
        VFN1,   8, 
        Offset (0x100), 
        NVGA,   32, 
        NVHA,   32, 
        AMDA,   32, 
        DID6,   32, 
        DID7,   32, 
        DID8,   32, 
        EBAS,   32, 
        CPSP,   32, 
        EECP,   32, 
        EVCP,   32, 
        XBAS,   32, 
        OBS1,   32, 
        OBS2,   32, 
        OBS3,   32, 
        OBS4,   32, 
        OBS5,   32, 
        OBS6,   32, 
        OBS7,   32, 
        OBS8,   32, 
        Offset (0x157), 
        ATMC,   8, 
        PTMC,   8, 
        ATRA,   8, 
        PTRA,   8, 
        PNHM,   32, 
        TBAB,   32, 
        TBAH,   32, 
        RTIP,   8, 
        TSOD,   8, 
        ATPC,   8, 
        PTPC,   8, 
        PFLV,   8, 
        BREV,   8, 
        SGMD,   8, 
        SGFL,   8, 
        PWOK,   8, 
        HLRS,   8, 
        DSEL,   8, 
        ESEL,   8, 
        PSEL,   8, 
        PWEN,   8, 
        PRST,   8, 
        MXD1,   32, 
        MXD2,   32, 
        MXD3,   32, 
        MXD4,   32, 
        MXD5,   32, 
        MXD6,   32, 
        MXD7,   32, 
        MXD8,   32, 
        GBAS,   16, 
        Offset (0x19D), 
        ALFP,   8, 
        IMON,   8
    }

    OperationRegion (ASMA, SystemMemory, 0xBCFBC018, 0x1060)
    Field (ASMA, AnyAcc, NoLock, Preserve)
    {
        ASMB,   33536
    }

    OperationRegion (AF10, SystemMemory, 0xBCFBE018, 0x0B58)
    Field (AF10, AnyAcc, Lock, Preserve)
    {
        STAT,   32, 
        EVAL,   8, 
        ASTL,   8, 
        ASTG,   256, 
        OWNT,   640, 
        PROD,   640, 
        MODL,   640, 
        PTYP,   640, 
        PFRQ,   640, 
        MEMS,   640, 
        DATE,   640, 
        FAMI,   640, 
        SERL,   640, 
        VREV,   640, 
        VRE2,   640, 
        KBCD,   640, 
        HDDS,   160, 
        HDDM,   320, 
        CDAT,   136, 
        CSTS,   8, 
        CYCL,   8, 
        PBSN,   144, 
        SBSN,   144, 
        BSTS,   8, 
        BORD,   72, 
        APST,   8, 
        OAPW,   3200, 
        NAPW,   3200, 
        SECO,   32, 
        SECS,   32, 
        SKUN,   128, 
        SVID,   80, 
        SSID,   32, 
        BTFC,   160, 
        WLFC,   160, 
        WWFC,   160, 
        GPFC,   160, 
        UUID,   256, 
        CFID,   208, 
        PWDL,   16, 
        USRN,   264, 
        ROLE,   32, 
        CMDV,   32, 
        KBDL,   32, 
        HASH,   160, 
        SPSF,   8, 
        FMOD,   8, 
        NBDL,   8, 
        MBDL,   8, 
        NBAD,   8, 
        MBAD,   8, 
        WUFI,   24, 
        LFND,   1296, 
        ATIM,   48, 
        PCID,   512, 
        PCVR,   40, 
        CURL,   1040, 
        RDSP,   8, 
        FCM,    32, 
        MPMC,   8, 
        SBCT,   120, 
        TXTC,   8, 
        AMTC,   8, 
        CPRV,   120, 
        BKPR,   8, 
        SNMD,   8, 
        MMS1,   640, 
        MMS2,   640, 
        MMS3,   640, 
        MMS4,   640, 
        NMMS,   8
    }

    OperationRegion (HPDF, SystemMemory, 0xBCFBFE18, 0x017C)
    Field (HPDF, AnyAcc, Lock, Preserve)
    {
        SLPT,   4, 
        WHOS,   4, 
        SDFG,   4, 
        LEGF,   1, 
        KCDB,   1, 
        KLDB,   1, 
        TPMX,   1, 
        FOAL,   1, 
        AEDA,   1, 
        ALSF,   1, 
        WOLD,   1, 
        HSED,   1, 
        HDEN,   1, 
        MDEN,   1, 
        ICPT,   1, 
        PMCS,   1, 
        UWKD,   1, 
        INQW,   1, 
        ILUX,   1, 
        ITPS,   1, 
        FCIN,   1, 
        ASFG,   2, 
        WDPE,   8, 
        WDSA,   16, 
        WDST,   16, 
        WDGN,   16, 
        WDSS,   16, 
        WLBN,   8, 
        PRDT,   8, 
        LPDP,   16, 
        EAX,    32, 
        EBX,    32, 
        ECX,    32, 
        EDX,    32, 
        REFS,   32, 
        SSCI,   8, 
        SBFC,   8, 
        TJMX,   8, 
        TRCN,   8, 
        DCAP,   8, 
        LOTR,   160, 
        HITR,   160, 
        WABN,   8, 
        WADN,   8, 
        WAFN,   8, 
        DTCD,   32, 
        BDCP,   8, 
        TBRB,   32, 
        OHCB,   32, 
        EDID,   2048, 
        ESTA,   8, 
        VRMS,   32, 
        VRMB,   32, 
        SGME,   8, 
        AMNS,   32, 
        AMNP,   32, 
        AMVS,   32, 
        AMVP,   32
    }

    OperationRegion (HPD2, SystemMemory, 0xBCE6EF18, 0x006D)
    Field (HPD2, AnyAcc, Lock, Preserve)
    {
        CFPS,   8, 
        CMDS,   8, 
        BRID,   8, 
        F11,    1, 
        RSVD,   31, 
        WLDA,   768, 
        WLFL,   8, 
        WLIX,   8, 
        BTIX,   8, 
        WWIX,   8, 
        W2IX,   8, 
        GPSI,   8
    }

    OperationRegion (HPBR, SystemMemory, 0xBCFBBF18, 0x007E)
    Field (HPBR, AnyAcc, Lock, Preserve)
    {
        PAID,   32, 
        PHSZ,   8, 
        PVSZ,   8, 
        BRCT,   8, 
        BCCT,   8, 
        BMAP,   88, 
        BCLV,   216, 
        BRLV,   200, 
        BRNT,   400, 
        BPWG,   16, 
        BPWO,   16, 
        PNLF,   8
    }

    Scope (\_GPE)
    {
        Method (_L01, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            L01C += 0x01
            \_SB.PCI0.RP01.HPLG ()
            \_SB.PCI0.RP02.HPLG ()
            \_SB.PCI0.RP03.HPLG ()
            \_SB.PCI0.RP04.HPLG ()
            \_SB.PCI0.RP05.HPLG ()
            \_SB.PCI0.RP06.HPLG ()
            \_SB.PCI0.RP07.HPLG ()
            \_SB.PCI0.RP08.HPLG ()
        }

        Method (_L02, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            GPEC = 0x00
            Local0 = SSCI /* \SSCI */
            If (Local0)
            {
                SSCI = 0x00
                If ((Local0 == 0x01))
                {
                    VFN4 ()
                }

                If ((Local0 == 0x04))
                {
                    \_SB.WMID.WGWE (Local0, 0x00)
                }

                If ((Local0 == 0x05))
                {
                    \_SB.WMID.WGWE (Local0, 0x00)
                }

                If ((Local0 == 0x03))
                {
                    VBRE (0x87)
                }

                If ((Local0 == 0x02))
                {
                    VBRE (0x86)
                }
            }
        }

        Method (_L09, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            \_SB.PCI0.RP01.PME ()
            \_SB.PCI0.RP02.PME ()
            \_SB.PCI0.RP03.PME ()
            \_SB.PCI0.RP04.PME ()
            \_SB.PCI0.RP05.PME ()
            \_SB.PCI0.RP06.PME ()
            \_SB.PCI0.RP07.PME ()
            \_SB.PCI0.RP08.PME ()
        }

        Method (_L0B, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.PCIB, 0x02) // Device Wake
        }

        Method (_L0D, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            If (\_SB.PCI0.EHC1.PMES)
            {
                \_SB.PCI0.EHC1.PMES = 0x01
                Notify (\_SB.PCI0.EHC1, 0x02) // Device Wake
            }

            If (\_SB.PCI0.EHC2.PMES)
            {
                \_SB.PCI0.EHC2.PMES = 0x01
                Notify (\_SB.PCI0.EHC2, 0x02) // Device Wake
            }

            If (\_SB.PCI0.HDEF.PMES)
            {
                \_SB.PCI0.HDEF.PMES = 0x01
                Notify (\_SB.PCI0.HDEF, 0x02) // Device Wake
            }

            Notify (\_SB.PCI0.LANC, 0x02) // Device Wake
        }

        Method (_L13, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Local0 = (GPIE & ~0x08)
            GPIE = Local0
            Local0 = (GPL3 | 0x10)
            GPL3 = Local0
            Sleep (0x03E8)
            Notify (\_SB.PCI0.SATA, 0x81) // Information Change
        }

        Method (_L1D, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Local0 = (GIV ^ 0x2000)
            GIV = Local0
            VDET ()
            \_SB.WMID.WGWE (0x01, 0x00)
            Sleep (0x03E8)
            Notify (\_SB.PCI0.EHC2, 0x00) // Bus Check
            Notify (\_SB.PCI0.SATA, 0x00) // Bus Check
            DKET ()
        }

        Method (HWWP, 1, Serialized)
        {
            If (((INQW == 0x00) || (Arg0 == 0x01)))
            {
                Local0 = 0x00
                If ((GPL0 & 0x00400000))
                {
                    Local0 = 0x01
                }

                \_SB.PCI0.LPCB.EC0.HWWP (Local0)
            }
        }
    }

    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00000410, 0x06){}
        Processor (CPU1, 0x01, 0x00000410, 0x06){}
        Processor (CPU2, 0x02, 0x00000410, 0x06){}
        Processor (CPU3, 0x03, 0x00000410, 0x06){}
        Processor (CPU4, 0x04, 0x00000410, 0x06){}
        Processor (CPU5, 0x05, 0x00000410, 0x06){}
        Processor (CPU6, 0x06, 0x00000410, 0x06){}
        Processor (CPU7, 0x07, 0x00000410, 0x06){}
    }

    Scope (\_TZ)
    {
        Name (TRPC, Package (0x05)
        {
            Package (0x04)
            {
                0x60, 
                0x63, 
                0x63, 
                0x80
            }, 

            Package (0x04)
            {
                0x65, 
                0x6C, 
                0x80, 
                0x80
            }, 

            Package (0x04)
            {
                0x80, 
                0x80, 
                0x80, 
                0x80
            }, 

            Package (0x04)
            {
                0x80, 
                0x80, 
                0x80, 
                0x80
            }, 

            Package (0x04)
            {
                0x36, 
                0x37, 
                0x80, 
                0x80
            }
        })
        Name (TRIP, Package (0x05)
        {
            Package (0x04){}, 
            Package (0x04){}, 
            Package (0x04){}, 
            Package (0x04){}, 
            Package (0x04){}
        })
        Name (CLSH, Package (0x04)
        {
            0x62, 
            0x69, 
            0x80, 
            0x80
        })
        Method (TRUP, 0, Serialized)
        {
            Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler, x=0-9, A-Z
            _T_0 = PRDT /* \PRDT */
            If ((_T_0 == 0x01))
            {
                MRPM = 0x10CC
            }
            ElseIf ((_T_0 == 0x02))
            {
                MRPM = 0x10CC
                TRPC [0x01] = CLSH /* \_TZ_.CLSH */
            }
            ElseIf ((_T_0 == 0x03))
            {
                MRPM = 0x10CC
            }

            MRPM = 0x10CC
            If ((TJMX > 0x00))
            {
                Local0 = (TJMX - 0x01)
                DerefOf (TRPC [0x00]) [0x02] = Local0
                DerefOf (TRPC [0x00]) [0x01] = Local0
                DerefOf (TRPC [0x00]) [0x00] = (TJMX - 0x04)
            }
        }

        Method (INTM, 1, Serialized)
        {
            Local0 = 0x00
            OTHI (Arg0)
        }

        Name (WHTR, 0x1F)
        Name (OSTH, 0x00)
        Name (LARE, Package (0x06){})
        Name (LARP, Package (0x06){})
        Name (CUZO, Package (0x06){})
        Name (LATR, Package (0x06){})
        Mutex (THER, 0x00)
        Name (THSC, 0x1F)
        Name (MRPM, 0x1388)
        Method (BOTT, 0, Serialized)
        {
            TRUP ()
            Local3 = SizeOf (TRPC)
            Local5 = DerefOf (TRPC [0x00])
            Local4 = SizeOf (Local5)
            Local0 = 0x00
            While ((Local0 < Local3))
            {
                Local1 = 0x00
                While ((Local1 < Local4))
                {
                    Local6 = DerefOf (DerefOf (TRPC [Local0]) [Local1])
                    Local7 = GETK (Local6)
                    DerefOf (TRIP [Local0]) [Local1] = Local7
                    Local1++
                }

                Local0++
            }
        }

        Method (RETD, 0, Serialized)
        {
            Acquire (THER, 0xFFFF)
            THSC = 0x1F
            WHTR = 0x1F
            Local0 = 0x00
            While ((Local0 < 0x06))
            {
                LARE [Local0] = 0x00
                LARP [Local0] = 0x00
                CUZO [Local0] = 0xFF
                LATR [Local0] = 0x00
                Local0++
            }

            Release (THER)
        }

        Method (OTHI, 1, Serialized)
        {
            ECTI (0x01)
            If (Arg0)
            {
                NTHS (0x1F)
            }
        }

        Name (OTID, 0x00)
        Method (ECTI, 1, Serialized)
        {
            Local0 = 0x00
            If ((Arg0 == 0x01))
            {
                OTID = 0x01
            }

            If ((\_SB.PCI0.LPCB.EC0.ECRG && OTID))
            {
                NTHS (0x1F)
                OTID = 0x00
            }
        }

        Method (OSIT, 0, Serialized)
        {
            If ((OSTH == 0x00))
            {
                \_TZ.INTM (0x00)
                OSTH = 0x01
            }
        }

        Method (GETP, 2, Serialized)
        {
            Local0 = Arg1
            If ((Arg1 == 0x01))
            {
                Local3 = DerefOf (CUZO [Arg0])
                If (((Local3 > 0x01) && (Local3 != 0xFF)))
                {
                    Local0 = 0x00
                }
            }

            Local2 = DerefOf (DerefOf (TRIP [Arg0]) [Local0])
            Return (Local2)
        }

        Method (GETK, 1, Serialized)
        {
            Local0 = (Arg0 * 0x0A)
            Local1 = (Local0 + 0x0AAC)
            Return (Local1)
        }

        Method (GTTP, 5, Serialized)
        {
            Local1 = Arg2
            If (((Arg0 <= 0x04) && \_SB.PCI0.LPCB.EC0.ECRG))
            {
                Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
                \_SB.PCI0.LPCB.EC0.CRZN = Arg1
                Local1 = \_SB.PCI0.LPCB.EC0.TEMP
                Release (\_SB.PCI0.LPCB.EC0.ECMX)
            }

            Local2 = Local1
            If ((Local1 < Arg3))
            {
                If ((DerefOf (LARE [Arg0]) < Arg3))
                {
                    LARP [Arg0] = Arg3
                }

                Local1 = DerefOf (LARP [Arg0])
            }
            ElseIf ((Local1 > Arg4))
            {
                If ((DerefOf (LARE [Arg0]) > Arg4))
                {
                    LARP [Arg0] = Arg4
                }

                Local1 = DerefOf (LARP [Arg0])
            }

            LARE [Arg0] = Local2
            LARP [Arg0] = Local1
            Return (Local1)
        }

        Method (SETM, 3, Serialized)
        {
            Local5 = 0x00
            If ((Arg0 <= 0x04))
            {
                Acquire (THER, 0xFFFF)
                Local7 = (0x01 << Arg0)
                If (((THSC & Local7) && \_SB.PCI0.LPCB.EC0.ECRG))
                {
                    If ((DerefOf (LATR [Arg0]) && (Arg0 != 0x04)))
                    {
                        Local4 = (Arg2 + 0x02)
                    }
                    Else
                    {
                        Local4 = Arg2
                    }

                    Local2 = DerefOf (DerefOf (TRPC [Arg0]) [0x00])
                    Local0 = 0x01
                    While ((Local0 <= 0x03))
                    {
                        Local6 = DerefOf (DerefOf (TRPC [Arg0]) [Local0])
                        If ((Local4 < Local6))
                        {
                            Break
                        }
                        Else
                        {
                            Local0++
                        }
                    }

                    If ((Local0 == 0x01))
                    {
                        If ((Arg2 > Local2))
                        {
                            If ((DerefOf (LATR [Arg0]) > Local6))
                            {
                                Local0++
                            }
                        }
                    }

                    Local3 = DerefOf (TRPC [Arg0])
                    Local4 = SizeOf (Local3)
                    If (((Local0 != DerefOf (CUZO [Arg0])) && (Local0 < 
                        Local4)))
                    {
                        Local5 = 0x01
                        CUZO [Arg0] = Local0
                        If ((Arg0 < 0x04))
                        {
                            Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
                            \_SB.PCI0.LPCB.EC0.CRZN = Arg1
                            If ((DerefOf (LATR [Arg0]) == 0x00))
                            {
                                \_SB.PCI0.LPCB.EC0.PLTP = Local2
                            }

                            \_SB.PCI0.LPCB.EC0.PHTP = Local6
                            Release (\_SB.PCI0.LPCB.EC0.ECMX)
                        }

                        LATR [Arg0] = Local6
                    }

                    THSC &= ~Local7
                }

                Release (THER)
            }

            Return (Local5)
        }

        Method (CHOT, 1, Serialized)
        {
            If ((DTCD & 0x00020000))
            {
                Local0 = 0x0FAC
            }
            Else
            {
                Local0 = GETP (Arg0, 0x02)
            }

            Return (Local0)
        }

        ThermalZone (CPUZ)
        {
            Method (_HOT, 0, Serialized)  // _HOT: Hot Temperature
            {
                Return (CHOT (0x00))
            }

            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                Return (GETP (0x00, 0x03))
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                \_TZ.OSIT ()
                Local0 = 0x00
                Local0 = GTTP (0x00, 0x01, 0x10, 0x00, 0x7F)
                If (SETM (0x00, 0x01, Local0))
                {
                    Notify (\_TZ.CPUZ, 0x81) // Thermal Trip Point Change
                }

                Return (GETK (Local0))
            }
        }

        ThermalZone (GFXZ)
        {
            Method (_PSV, 0, NotSerialized)  // _PSV: Passive Temperature
            {
                Return (GETP (0x01, 0x01))
            }

            Method (_PSL, 0, NotSerialized)  // _PSL: Passive List
            {
                Return (PSL ())
            }

            Name (_TSP, 0x012C)  // _TSP: Thermal Sampling Period
            Name (_TC1, 0x01)  // _TC1: Thermal Constant 1
            Name (_TC2, 0x02)  // _TC2: Thermal Constant 2
            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                Return (GETP (0x01, 0x03))
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                Local0 = 0x00
                Local0 = GTTP (0x01, 0x02, 0x10, 0x00, 0x7F)
                If (SETM (0x01, 0x02, Local0))
                {
                    Notify (\_TZ.GFXZ, 0x81) // Thermal Trip Point Change
                }

                Return (GETK (Local0))
            }
        }

        ThermalZone (EXTZ)
        {
            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                Return (GETP (0x02, 0x03))
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                Local0 = 0x00
                Local0 = GTTP (0x02, 0x03, 0x10, 0x00, 0x7F)
                Return (GETK (Local0))
            }
        }

        ThermalZone (LOCZ)
        {
            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                Return (GETP (0x03, 0x03))
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                Local0 = 0x00
                Local0 = GTTP (0x03, 0x04, 0x10, 0x00, 0x7F)
                Return (GETK (Local0))
            }
        }

        ThermalZone (BATZ)
        {
            Method (_PSV, 0, NotSerialized)  // _PSV: Passive Temperature
            {
                Return (GETP (0x04, 0x01))
            }

            Method (_PSL, 0, NotSerialized)  // _PSL: Passive List
            {
                Return (PSL ())
            }

            Name (_TSP, 0x012C)  // _TSP: Thermal Sampling Period
            Name (_TC1, 0x32)  // _TC1: Thermal Constant 1
            Name (_TC2, 0x00)  // _TC2: Thermal Constant 2
            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                Return (GETP (0x04, 0x03))
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                Local0 = 0x00
                Local0 = GTTP (0x04, 0x05, 0x00, 0x00, 0x7F)
                If (SETM (0x04, 0x05, Local0))
                {
                    Notify (\_TZ.BATZ, 0x81) // Thermal Trip Point Change
                }

                Return (GETK (Local0))
            }
        }

        Method (NTHS, 1, Serialized)
        {
            If ((Arg0 & 0x01))
            {
                Notify (CPUZ, 0x80) // Thermal Status Change
            }

            If ((Arg0 & 0x02))
            {
                Notify (GFXZ, 0x80) // Thermal Status Change
            }

            If ((Arg0 & 0x04))
            {
                Notify (EXTZ, 0x80) // Thermal Status Change
            }

            If ((Arg0 & 0x08))
            {
                Notify (LOCZ, 0x80) // Thermal Status Change
            }

            If ((Arg0 & 0x10))
            {
                Notify (BATZ, 0x80) // Thermal Status Change
            }
        }

        Method (ECTE, 1, Serialized)
        {
            Local1 = 0x00
            If (Arg0)
            {
                If ((Arg0 & 0x01))
                {
                    Local1 |= 0x01
                }

                If ((Arg0 & 0x02))
                {
                    Local1 |= 0x02
                }

                If ((Arg0 & 0x04))
                {
                    Local1 |= 0x04
                }

                If ((Arg0 & 0x08))
                {
                    Local1 |= 0x08
                }

                If ((Arg0 & 0x10))
                {
                    Local1 |= 0x10
                }
            }
            Else
            {
                Local1 |= 0x10
            }

            Acquire (THER, 0xFFFF)
            THSC |= Local1
            Release (THER)
            NTHS (Local1)
        }

        Method (GFRM, 0, Serialized)
        {
            Local0 = 0x00
            If (\_SB.PCI0.LPCB.EC0.ECRG)
            {
                Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
                Local0 = \_SB.PCI0.LPCB.EC0.FRDC
                Release (\_SB.PCI0.LPCB.EC0.ECMX)
                If (Local0)
                {
                    Local1 = (Local0 >> 0x01)
                    Local2 = (0x0003C000 + Local1)
                    Divide (Local2, Local0, Local1, Local0)
                }
            }

            Return (Local0)
        }

        Method (GTRM, 0, Serialized)
        {
            Local0 = 0x00
            If (\_SB.PCI0.LPCB.EC0.ECRG)
            {
                Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
                Local0 = \_SB.PCI0.LPCB.EC0.FTGC
                Release (\_SB.PCI0.LPCB.EC0.ECMX)
                If (Local0)
                {
                    Local1 = (Local0 >> 0x01)
                    Local2 = (0x0003C000 + Local1)
                    Divide (Local2, Local0, Local1, Local0)
                }
            }

            Return (Local0)
        }

        Method (GFSD, 0, Serialized)
        {
            Local0 = GFRM ()
            Local1 = (Local0 * 0x64)
            Divide (Local1, MRPM, Local1, Local2)
            Return (Local2)
        }

        Method (CTCT, 1, Serialized)
        {
            Local1 = (Arg0 * MRPM) /* \_TZ_.MRPM */
            Divide (Local1, 0x64, Local2, Local0)
            If (Local0)
            {
                Local1 = (Local0 >> 0x01)
                Local2 = (0x0003C000 + Local1)
                Divide (Local2, Local0, Local1, Local0)
            }

            If ((Local0 > 0xF4))
            {
                Local0 = 0xF4
            }

            Return (Local0)
        }

        Method (PSL, 0, Serialized)
        {
            If ((CFGD & 0x01000000))
            {
                If ((TCNT == 0x08))
                {
                    Return (Package (0x08)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1, 
                        \_PR.CPU2, 
                        \_PR.CPU3, 
                        \_PR.CPU4, 
                        \_PR.CPU5, 
                        \_PR.CPU6, 
                        \_PR.CPU7
                    })
                }

                If ((TCNT == 0x04))
                {
                    Return (Package (0x04)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1, 
                        \_PR.CPU2, 
                        \_PR.CPU3
                    })
                }

                Return (Package (0x02)
                {
                    \_PR.CPU0, 
                    \_PR.CPU1
                })
            }
            Else
            {
                Return (Package (0x01)
                {
                    \_PR.CPU0
                })
            }
        }

        ThermalZone (PCHZ)
        {
            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                Return (0x0FAC)
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                Local0 = 0x00
                Local0 = GTTP (0x05, 0x00, PCHT, 0x00, 0x7F)
                Local1 = DerefOf (DerefOf (\_SB.WMID.TSTV [0x02]) [0x02])
                If ((Local1 != 0xFF))
                {
                    Local0 = Local1
                }

                Return (GETK (Local0))
            }
        }

        Method (GDTP, 2, Serialized)
        {
            If ((Arg1 || DTZS ()))
            {
                Local0 = \_SB.PCI0.SBUS.SRDW (Arg0, 0x05)
                If ((Local0 == 0xFFFFFFFF))
                {
                    Local0 = 0x00
                }
                ElseIf ((Local0 & 0x1000))
                {
                    Local0 = 0x00
                }
                Else
                {
                    Local0 >>= 0x04
                    Local0 &= 0xFF
                }

                Return (\_TZ.GETK (Local0))
            }
            Else
            {
                Return (0x0AAC)
            }
        }

        Method (DTZS, 0, NotSerialized)
        {
            If ((DTCD & 0x00010000))
            {
                Return (0x0F)
            }

            Return (0x00)
        }

        ThermalZone (DM1Z)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (DTZS ())
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                Return (GDTP (0x30, 0x00))
            }

            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                Return (0x0FAC)
            }
        }

        ThermalZone (DM2Z)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (DTZS ())
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                Return (GDTP (0x34, 0x00))
            }

            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                Return (0x0FAC)
            }
        }
    }

    Name (\NIST, Package (0x10)
    {
        "0", 
        "1", 
        "2", 
        "3", 
        "4", 
        "5", 
        "6", 
        "7", 
        "8", 
        "9", 
        "A", 
        "B", 
        "C", 
        "D", 
        "E", 
        "F"
    })
    Method (\ISTR, 2, NotSerialized)
    {
        Local0 = Arg0
        Local7 = ""
        Local4 = Arg1
        While ((Local4 > 0x00))
        {
            Local1 = (Local0 & 0x0F)
            Local2 = DerefOf (\NIST [Local1])
            Concatenate (Local2, Local7, Local3)
            Local7 = Local3
            Local0 >>= 0x04
            Local4--
        }

        Return (Local7)
    }

    Method (\SRCP, 2, NotSerialized)
    {
        Local7 = SizeOf (Arg0)
        If ((Local7 != SizeOf (Arg1)))
        {
            Return (0x00)
        }

        Name (ST00, Buffer (Local7){})
        Name (ST01, Buffer (Local7){})
        ST00 = Arg0
        ST01 = Arg1
        Local6 = 0x00
        Local0 = 0x01
        While (((Local6 != Local7) && Local0))
        {
            Local2 = DerefOf (ST00 [Local6])
            Local3 = DerefOf (ST01 [Local6])
            Local6++
            If ((Local2 != Local3))
            {
                Local0 = 0x00
            }
        }

        Return (Local0)
    }

    Name (WOSI, 0xFF)
    Name (OSID, Package (0x03)
    {
        "Microsoft Windows", 
        "Microsoft WindowsME: Millennium Edition", 
        "Microsoft Windows NT"
    })
    Method (\SRCM, 3, NotSerialized)
    {
        Name (ST00, Buffer (0x8C){})
        Name (ST01, Buffer (0x8C){})
        ST00 = Arg0
        ST01 = Arg1
        Local6 = 0x00
        Local0 = 0x01
        While (((Local6 != Arg2) && Local0))
        {
            Local2 = DerefOf (ST00 [Local6])
            Local3 = DerefOf (ST01 [Local6])
            Local6++
            If ((Local2 != Local3))
            {
                Local0 = 0x00
            }
        }

        Return (Local0)
    }

    Method (WCOS, 0, Serialized)
    {
        If ((WOSI == 0xFF))
        {
            Local0 = \_OS
            Local7 = SizeOf (OSID)
            Local1 = 0x00
            While (((Local1 < Local7) && (WOSI == 0xFF)))
            {
                Local2 = \SRCP (Local0, DerefOf (OSID [Local1]))
                If (Local2)
                {
                    WOSI = (Local1 + 0x01)
                }
                Else
                {
                    Local1++
                }
            }

            If ((WOSI == 0xFF))
            {
                WOSI = 0x00
            }

            If (((WOSI == 0x00) || (WOSI == 0x03)))
            {
                If (CondRefOf (\_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001"))
                    {
                        WOSI = 0x04
                    }

                    If (\_OSI ("Windows 2001 SP1"))
                    {
                        WOSI = 0x04
                    }

                    If (\_OSI ("Windows 2001 SP2"))
                    {
                        WOSI = 0x05
                    }

                    If (\_OSI ("Windows 2006"))
                    {
                        WOSI = 0x06
                    }

                    If (\_OSI ("Windows 2009"))
                    {
                        WOSI = 0x07
                    }
                }
            }

            WHOS = WOSI /* \WOSI */
        }

        Return (WOSI) /* \WOSI */
    }

    Method (UPRW, 2, Serialized)
    {
        Local0 = Package (0x02)
            {
                0x00, 
                0x00
            }
        Local0 [0x00] = Arg0
        If ((UWKD == 0x00))
        {
            Local0 [0x01] = Arg1
        }

        Return (Local0)
    }

    Name (EUPC, Package (0x04)
    {
        0xFF, 
        0xFF, 
        0x00, 
        0x00
    })
    Name (EPLD, Buffer (0x10)
    {
        /* 0000 */  0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
        /* 0008 */  0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // 0.......
    })
    Method (CBRT, 2, Serialized)
    {
        Local6 = SizeOf (Arg0)
        Local7 = SizeOf (Arg1)
        If ((Local6 == 0x00))
        {
            Local0 = Arg1
            Return (Local0)
        }

        If ((Local7 == 0x00))
        {
            Local0 = Arg0
            Return (Local0)
        }

        Local1 = (Local7 + Local6)
        Local1 -= 0x02
        Local0 = Buffer (Local1){}
        Local1 = 0x00
        While ((Local1 < SizeOf (Arg0)))
        {
            Local0 [Local1] = DerefOf (Arg0 [Local1])
            Local1++
        }

        Local1 -= 0x02
        Local2 = 0x00
        While ((Local2 < SizeOf (Arg1)))
        {
            Local0 [Local1] = DerefOf (Arg1 [Local2])
            Local1++
            Local2++
        }

        Return (Local0)
    }

    Scope (\_SB)
    {
        Mutex (MSMI, 0x00)
        Method (SSMI, 5, NotSerialized)
        {
            Acquire (MSMI, 0xFFFF)
            If (Arg4)
            {
                Acquire (\_GL, 0xFFFF)
            }

            EAX = (Arg0 << 0x10)
            EBX = Arg1
            ECX = Arg2
            EDX = Arg3
            REFS = 0x00
            \_SB.PCI0.GSWS (Arg0)
            Local0 = REFS /* \REFS */
            If (Arg4)
            {
                Release (\_GL)
            }

            Release (MSMI)
            Return (Local0)
        }

        Name (BCLI, 0x00)
        Name (BCLS, Package (0x03)
        {
            Package (0x0D){}, 
            Package (0x17){}, 
            Package (0x1B){}
        })
        Name (NITS, Package (0x03)
        {
            Buffer (0x16){}, 
            Buffer (0x2A){}, 
            Buffer (0x32){}
        })
        Name (BCLC, 0x00)
        Method (BCL, 0, Serialized)
        {
            If ((BCLC == 0x00))
            {
                If ((\WCOS () > 0x06))
                {
                    BRCT = BCCT /* \BCCT */
                }

                Local7 = 0x00
                If ((BRCT >= 0x15))
                {
                    BCLI = 0x01
                    Local7 = 0x01
                    If ((BRCT == 0x19))
                    {
                        BCLI = 0x02
                    }
                }

                Local1 = 0x00
                If ((DCAP & 0x10))
                {
                    Local0 = BRLV /* \BRLV */
                    Local5 = 0x00
                    Local4 = BMAP /* \BMAP */
                    While ((Local1 < BRCT))
                    {
                        If (Local7)
                        {
                            Local3 = Local1
                        }
                        Else
                        {
                            Local3 = DerefOf (Local4 [Local1])
                        }

                        Local2 = DerefOf (Local0 [Local3])
                        Local3 = (Local2 * 0x64)
                        Divide ((Local3 + 0x7F), 0xFF, Local6, Local2)
                        DerefOf (BCLS [BCLI]) [(Local1 + 0x02)] = 
                            Local2
                        If ((Local2 > Local5))
                        {
                            Local5 = Local2
                        }

                        Local1++
                    }

                    Local3 = (BRCT >> 0x01)
                    DerefOf (BCLS [BCLI]) [0x01] = DerefOf (DerefOf (
                        BCLS [BCLI]) [Local3])
                    DerefOf (BCLS [BCLI]) [0x00] = Local5
                }
                Else
                {
                    Local4 = BCLV /* \BCLV */
                    Local0 = BMAP /* \BMAP */
                    While ((Local1 < (BRCT + 0x02)))
                    {
                        If ((Local7 || (Local1 < 0x02)))
                        {
                            Local3 = Local1
                        }
                        Else
                        {
                            Local3 = DerefOf (Local0 [(Local1 - 0x02)])
                            Local3 += 0x02
                        }

                        Local2 = DerefOf (Local4 [Local3])
                        DerefOf (BCLS [BCLI]) [Local1] = Local2
                        Local1++
                    }
                }

                Local0 = BRNT /* \BRNT */
                Local1 = BMAP /* \BMAP */
                Local2 = 0x00
                While ((Local2 < BRCT))
                {
                    If (Local7)
                    {
                        Local3 = Local2
                    }
                    Else
                    {
                        Local3 = DerefOf (Local1 [Local2])
                    }

                    Local3 <<= 0x01
                    Local5 = (Local2 << 0x01)
                    Local4 = DerefOf (Local0 [Local3])
                    DerefOf (NITS [BCLI]) [Local5] = Local4
                    Local4 = DerefOf (Local0 [(Local3 + 0x01)])
                    DerefOf (NITS [BCLI]) [(Local5 + 0x01)] = 
                        Local4
                    Local2++
                }

                BCLC = 0x01
            }

            Return (DerefOf (BCLS [BCLI]))
        }

        Name (BRIG, 0x64)
        Method (BCM, 1, Serialized)
        {
            Local0 = 0x00
            If ((\WCOS () > 0x05))
            {
                WDPE |= 0x40
                Local0 = 0x01
            }

            BRIG = Arg0
            Local1 = Match (DerefOf (BCLS [BCLI]), MGE, Arg0, MTR, 0x00, 
                0x02)
            If ((Local1 == Ones))
            {
                Local1 = (SizeOf (DerefOf (BCLS [BCLI])) - 0x01)
            }

            Local1 -= 0x02
            If (Local0)
            {
                BRID = Local1
            }

            Return (Local0)
        }

        Method (BQC, 0, Serialized)
        {
            Local0 = BRIG /* \_SB_.BRIG */
            Return (Local0)
        }

        Method (HDDC, 1, Serialized)
        {
            If ((Arg0 == 0x02))
            {
                Local1 = EDID /* \EDID */
            }
            Else
            {
                Local3 = EDID /* \EDID */
                Local0 = 0x80
                Local1 = Buffer (Local0){}
                Local2 = 0x00
                While ((Local2 < Local0))
                {
                    Local1 [Local2] = DerefOf (Local3 [Local2])
                    Local2++
                }
            }

            Return (Local1)
        }

        Method (SBRC, 0, Serialized)
        {
            Local0 = BRID /* \BRID */
            Local4 = (BRCT - 0x01)
            If ((BRID > Local4))
            {
                Local0 = Local4
            }

            If ((BRID < 0x00))
            {
                Local0 = 0x00
            }

            Local2 = BRLV /* \BRLV */
            Local5 = BMAP /* \BMAP */
            If ((BRCT == 0x0B))
            {
                Local0 = DerefOf (Local5 [Local0])
            }

            Local1 = DerefOf (Local2 [Local0])
            Debug = Local1
            Return (Local1)
        }
    }

    Scope (\_SB)
    {
        Device (PCI0)
        {
            Name (_HPP, Package (0x04)  // _HPP: Hot Plug Parameters
            {
                0x10, 
                0x40, 
                0x00, 
                0x00
            })
            Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_ADR, 0x00)  // _ADR: Address
            OperationRegion (HBUS, PCI_Config, 0x00, 0x0100)
            Field (HBUS, DWordAcc, NoLock, Preserve)
            {
                Offset (0x40), 
                EPEN,   1, 
                    ,   11, 
                EPBR,   20, 
                Offset (0x48), 
                MHEN,   1, 
                    ,   14, 
                MHBR,   17, 
                Offset (0x50), 
                GCLK,   1, 
                Offset (0x54), 
                D0EN,   1, 
                Offset (0x60), 
                PXEN,   1, 
                PXSZ,   2, 
                    ,   23, 
                PXBR,   6, 
                Offset (0x68), 
                DIEN,   1, 
                    ,   11, 
                DIBR,   20, 
                Offset (0x70), 
                    ,   20, 
                MEBR,   12, 
                Offset (0x80), 
                    ,   4, 
                PM0H,   2, 
                Offset (0x81), 
                PM1L,   2, 
                    ,   2, 
                PM1H,   2, 
                Offset (0x82), 
                PM2L,   2, 
                    ,   2, 
                PM2H,   2, 
                Offset (0x83), 
                PM3L,   2, 
                    ,   2, 
                PM3H,   2, 
                Offset (0x84), 
                PM4L,   2, 
                    ,   2, 
                PM4H,   2, 
                Offset (0x85), 
                PM5L,   2, 
                    ,   2, 
                PM5H,   2, 
                Offset (0x86), 
                PM6L,   2, 
                    ,   2, 
                PM6H,   2, 
                Offset (0x87), 
                Offset (0xA8), 
                    ,   20, 
                TUUD,   19, 
                Offset (0xBC), 
                    ,   20, 
                TLUD,   12, 
                Offset (0xC8), 
                    ,   7, 
                HTSE,   1
            }

            OperationRegion (MCHT, SystemMemory, 0xFED10000, 0x1100)
            Field (MCHT, ByteAcc, NoLock, Preserve)
            {
            }

            Name (BUF0, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    ,, _Y00)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000CF7,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000CF8,         // Length
                    ,, , TypeStatic, DenseTranslation)
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x00000D00,         // Range Minimum
                    0x0000FFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0000F300,         // Length
                    ,, , TypeStatic, DenseTranslation)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000C3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y01, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C4000,         // Range Minimum
                    0x000C7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y02, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C8000,         // Range Minimum
                    0x000CBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y03, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000CC000,         // Range Minimum
                    0x000CFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y04, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D0000,         // Range Minimum
                    0x000D3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y05, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D4000,         // Range Minimum
                    0x000D7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y06, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D8000,         // Range Minimum
                    0x000DBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y07, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DC000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y08, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E0000,         // Range Minimum
                    0x000E3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y09, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E4000,         // Range Minimum
                    0x000E7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y0A, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E8000,         // Range Minimum
                    0x000EBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y0B, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EC000,         // Range Minimum
                    0x000EFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y0C, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000F0000,         // Range Minimum
                    0x000FFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00010000,         // Length
                    ,, _Y0D, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000000,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    ,, _Y0E, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0xFEDFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    ,, _Y0F, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFEE01000,         // Range Minimum
                    0xFFFFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x011FF000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUF0, \_SB.PCI0._Y00._MAX, PBMX)  // _MAX: Maximum Base Address
                PBMX = ((0x04000000 >> 0x14) - 0x02)
                CreateWordField (BUF0, \_SB.PCI0._Y00._LEN, PBLN)  // _LEN: Length
                PBLN = ((0x04000000 >> 0x14) - 0x01)
                If (PM1L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y01._LEN, C0LN)  // _LEN: Length
                    C0LN = Zero
                }

                If ((PM1L == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y01._RW, C0RW)  // _RW_: Read-Write Status
                    C0RW = Zero
                }

                If (PM1H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y02._LEN, C4LN)  // _LEN: Length
                    C4LN = Zero
                }

                If ((PM1H == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y02._RW, C4RW)  // _RW_: Read-Write Status
                    C4RW = Zero
                }

                If (PM2L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y03._LEN, C8LN)  // _LEN: Length
                    C8LN = Zero
                }

                If ((PM2L == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y03._RW, C8RW)  // _RW_: Read-Write Status
                    C8RW = Zero
                }

                If (PM2H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y04._LEN, CCLN)  // _LEN: Length
                    CCLN = Zero
                }

                If ((PM2H == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y04._RW, CCRW)  // _RW_: Read-Write Status
                    CCRW = Zero
                }

                If (PM3L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y05._LEN, D0LN)  // _LEN: Length
                    D0LN = Zero
                }

                If ((PM3L == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y05._RW, D0RW)  // _RW_: Read-Write Status
                    D0RW = Zero
                }

                If (PM3H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y06._LEN, D4LN)  // _LEN: Length
                    D4LN = Zero
                }

                If ((PM3H == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y06._RW, D4RW)  // _RW_: Read-Write Status
                    D4RW = Zero
                }

                If (PM4L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y07._LEN, D8LN)  // _LEN: Length
                    D8LN = Zero
                }

                If ((PM4L == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y07._RW, D8RW)  // _RW_: Read-Write Status
                    D8RW = Zero
                }

                If (PM4H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y08._LEN, DCLN)  // _LEN: Length
                    DCLN = Zero
                }

                If ((PM4H == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y08._RW, DCRW)  // _RW_: Read-Write Status
                    DCRW = Zero
                }

                If (PM5L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y09._LEN, E0LN)  // _LEN: Length
                    E0LN = Zero
                }

                If ((PM5L == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y09._RW, E0RW)  // _RW_: Read-Write Status
                    E0RW = Zero
                }

                If (PM5H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0A._LEN, E4LN)  // _LEN: Length
                    E4LN = Zero
                }

                If ((PM5H == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0A._RW, E4RW)  // _RW_: Read-Write Status
                    E4RW = Zero
                }

                If (PM6L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0B._LEN, E8LN)  // _LEN: Length
                    E8LN = Zero
                }

                If ((PM6L == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0B._RW, E8RW)  // _RW_: Read-Write Status
                    E8RW = Zero
                }

                If (PM6H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0C._LEN, ECLN)  // _LEN: Length
                    ECLN = Zero
                }

                If ((PM6H == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0C._RW, ECRW)  // _RW_: Read-Write Status
                    ECRW = Zero
                }

                If (PM0H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0D._LEN, F0LN)  // _LEN: Length
                    F0LN = Zero
                }

                If ((PM0H == 0x01))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0D._RW, F0RW)  // _RW_: Read-Write Status
                    F0RW = Zero
                }

                CreateDWordField (BUF0, \_SB.PCI0._Y0E._MIN, M1MN)  // _MIN: Minimum Base Address
                CreateDWordField (BUF0, \_SB.PCI0._Y0E._MAX, M1MX)  // _MAX: Maximum Base Address
                CreateDWordField (BUF0, \_SB.PCI0._Y0E._LEN, M1LN)  // _LEN: Length
                M1MN = (TLUD << 0x14)
                Local0 = (PXBR << 0x1A)
                M1MX = (Local0 - 0x01)
                M1LN = ((M1MX - M1MN) + 0x01)
                CreateDWordField (BUF0, \_SB.PCI0._Y0F._MIN, M2MN)  // _MIN: Minimum Base Address
                CreateDWordField (BUF0, \_SB.PCI0._Y0F._MAX, M2MX)  // _MAX: Maximum Base Address
                CreateDWordField (BUF0, \_SB.PCI0._Y0F._LEN, M2LN)  // _LEN: Length
                Local1 = (0x10000000 >> PXSZ) /* \_SB_.PCI0.PXSZ */
                M2MN = (Local0 + Local1)
                M2LN = ((M2MX - M2MN) + 0x01)
                Return (BUF0) /* \_SB_.PCI0.BUF0 */
            }

            Device (PDRC)
            {
                Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                Name (_UID, 0x01)  // _UID: Unique ID
                Name (BUF0, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00004000,         // Address Length
                        _Y10)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00008000,         // Address Length
                        _Y11)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00001000,         // Address Length
                        _Y12)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00001000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00001000,         // Address Length
                        _Y14)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y13)
                    Memory32Fixed (ReadWrite,
                        0xFED20000,         // Address Base
                        0x00020000,         // Address Length
                        )
                    Memory32Fixed (ReadOnly,
                        0xFED90000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED45000,         // Address Base
                        0x0004B000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFEC00000,         // Address Base
                        0x00001000,         // Address Length
                        )
                })
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y10._BAS, RBR0)  // _BAS: Base Address
                    RBR0 = (\_SB.PCI0.LPCB.RCBA << 0x0E)
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y11._BAS, MBR0)  // _BAS: Base Address
                    MBR0 = (\_SB.PCI0.MHBR << 0x0F)
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y12._BAS, DBR0)  // _BAS: Base Address
                    DBR0 = (\_SB.PCI0.DIBR << 0x0C)
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y13._BAS, XBR0)  // _BAS: Base Address
                    XBR0 = (\_SB.PCI0.PXBR << 0x1A)
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y13._LEN, XSZ0)  // _LEN: Length
                    XSZ0 = (0x10000000 >> \_SB.PCI0.PXSZ)
                    If (TBRB)
                    {
                        CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y14._BAS, TBR0)  // _BAS: Base Address
                        TBR0 = TBRB /* \TBRB */
                    }
                    Else
                    {
                        CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y14._LEN, TBLN)  // _LEN: Length
                        TBLN = Zero
                    }

                    Return (BUF0) /* \_SB_.PCI0.PDRC.BUF0 */
                }
            }

            Device (PEGP)
            {
                Name (_ADR, 0x00010000)  // _ADR: Address
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                0x00, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                0x00, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                0x00, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                0x00, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                LNKA, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                LNKB, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKC, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKD, 
                                0x00
                            }
                        })
                    }
                }
            }

            Device (GFX0)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
                {
                    DSEN = (Arg0 & 0x07)
                    HDOS (Arg0)
                }

                Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
                {
                    If ((DODC == 0x00))
                    {
                        DODC = 0x01
                        If (SCIP ())
                        {
                            HDOD ()
                            NDID = 0x00
                            If (CondRefOf (IDAB)){}
                            Else
                            {
                                If ((DIDL != Zero))
                                {
                                    DID1 = SDDL (DIDL)
                                }

                                If ((DDL2 != Zero))
                                {
                                    DID2 = SDDL (DDL2)
                                }

                                If ((DDL3 != Zero))
                                {
                                    DID3 = SDDL (DDL3)
                                }

                                If ((DDL4 != Zero))
                                {
                                    DID4 = SDDL (DDL4)
                                }

                                If ((DDL5 != Zero))
                                {
                                    DID5 = SDDL (DDL5)
                                }

                                If ((DDL6 != Zero))
                                {
                                    DID6 = SDDL (DDL6)
                                }

                                If ((DDL7 != Zero))
                                {
                                    DID7 = SDDL (DDL7)
                                }

                                If ((DDL8 != Zero))
                                {
                                    DID8 = SDDL (DDL8)
                                }
                            }
                        }

                        If ((NDID == 0x00))
                        {
                            DerefOf (DODS [NDID]) [0x00] = 0x0400
                        }

                        If ((NDID == 0x01))
                        {
                            DerefOf (DODS [NDID]) [0x00] = (0x00010000 | DID1
                                )
                        }

                        If ((NDID == 0x02))
                        {
                            DerefOf (DODS [NDID]) [0x00] = (0x00010000 | DID1
                                )
                            DerefOf (DODS [NDID]) [0x01] = (0x00010000 | DID2
                                )
                        }

                        If ((NDID == 0x03))
                        {
                            DerefOf (DODS [NDID]) [0x00] = (0x00010000 | DID1
                                )
                            DerefOf (DODS [NDID]) [0x01] = (0x00010000 | DID2
                                )
                            DerefOf (DODS [NDID]) [0x02] = (0x00010000 | DID3
                                )
                        }

                        If ((NDID == 0x04))
                        {
                            DerefOf (DODS [NDID]) [0x00] = (0x00010000 | DID1
                                )
                            DerefOf (DODS [NDID]) [0x01] = (0x00010000 | DID2
                                )
                            DerefOf (DODS [NDID]) [0x02] = (0x00010000 | DID3
                                )
                            DerefOf (DODS [NDID]) [0x03] = (0x00010000 | DID4
                                )
                        }

                        If ((NDID == 0x05))
                        {
                            DerefOf (DODS [NDID]) [0x00] = (0x00010000 | DID1
                                )
                            DerefOf (DODS [NDID]) [0x01] = (0x00010000 | DID2
                                )
                            DerefOf (DODS [NDID]) [0x02] = (0x00010000 | DID3
                                )
                            DerefOf (DODS [NDID]) [0x03] = (0x00010000 | DID4
                                )
                            DerefOf (DODS [NDID]) [0x04] = (0x00010000 | DID5
                                )
                        }

                        If ((NDID == 0x06))
                        {
                            DerefOf (DODS [NDID]) [0x00] = (0x00010000 | DID1
                                )
                            DerefOf (DODS [NDID]) [0x01] = (0x00010000 | DID2
                                )
                            DerefOf (DODS [NDID]) [0x02] = (0x00010000 | DID3
                                )
                            DerefOf (DODS [NDID]) [0x03] = (0x00010000 | DID4
                                )
                            DerefOf (DODS [NDID]) [0x04] = (0x00010000 | DID5
                                )
                            DerefOf (DODS [NDID]) [0x05] = (0x00010000 | DID6
                                )
                        }

                        If ((NDID == 0x07))
                        {
                            DerefOf (DODS [NDID]) [0x00] = (0x00010000 | DID1
                                )
                            DerefOf (DODS [NDID]) [0x01] = (0x00010000 | DID2
                                )
                            DerefOf (DODS [NDID]) [0x02] = (0x00010000 | DID3
                                )
                            DerefOf (DODS [NDID]) [0x03] = (0x00010000 | DID4
                                )
                            DerefOf (DODS [NDID]) [0x04] = (0x00010000 | DID5
                                )
                            DerefOf (DODS [NDID]) [0x05] = (0x00010000 | DID6
                                )
                            DerefOf (DODS [NDID]) [0x06] = (0x00010000 | DID7
                                )
                        }

                        If ((NDID == 0x08))
                        {
                            DerefOf (DODS [NDID]) [0x00] = (0x00010000 | DID1
                                )
                            DerefOf (DODS [NDID]) [0x01] = (0x00010000 | DID2
                                )
                            DerefOf (DODS [NDID]) [0x02] = (0x00010000 | DID3
                                )
                            DerefOf (DODS [NDID]) [0x03] = (0x00010000 | DID4
                                )
                            DerefOf (DODS [NDID]) [0x04] = (0x00010000 | DID5
                                )
                            DerefOf (DODS [NDID]) [0x05] = (0x00010000 | DID6
                                )
                            DerefOf (DODS [NDID]) [0x06] = (0x00010000 | DID7
                                )
                            DerefOf (DODS [NDID]) [0x07] = (0x00010000 | DID8
                                )
                        }
                    }

                    Local0 = NDID /* \NDID */
                    If ((NDID > 0x08))
                    {
                        Local0 = 0x00
                    }

                    Return (DerefOf (DODS [Local0]))
                }

                Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                {
                    If ((\_SB.PCI0.GFX0.INIM == 0x01))
                    {
                        \_SB.SSMI (0xEA81, 0x00, 0x00, 0x00, 0x00)
                        \_SB.PCI0.GFX0.GLID (\_SB.LID._LID ())
                        \_SB.PCI0.GFX0.INIM = 0x00
                    }
                }

                Device (DD01)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If ((DID1 == 0x00))
                        {
                            Return (0x01)
                        }
                        Else
                        {
                            Return ((0xFFFF & DID1))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        Return (CDDS (DID1))
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD1) /* \NXD1 */
                        }

                        Return (NDDS (DID1))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (((Arg0 & 0xC0000000) == 0xC0000000))
                        {
                            CSTE = NSTE /* \NSTE */
                        }
                    }
                }

                Device (DD02)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If ((DID2 == 0x00))
                        {
                            Return (0x02)
                        }
                        Else
                        {
                            Return ((0xFFFF & DID2))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If ((LIDS == 0x00))
                        {
                            Return (0x00)
                        }

                        Return (CDDS (DID2))
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD2) /* \NXD2 */
                        }

                        Return (NDDS (DID2))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (((Arg0 & 0xC0000000) == 0xC0000000))
                        {
                            CSTE = NSTE /* \NSTE */
                        }
                    }
                }

                Device (DD03)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If ((DID3 == 0x00))
                        {
                            Return (0x03)
                        }
                        Else
                        {
                            Return ((0xFFFF & DID3))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If ((DID3 == 0x00))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID3))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD3) /* \NXD3 */
                        }

                        Return (NDDS (DID3))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (((Arg0 & 0xC0000000) == 0xC0000000))
                        {
                            CSTE = NSTE /* \NSTE */
                        }
                    }
                }

                Device (DD04)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If ((DID4 == 0x00))
                        {
                            Return (0x04)
                        }
                        Else
                        {
                            Return ((0xFFFF & DID4))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If ((DID4 == 0x00))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID4))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD4) /* \NXD4 */
                        }

                        Return (NDDS (DID4))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (((Arg0 & 0xC0000000) == 0xC0000000))
                        {
                            CSTE = NSTE /* \NSTE */
                        }
                    }
                }

                Device (DD05)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If ((DID5 == 0x00))
                        {
                            Return (0x05)
                        }
                        Else
                        {
                            Return ((0xFFFF & DID5))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If ((DID5 == 0x00))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID5))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD5) /* \NXD5 */
                        }

                        Return (NDDS (DID5))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (((Arg0 & 0xC0000000) == 0xC0000000))
                        {
                            CSTE = NSTE /* \NSTE */
                        }
                    }
                }

                Device (DD06)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If ((DID6 == 0x00))
                        {
                            Return (0x06)
                        }
                        Else
                        {
                            Return ((0xFFFF & DID6))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If ((DID6 == 0x00))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID6))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD6) /* \NXD6 */
                        }

                        Return (NDDS (DID6))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (((Arg0 & 0xC0000000) == 0xC0000000))
                        {
                            CSTE = NSTE /* \NSTE */
                        }
                    }
                }

                Device (DD07)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If ((DID7 == 0x00))
                        {
                            Return (0x07)
                        }
                        Else
                        {
                            Return ((0xFFFF & DID7))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If ((DID7 == 0x00))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID7))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD7) /* \NXD7 */
                        }

                        Return (NDDS (DID7))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (((Arg0 & 0xC0000000) == 0xC0000000))
                        {
                            CSTE = NSTE /* \NSTE */
                        }
                    }
                }

                Device (DD08)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If ((DID8 == 0x00))
                        {
                            Return (0x08)
                        }
                        Else
                        {
                            Return ((0xFFFF & DID8))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If ((DID8 == 0x00))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID8))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD8) /* \NXD8 */
                        }

                        Return (NDDS (DID8))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (((Arg0 & 0xC0000000) == 0xC0000000))
                        {
                            CSTE = NSTE /* \NSTE */
                        }
                    }
                }

                Method (SDDL, 1, NotSerialized)
                {
                    NDID++
                    Local0 = (Arg0 & 0x0F0F)
                    Local1 = (0x80000000 | Local0)
                    If ((DIDL == Local0))
                    {
                        Return (Local1)
                    }

                    If ((DDL2 == Local0))
                    {
                        Return (Local1)
                    }

                    If ((DDL3 == Local0))
                    {
                        Return (Local1)
                    }

                    If ((DDL4 == Local0))
                    {
                        Return (Local1)
                    }

                    If ((DDL5 == Local0))
                    {
                        Return (Local1)
                    }

                    If ((DDL6 == Local0))
                    {
                        Return (Local1)
                    }

                    If ((DDL7 == Local0))
                    {
                        Return (Local1)
                    }

                    If ((DDL8 == Local0))
                    {
                        Return (Local1)
                    }

                    Return (0x00)
                }

                Method (CDDS, 1, NotSerialized)
                {
                    Local0 = (Arg0 & 0x0F0F)
                    If ((0x00 == Local0))
                    {
                        Return (0x1D)
                    }

                    If ((CADL == Local0))
                    {
                        Return (0x1F)
                    }

                    If ((CAL2 == Local0))
                    {
                        Return (0x1F)
                    }

                    If ((CAL3 == Local0))
                    {
                        Return (0x1F)
                    }

                    If ((CAL4 == Local0))
                    {
                        Return (0x1F)
                    }

                    If ((CAL5 == Local0))
                    {
                        Return (0x1F)
                    }

                    If ((CAL6 == Local0))
                    {
                        Return (0x1F)
                    }

                    If ((CAL7 == Local0))
                    {
                        Return (0x1F)
                    }

                    If ((CAL8 == Local0))
                    {
                        Return (0x1F)
                    }

                    Return (0x1D)
                }

                Method (NDDS, 1, NotSerialized)
                {
                    Local0 = (Arg0 & 0x0F0F)
                    If ((0x00 == Local0))
                    {
                        Return (0x00)
                    }

                    If ((NADL == Local0))
                    {
                        Return (0x01)
                    }

                    If ((NDL2 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((NDL3 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((NDL4 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((NDL5 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((NDL6 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((NDL7 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((NDL8 == Local0))
                    {
                        Return (0x01)
                    }

                    Return (0x00)
                }

                Scope (\_SB.PCI0)
                {
                    OperationRegion (MCHP, PCI_Config, 0x40, 0xC0)
                    Field (MCHP, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x60), 
                        TASM,   10, 
                        Offset (0x62)
                    }
                }

                OperationRegion (IGDP, PCI_Config, 0x40, 0xC0)
                Field (IGDP, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x12), 
                        ,   1, 
                    GIVD,   1, 
                        ,   2, 
                    GUMA,   3, 
                    Offset (0x14), 
                        ,   4, 
                    GMFN,   1, 
                    Offset (0x18), 
                    Offset (0xA4), 
                    ASLE,   8, 
                    Offset (0xA8), 
                    GSSE,   1, 
                    GSSB,   14, 
                    GSES,   1, 
                    Offset (0xB0), 
                        ,   12, 
                    CDVL,   1, 
                    Offset (0xB2), 
                    Offset (0xB5), 
                    LBPC,   8, 
                    Offset (0xBC), 
                    ASLS,   32
                }

                OperationRegion (IGDM, SystemMemory, ASLB, 0x2000)
                Field (IGDM, AnyAcc, NoLock, Preserve)
                {
                    SIGN,   128, 
                    SIZE,   32, 
                    OVER,   32, 
                    SVER,   256, 
                    VVER,   128, 
                    GVER,   128, 
                    MBOX,   32, 
                    DMOD,   32, 
                    Offset (0x100), 
                    DRDY,   32, 
                    CSTS,   32, 
                    CEVT,   32, 
                    Offset (0x120), 
                    DIDL,   32, 
                    DDL2,   32, 
                    DDL3,   32, 
                    DDL4,   32, 
                    DDL5,   32, 
                    DDL6,   32, 
                    DDL7,   32, 
                    DDL8,   32, 
                    CPDL,   32, 
                    CPL2,   32, 
                    CPL3,   32, 
                    CPL4,   32, 
                    CPL5,   32, 
                    CPL6,   32, 
                    CPL7,   32, 
                    CPL8,   32, 
                    CADL,   32, 
                    CAL2,   32, 
                    CAL3,   32, 
                    CAL4,   32, 
                    CAL5,   32, 
                    CAL6,   32, 
                    CAL7,   32, 
                    CAL8,   32, 
                    NADL,   32, 
                    NDL2,   32, 
                    NDL3,   32, 
                    NDL4,   32, 
                    NDL5,   32, 
                    NDL6,   32, 
                    NDL7,   32, 
                    NDL8,   32, 
                    ASLP,   32, 
                    TIDX,   32, 
                    CHPD,   32, 
                    CLID,   32, 
                    CDCK,   32, 
                    SXSW,   32, 
                    EVTS,   32, 
                    CNOT,   32, 
                    NRDY,   32, 
                    Offset (0x200), 
                    SCIE,   1, 
                    GEFC,   4, 
                    GXFC,   3, 
                    GESF,   8, 
                    Offset (0x204), 
                    PARM,   32, 
                    DSLP,   32, 
                    Offset (0x300), 
                    ARDY,   32, 
                    ASLC,   32, 
                    TCHE,   32, 
                    ALSI,   32, 
                    BCLP,   32, 
                    PFIT,   32, 
                    CBLV,   32, 
                    BCLM,   320, 
                    CPFM,   32, 
                    EPFM,   32, 
                    PLUT,   592, 
                    PFMB,   32, 
                    CCDV,   32, 
                    PCFT,   32, 
                    Offset (0x400), 
                    GVD1,   49152, 
                    PHED,   32, 
                    BDDC,   2048
                }

                If (CondRefOf (FPED))
                {
                    FPED ()
                }

                Name (DBTB, Package (0x15)
                {
                    0x00, 
                    0x07, 
                    0x38, 
                    0x01C0, 
                    0x0E00, 
                    0x3F, 
                    0x01C7, 
                    0x0E07, 
                    0x01F8, 
                    0x0E38, 
                    0x0FC0, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x7000, 
                    0x7007, 
                    0x7038, 
                    0x71C0, 
                    0x7E00
                })
                Name (CDCT, Package (0x05)
                {
                    Package (0x02)
                    {
                        0xE4, 
                        0x0140
                    }, 

                    Package (0x02)
                    {
                        0xDE, 
                        0x014D
                    }, 

                    Package (0x02)
                    {
                        0xDE, 
                        0x014D
                    }, 

                    Package (0x02)
                    {
                        0x00, 
                        0x00
                    }, 

                    Package (0x02)
                    {
                        0xDE, 
                        0x014D
                    }
                })
                Name (SUCC, 0x01)
                Name (NVLD, 0x02)
                Name (CRIT, 0x04)
                Name (NCRT, 0x06)
                Method (GSCI, 0, Serialized)
                {
                    Method (GBDA, 0, Serialized)
                    {
                        If ((GESF == 0x00))
                        {
                            PARM = 0x59
                            GESF = Zero
                            Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                        }

                        If ((GESF == 0x01))
                        {
                            PARM = 0x80
                            GESF = Zero
                            Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                        }

                        If ((GESF == 0x04))
                        {
                            PARM = 0x30000000
                            GESF = Zero
                            Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                        }

                        If ((GESF == 0x05))
                        {
                            PARM |= (LIDS << 0x10)
                            PARM += 0x00010000
                            GESF = Zero
                            Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                        }

                        If ((GESF == 0x06))
                        {
                            PARM = Zero
                            GESF = Zero
                            Return (Zero)
                        }

                        If ((GESF == 0x07))
                        {
                            PARM = GIVD /* \_SB_.PCI0.GFX0.GIVD */
                            PARM ^= 0x01
                            PARM |= (GMFN << 0x01)
                            PARM |= (0x03 << 0x0B)
                            PARM |= (IDMS << 0x11)
                            PARM |= (DerefOf (DerefOf (CDCT [HVCO]) [CDVL]) << 
                                0x15) /* \_SB_.PCI0.GFX0.PARM */
                            GESF = 0x01
                            Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                        }

                        If ((GESF == 0x0A))
                        {
                            PARM = 0x00
                            GESF = 0x00
                            Return (Zero)
                        }

                        GESF = Zero
                        Return (CRIT) /* \_SB_.PCI0.GFX0.CRIT */
                    }

                    Method (SBCB, 0, Serialized)
                    {
                        If ((GESF == 0x00))
                        {
                            PARM = 0x00
                            PARM = 0x000F87FD
                            PARM = 0x40
                            GESF = Zero
                            Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                        }

                        If ((GESF == 0x07))
                        {
                            If ((PARM == 0x00))
                            {
                                Local0 = CLID /* \_SB_.PCI0.GFX0.CLID */
                                If ((0x80000000 & Local0))
                                {
                                    CLID &= 0x0F
                                    GLID (CLID)
                                }
                            }

                            GESF = Zero
                            PARM = Zero
                            Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                        }

                        GESF = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GEFC == 0x04))
                    {
                        GXFC = GBDA ()
                    }

                    If ((GEFC == 0x06))
                    {
                        GXFC = SBCB ()
                    }

                    GEFC = 0x00
                    SCIS = 0x01
                    GSSE = 0x00
                    SCIE = 0x00
                    Return (Zero)
                }

                Method (PDRD, 0, NotSerialized)
                {
                    If (!DRDY)
                    {
                        Sleep (ASLP)
                    }

                    Return (!DRDY)
                }

                Method (PSTS, 0, NotSerialized)
                {
                    If ((CSTS > 0x02))
                    {
                        Sleep (ASLP)
                    }

                    Return ((CSTS == 0x03))
                }

                Method (GNOT, 2, NotSerialized)
                {
                    If (PDRD ())
                    {
                        Return (0x01)
                    }

                    CEVT = Arg0
                    CSTS = 0x03
                    If (((CHPD == 0x00) && (Arg1 == 0x00)))
                    {
                        If (((OSYS > 0x07D0) && (OSYS < 0x07D6)))
                        {
                            Notify (\_SB.PCI0, Arg1)
                        }
                        Else
                        {
                            Notify (\_SB.PCI0.GFX0, Arg1)
                        }
                    }

                    If (CondRefOf (WMAB))
                    {
                        WMAB (Arg0)
                    }
                    Else
                    {
                        Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
                    }

                    If (!PSTS ())
                    {
                        CEVT = 0x00
                    }

                    Return (0x00)
                }

                Method (GHDS, 1, NotSerialized)
                {
                    TIDX = Arg0
                    Return (GNOT (0x01, 0x00))
                }

                Method (GLID, 1, NotSerialized)
                {
                    CLID = Arg0
                    Return (GNOT (0x02, 0x00))
                }

                Method (GDCK, 1, NotSerialized)
                {
                    CDCK = Arg0
                    Return (GNOT (0x04, 0x00))
                }

                Method (PARD, 0, NotSerialized)
                {
                    If (!ARDY)
                    {
                        Sleep (ASLP)
                    }

                    Return (!ARDY)
                }

                Method (AINT, 2, NotSerialized)
                {
                    If (!(TCHE & (0x01 << Arg0)))
                    {
                        Return (0x01)
                    }

                    If (PARD ())
                    {
                        Return (0x01)
                    }

                    If ((Arg0 == 0x02))
                    {
                        If (CPFM)
                        {
                            Local0 = (CPFM & 0x0F)
                            Local1 = (EPFM & 0x0F)
                            If ((Local0 == 0x01))
                            {
                                If ((Local1 & 0x06))
                                {
                                    PFIT = 0x06
                                }
                                ElseIf ((Local1 & 0x08))
                                {
                                    PFIT = 0x08
                                }
                                Else
                                {
                                    PFIT = 0x01
                                }
                            }

                            If ((Local0 == 0x06))
                            {
                                If ((Local1 & 0x08))
                                {
                                    PFIT = 0x08
                                }
                                ElseIf ((Local1 & 0x01))
                                {
                                    PFIT = 0x01
                                }
                                Else
                                {
                                    PFIT = 0x06
                                }
                            }

                            If ((Local0 == 0x08))
                            {
                                If ((Local1 & 0x01))
                                {
                                    PFIT = 0x01
                                }
                                ElseIf ((Local1 & 0x06))
                                {
                                    PFIT = 0x06
                                }
                                Else
                                {
                                    PFIT = 0x08
                                }
                            }
                        }
                        Else
                        {
                            PFIT ^= 0x07
                        }

                        PFIT |= 0x80000000
                        ASLC = 0x04
                    }
                    ElseIf ((Arg0 == 0x01))
                    {
                        BCLP = Arg1
                        BCLP |= 0x80000000
                        ASLC = 0x02
                    }
                    ElseIf ((Arg0 == 0x00))
                    {
                        ALSI = Arg1
                        ASLC = 0x01
                    }
                    Else
                    {
                        Return (0x01)
                    }

                    ASLE = 0x01
                    Return (0x00)
                }

                Method (SCIP, 0, NotSerialized)
                {
                    If ((OVER != 0x00))
                    {
                        Return (!GSMI)
                    }

                    Return (0x00)
                }
            }

            Scope (GFX0)
            {
                Name (DODC, 0x00)
                Name (INIM, 0x00)
                Name (HPDD, Package (0x09)
                {
                    0x0400, 
                    0x0100, 
                    0x0200, 
                    0x0300, 
                    0x0301, 
                    0x0302, 
                    0x0303, 
                    0x0304, 
                    0x0305
                })
                Name (DSPR, Buffer (0x09)
                {
                    /* 0000 */  0x00, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x01,  // ........
                    /* 0008 */  0x02                                             // .
                })
                Name (DODS, Package (0x09)
                {
                    Package (0x01)
                    {
                        0xFFFFFFFF
                    }, 

                    Package (0x01)
                    {
                        0xFFFFFFFF
                    }, 

                    Package (0x02)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x03)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x04)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x05)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x06)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x07)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x08)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }
                })
                Method (_INI, 0, NotSerialized)  // _INI: Initialize
                {
                    INIM = 0x01
                    DKET ()
                    Local0 = \_SB.SBRC ()
                    \_SB.PCI0.GFX0.BCLP = (Local0 | 0x80000000)
                    WDSA = 0x00
                    WDST = 0x00
                    WDGN = 0x00
                }

                Method (HDOS, 1, NotSerialized)
                {
                    Local0 = (WDPE & 0xF8)
                    Local1 = (WDPE & 0x87)
                    WDPE = (Local0 | Arg0)
                    If (CondRefOf (^PDOS, Local2))
                    {
                        ^PDOS (Arg0, Local1)
                    }
                }

                Method (HDOD, 0, NotSerialized)
                {
                    Local1 = 0x01
                    If ((TCHE & 0x02))
                    {
                        Local1 = 0x03
                    }

                    DCAP |= Local1
                }

                Method (PDDS, 1, NotSerialized)
                {
                    Local0 = (Arg0 & 0x0F0F)
                    If ((0x00 == Local0))
                    {
                        Return (0x00)
                    }

                    If ((CPDL == Local0))
                    {
                        Return (0x01)
                    }

                    If ((CPL2 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((CPL3 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((CPL4 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((CPL5 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((CPL6 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((CPL7 == Local0))
                    {
                        Return (0x01)
                    }

                    If ((CPL8 == Local0))
                    {
                        Return (0x01)
                    }

                    Return (0x00)
                }

                Method (UPNA, 2, Serialized)
                {
                    If ((Arg0 == 0x00))
                    {
                        Local1 = NADL /* \_SB_.PCI0.GFX0.NADL */
                        NADL = Arg1
                    }

                    If ((Arg0 == 0x01))
                    {
                        Local1 = NDL2 /* \_SB_.PCI0.GFX0.NDL2 */
                        NDL2 = Arg1
                    }

                    If ((Arg0 == 0x02))
                    {
                        Local1 = NDL3 /* \_SB_.PCI0.GFX0.NDL3 */
                        NDL3 = Arg1
                    }

                    If ((Arg0 == 0x03))
                    {
                        Local1 = NDL4 /* \_SB_.PCI0.GFX0.NDL4 */
                        NDL4 = Arg1
                    }

                    If ((Arg0 == 0x04))
                    {
                        Local1 = NDL5 /* \_SB_.PCI0.GFX0.NDL5 */
                        NDL5 = Arg1
                    }

                    If ((Arg0 == 0x05))
                    {
                        Local1 = NDL6 /* \_SB_.PCI0.GFX0.NDL6 */
                        NDL6 = Arg1
                    }

                    If ((Arg0 == 0x06))
                    {
                        Local1 = NDL7 /* \_SB_.PCI0.GFX0.NDL7 */
                        NDL7 = Arg1
                    }

                    If ((Arg0 == 0x07))
                    {
                        Local1 = NDL8 /* \_SB_.PCI0.GFX0.NDL8 */
                        NDL8 = Arg1
                    }

                    Return (Local1)
                }

                Method (UPAA, 0, Serialized)
                {
                    Local1 = 0x00
                    While ((Local1 < SizeOf (HPDD)))
                    {
                        Local0 = (0x01 << Local1)
                        Local2 = DerefOf (HPDD [Local1])
                        If (PDDS (Local2))
                        {
                            WDST |= Local0
                        }
                        Else
                        {
                            WDST &= ~Local0
                        }

                        If ((CDDS (Local2) == 0x1F))
                        {
                            WDSA |= Local0
                        }
                        Else
                        {
                            WDSA &= ~Local0
                        }

                        Local1++
                    }
                }

                Method (UPND, 0, Serialized)
                {
                    Local1 = WDGN /* \WDGN */
                    Local0 = 0x00
                    Local2 = 0x00
                    While (((Local0 < SizeOf (DSPR)) && Local1))
                    {
                        Local3 = DerefOf (DSPR [Local0])
                        Local4 = (0x01 << Local3)
                        If ((Local1 & Local4))
                        {
                            Local5 = DerefOf (HPDD [Local3])
                            UPNA (Local2, Local5)
                            Local2++
                            Local1 &= ~Local4
                        }

                        If ((Local2 >= 0x02))
                        {
                            Break
                        }

                        Local0++
                    }

                    WDGN ^= Local1
                    Local1 = 0x01
                    While (((Local2 < 0x08) && Local1))
                    {
                        Local1 = UPNA (Local2, 0x00)
                        Local2++
                    }
                }

                Method (GF4E, 1, Serialized)
                {
                    UPAA ()
                    If ((WDSA == 0x01))
                    {
                        WDGN = (WDST | 0x01)
                    }
                    ElseIf ((WDSA & 0x01))
                    {
                        WDGN = (WDST & ~0x01)
                    }
                    Else
                    {
                        WDGN = 0x01
                    }

                    UPND ()
                    Signal (\_SB.F4EV)
                    GHDS (0x00)
                    Return (0x01)
                }

                Method (DKET, 0, NotSerialized)
                {
                    If ((\_SB.PCI0.GFX0.GIVD == 0x00))
                    {
                        Debug = "GFX DockEvent Enter"
                        Local0 = \_SB.DCKD ()
                        Debug = "Dock Status"
                        Debug = Local0
                        \_SB.PCI0.GFX0.GDCK (Local0)
                        Debug = "GFX DockEvent Exit"
                    }

                    Return (0x00)
                }

                Method (RFHS, 1, Serialized)
                {
                    If (Arg0)
                    {
                        UPAA ()
                    }
                    Else
                    {
                        Wait (\_SB.F4EV, 0x0500)
                    }
                }

                Method (SNXS, 0, Serialized)
                {
                    UPND ()
                    GHDS (0x00)
                }

                Method (SBRV, 0, Serialized)
                {
                    Debug = "Set Brightness"
                    If (((DCAP & 0x02) == 0x00))
                    {
                        If ((TCHE & 0x02))
                        {
                            Debug = "TCHE set"
                            DCAP |= 0x02
                        }
                    }

                    Local3 = (DCAP & 0x02)
                    If (Local3)
                    {
                        Debug = "OpRegion take control of Brightness"
                        Local1 = \_SB.SBRC ()
                        Debug = Local1
                        AINT (0x01, Local1)
                    }

                    Return (Local3)
                }

                Scope (DD02)
                {
                    Method (_BCL, 0, Serialized)  // _BCL: Brightness Control Levels
                    {
                        Return (\_SB.BCL ())
                    }

                    Method (_BCM, 1, Serialized)  // _BCM: Brightness Control Method
                    {
                        Local0 = \_SB.BCM (Arg0)
                        If (Local0)
                        {
                            Local1 = BRID /* \BRID */
                            If ((SBRV () == 0x00))
                            {
                                \_SB.SSMI (0xEA74, 0x04, Local1, 0x00, 0x00)
                            }

                            Signal (\_SB.BEVT)
                        }
                    }

                    Method (_BQC, 0, Serialized)  // _BQC: Brightness Query Current
                    {
                        Return (\_SB.BQC ())
                    }
                }

                Scope (\_GPE)
                {
                    Method (_L06, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
                    {
                        If ((\_SB.PCI0.GFX0.GIVD == 0x00))
                        {
                            If ((\_SB.PCI0.GFX0.GSSE && !GSMI))
                            {
                                \_SB.PCI0.GFX0.GSCI ()
                            }
                            Else
                            {
                                SCIS = 0x01
                            }
                        }
                    }

                    Name (WOAT, 0xFF)
                    Method (CNDD, 1, NotSerialized)
                    {
                        If ((\_SB.PCI0.GFX0.GIVD == 0x00))
                        {
                            If ((Arg0 || (WDST != WOAT)))
                            {
                                WOAT = WDST /* \WDST */
                                If ((\WCOS () >= 0x04))
                                {
                                    Notify (\_SB.PCI0, 0x00) // Bus Check
                                }
                                Else
                                {
                                    Notify (\_SB.PCI0.GFX0, 0x00) // Bus Check
                                }

                                Sleep (0x02EE)
                            }
                        }
                    }

                    Method (VHIV, 3, Serialized)
                    {
                        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler, x=0-9, A-Z
                        If (\_SB.PCI0.GFX0.GIVD)
                        {
                            Return (0x01)
                        }

                        _T_0 = Arg2
                        If ((_T_0 == 0x01))
                        {
                            If ((Arg0 & 0x80))
                            {
                                Notify (\_SB.PCI0.GFX0.DD02, Arg0)
                            }
                            Else
                            {
                                Debug = "Verify no OS controlled brightness b/c VideoBrightnessEvent"
                                If (((WDPE & 0x44) == 0x00))
                                {
                                    Debug = "VBRE method, use OpRegion method"
                                    \_SB.PCI0.GFX0.SBRV ()
                                }
                            }
                        }
                        ElseIf ((_T_0 == 0x02))
                        {
                            \_SB.PCI0.GFX0.GDCC (0x01)
                            If (((WDPE & 0x03) == 0x00))
                            {
                                If ((DCAP & 0x01))
                                {
                                    \_SB.PCI0.GFX0.DKET ()
                                }
                                Else
                                {
                                    \_SB.SSMI (0xEA74, 0x06, 0x00, 0x00, 0x00)
                                    CNDD (0x00)
                                    Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
                                }
                            }
                        }
                        ElseIf ((_T_0 == 0x03))
                        {
                            \_SB.PCI0.GFX0.CLID = \_SB.LID._LID ()
                            If (((\WCOS () < 0x06) || ((WDPE & 0x03) == 0x00)))
                            {
                                If ((DCAP & 0x01))
                                {
                                    If (\_SB.PCI0.GFX0.GLID (\_SB.LID._LID ()))
                                    {
                                        \_SB.PCI0.GFX0.CLID |= 0x80000000
                                    }
                                }
                                Else
                                {
                                    \_SB.SSMI (0xEA74, 0x05, 0x00, 0x00, 0x00)
                                    CNDD (0x01)
                                    Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
                                    If ((\WCOS () < 0x06))
                                    {
                                        LRSC = 0x00
                                    }
                                }
                            }
                        }
                        ElseIf ((_T_0 == 0x04))
                        {
                            If (((WDPE & 0x03) == 0x00))
                            {
                                If ((DCAP & 0x01))
                                {
                                    \_SB.PCI0.GFX0.GF4E (0x00)
                                }
                                Else
                                {
                                    CNDD (0x00)
                                    Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
                                }
                            }
                        }
                        ElseIf ((_T_0 == 0x06))
                        {
                            If ((DCAP & 0x01))
                            {
                                \_SB.PCI0.GFX0.SNXS ()
                            }
                            Else
                            {
                                \_GPE.CNDD (0x00)
                                Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
                            }
                        }
                        ElseIf ((_T_0 == 0x07))
                        {
                            \_SB.PCI0.GFX0.RFHS (Arg0)
                        }
                        ElseIf ((_T_0 == 0x08))
                        {
                            If ((Arg0 == 0x04))
                            {
                                \_SB.PCI0.GFX0.GLID (\_SB.LID._LID ())
                                \_SB.PCI0.GFX0.DKET ()
                            }

                            If ((Arg0 >= 0x03))
                            {
                                If (((WDPE & 0x44) == 0x00))
                                {
                                    Local0 = \_SB.SBRC ()
                                    \_SB.PCI0.GFX0.BCLP = (Local0 | 0x80000000)
                                }
                            }
                        }
                        ElseIf ((_T_0 == 0x09))
                        {
                            If (((WDPE & 0x04) == 0x00))
                            {
                                \_SB.PCI0.GFX0.SBRV ()
                            }
                        }

                        Return (0x00)
                    }
                }

                Event (\_SB.BEVT)
                Event (\_SB.F4EV)
                Scope (\_GPE)
                {
                    Method (VBRE, 1, Serialized)
                    {
                        Local1 = 0x01
                        If (Local1)
                        {
                            Local1 = \_GPE.VHIV (Arg0, 0x00, 0x01)
                        }

                        If ((SGMD & 0x0F))
                        {
                            If ((\_SB.PCI0.PEGP.DGFX.SVID != 0xFFFF))
                            {
                                If ((Arg0 & 0x80))
                                {
                                    Notify (\_SB.PCI0.PEGP.DGFX.DD02, Arg0)
                                }
                            }
                        }
                    }

                    Method (VFN4, 0, Serialized)
                    {
                        Signal (\_SB.F4EV)
                        Local1 = 0x01
                        If (Local1)
                        {
                            Local1 = \_GPE.VHIV (0x00, 0x00, 0x04)
                        }
                    }

                    Method (VDET, 0, Serialized)
                    {
                        Local1 = 0x01
                        If (Local1)
                        {
                            Local1 = \_GPE.VHIV (0x00, 0x00, 0x02)
                        }
                    }

                    Name (LRSC, 0x01)
                    Method (VLET, 0, Serialized)
                    {
                        LRSC = 0x01
                        Local1 = 0x01
                        If (Local1)
                        {
                            Local1 = \_GPE.VHIV (0x00, 0x00, 0x03)
                        }

                        Return (LRSC) /* \_GPE.LRSC */
                    }

                    Method (VPUP, 2, Serialized)
                    {
                        Local1 = 0x01
                        If (Local1)
                        {
                            Local1 = \_GPE.VHIV (Arg0, Arg1, 0x05)
                        }
                    }
                }

                Scope (\_SB)
                {
                    Method (VSDD, 1, Serialized)
                    {
                        If ((DCAP & 0x04))
                        {
                            Return (0xFFFF)
                        }
                        Else
                        {
                            If (((WDPE & 0x03) == 0x00))
                            {
                                WDGN = Arg0
                                Local1 = 0x01
                                If (Local1)
                                {
                                    Local1 = \_GPE.VHIV (Arg0, 0x00, 0x06)
                                }
                            }

                            Return (0x00)
                        }

                        Return (Zero)
                    }

                    Method (VGDD, 1, Serialized)
                    {
                        If (((DCAP & 0x04) && Arg0))
                        {
                            Return (0xFFFF)
                        }
                        Else
                        {
                            If ((DCAP & 0x01))
                            {
                                If ((Arg0 == 0x00))
                                {
                                    Wait (\_SB.F4EV, 0x0500)
                                }

                                Local1 = 0x01
                                If (Local1)
                                {
                                    Local1 = \_GPE.VHIV (Arg0, 0x00, 0x07)
                                }
                            }
                            ElseIf (Arg0)
                            {
                                \_SB.SSMI (0xEA74, 0x02, 0x00, 0x00, 0x00)
                            }

                            Return (WDST) /* \WDST */
                        }
                    }

                    Method (VWAK, 1, Serialized)
                    {
                        Local1 = 0x01
                        If (Local1)
                        {
                            Local1 = \_GPE.VHIV (Arg0, 0x00, 0x08)
                        }
                    }

                    Method (WBRT, 0, NotSerialized)
                    {
                        Local1 = 0x01
                        If (Local1)
                        {
                            Local1 = \_GPE.VHIV (0x00, 0x00, 0x09)
                        }
                    }
                }

                Name (DCSC, 0xFF)
                Method (GDCC, 1, Serialized)
                {
                    If ((Arg0 && (DCSC == 0xFF)))
                    {
                        Local0 = (0x01 | (0x02 | 0x04))
                        If (\_SB.DCKD ())
                        {
                            Local0 |= 0x08
                        }

                        DCSC = Local0
                    }

                    Return (DCSC) /* \_SB_.PCI0.GFX0.DCSC */
                }

                Method (PDOS, 2, NotSerialized)
                {
                }
            }

            Device (PEGP.DGFX)
            {
                Name (_ADR, 0x00)  // _ADR: Address
            }

            Scope (\)
            {
                OperationRegion (IO_T, SystemIO, 0x1000, 0x10)
                Field (IO_T, ByteAcc, NoLock, Preserve)
                {
                    TRPI,   16, 
                    Offset (0x04), 
                    Offset (0x06), 
                    Offset (0x08), 
                    TRP0,   8, 
                    Offset (0x0A), 
                    Offset (0x0B), 
                    Offset (0x0C), 
                    Offset (0x0D), 
                    Offset (0x0E), 
                    Offset (0x0F), 
                    Offset (0x10)
                }

                OperationRegion (IO_D, SystemIO, 0x0810, 0x04)
                Field (IO_D, ByteAcc, NoLock, Preserve)
                {
                    TRPD,   8
                }

                OperationRegion (PMIO, SystemIO, 0x0400, 0x80)
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x20), 
                        ,   2, 
                    SPST,   1, 
                        ,   16, 
                    GPS3,   1, 
                    Offset (0x42), 
                        ,   1, 
                    GPEC,   1, 
                    Offset (0x64), 
                        ,   9, 
                    SCIS,   1, 
                    Offset (0x66)
                }

                OperationRegion (GPIO, SystemIO, 0x0500, 0x64)
                Field (GPIO, ByteAcc, NoLock, Preserve)
                {
                    GU00,   8, 
                    GU01,   8, 
                    GU02,   8, 
                    GU03,   8, 
                    GIO0,   8, 
                    GIO1,   8, 
                    GIO2,   8, 
                    GIO3,   8, 
                    Offset (0x0C), 
                    GL00,   8, 
                    GL01,   8, 
                    GL02,   8, 
                        ,   3, 
                    GP27,   1, 
                    GP28,   1, 
                    Offset (0x10), 
                    Offset (0x18), 
                    GB00,   8, 
                    GB01,   8, 
                    GB02,   8, 
                    GB03,   8, 
                    Offset (0x2C), 
                    GIV0,   8, 
                    GIV1,   8, 
                    GIV2,   8, 
                    GIV3,   8, 
                    GU04,   8, 
                    GU05,   8, 
                    GU06,   8, 
                    GU07,   8, 
                    GIO4,   8, 
                    GIO5,   8, 
                    GIO6,   8, 
                    GIO7,   8, 
                        ,   5, 
                        ,   1, 
                    Offset (0x39), 
                    GL05,   8, 
                    GL06,   8, 
                    GL07,   8, 
                    Offset (0x40), 
                    GU08,   8, 
                    GU09,   8, 
                    GU0A,   8, 
                    GU0B,   8, 
                        ,   5, 
                    GI69,   1, 
                    Offset (0x45), 
                    GIO9,   8, 
                    GIOA,   8, 
                    GIOB,   8, 
                        ,   5, 
                    GL69,   1, 
                    Offset (0x49), 
                    GL09,   8, 
                    GL0A,   8, 
                    GL0B,   8
                }

                OperationRegion (RCRB, SystemMemory, 0xFED1C000, 0x4000)
                Field (RCRB, DWordAcc, Lock, Preserve)
                {
                    Offset (0x1A8), 
                    APMC,   2, 
                    Offset (0x1000), 
                    Offset (0x3000), 
                    Offset (0x3404), 
                    HPAS,   2, 
                        ,   5, 
                    HPAE,   1, 
                    Offset (0x3418), 
                        ,   1, 
                        ,   1, 
                    SATD,   1, 
                    SMBD,   1, 
                    HDAD,   1, 
                    Offset (0x341A), 
                    RP1D,   1, 
                    RP2D,   1, 
                    RP3D,   1, 
                    RP4D,   1, 
                    RP5D,   1, 
                    RP6D,   1, 
                    RP7D,   1, 
                    RP8D,   1
                }

                Method (GETP, 1, Serialized)
                {
                    If (((Arg0 & 0x09) == 0x00))
                    {
                        Return (0xFFFFFFFF)
                    }

                    If (((Arg0 & 0x09) == 0x08))
                    {
                        Return (0x0384)
                    }

                    Local0 = ((Arg0 & 0x0300) >> 0x08)
                    Local1 = ((Arg0 & 0x3000) >> 0x0C)
                    Return ((0x1E * (0x09 - (Local0 + Local1))))
                }

                Method (GDMA, 5, Serialized)
                {
                    If (Arg0)
                    {
                        If ((Arg1 && Arg4))
                        {
                            Return (0x14)
                        }

                        If ((Arg2 && Arg4))
                        {
                            Return (((0x04 - Arg3) * 0x0F))
                        }

                        Return (((0x04 - Arg3) * 0x1E))
                    }

                    Return (0xFFFFFFFF)
                }

                Method (GETT, 1, Serialized)
                {
                    Return ((0x1E * (0x09 - (((Arg0 >> 0x02) & 0x03
                        ) + (Arg0 & 0x03)))))
                }

                Method (GETF, 3, Serialized)
                {
                    Name (TMPF, 0x00)
                    If (Arg0)
                    {
                        TMPF |= 0x01
                    }

                    If ((Arg2 & 0x02))
                    {
                        TMPF |= 0x02
                    }

                    If (Arg1)
                    {
                        TMPF |= 0x04
                    }

                    If ((Arg2 & 0x20))
                    {
                        TMPF |= 0x08
                    }

                    If ((Arg2 & 0x4000))
                    {
                        TMPF |= 0x10
                    }

                    Return (TMPF) /* \GETF.TMPF */
                }

                Method (SETP, 3, Serialized)
                {
                    If ((Arg0 > 0xF0))
                    {
                        Return (0x08)
                    }
                    Else
                    {
                        If ((Arg1 & 0x02))
                        {
                            If (((Arg0 <= 0x78) && (Arg2 & 0x02)))
                            {
                                Return (0x2301)
                            }

                            If (((Arg0 <= 0xB4) && (Arg2 & 0x01)))
                            {
                                Return (0x2101)
                            }
                        }

                        Return (0x1001)
                    }
                }

                Method (SDMA, 1, Serialized)
                {
                    If ((Arg0 <= 0x14))
                    {
                        Return (0x01)
                    }

                    If ((Arg0 <= 0x1E))
                    {
                        Return (0x02)
                    }

                    If ((Arg0 <= 0x2D))
                    {
                        Return (0x01)
                    }

                    If ((Arg0 <= 0x3C))
                    {
                        Return (0x02)
                    }

                    If ((Arg0 <= 0x5A))
                    {
                        Return (0x01)
                    }

                    Return (0x00)
                }

                Method (SETT, 3, Serialized)
                {
                    If ((Arg1 & 0x02))
                    {
                        If (((Arg0 <= 0x78) && (Arg2 & 0x02)))
                        {
                            Return (0x0B)
                        }

                        If (((Arg0 <= 0xB4) && (Arg2 & 0x01)))
                        {
                            Return (0x09)
                        }
                    }

                    Return (0x04)
                }
            }

            Device (LANC)
            {
                Name (_ADR, 0x00190000)  // _ADR: Address
                Method (_PRW, 0, Serialized)  // _PRW: Power Resources for Wake
                {
                    Local0 = Package (0x02)
                        {
                            0x0D, 
                            0x05
                        }
                    If (WOLD)
                    {
                        Local0 [0x01] = 0x00
                    }

                    Return (Local0)
                }
            }

            Device (HDEF)
            {
                Name (_ADR, 0x001B0000)  // _ADR: Address
                OperationRegion (HDAR, PCI_Config, 0x4C, 0x10)
                Field (HDAR, WordAcc, NoLock, Preserve)
                {
                    DCKA,   1, 
                    Offset (0x01), 
                    DCKM,   1, 
                        ,   6, 
                    DCKS,   1, 
                    Offset (0x08), 
                        ,   15, 
                    PMES,   1
                }
            }

            Device (EHC1)
            {
                Name (_ADR, 0x001D0000)  // _ADR: Address
                OperationRegion (EHCX, PCI_Config, 0x54, 0x10)
                Field (EHCX, AnyAcc, NoLock, Preserve)
                {
                        ,   15, 
                    PMES,   1, 
                    Offset (0x0E), 
                    PIMP,   1, 
                    PMSK,   8
                }

                Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                {
                    If (((Arg0 == 0x02) && (Arg1 == 0x01)))
                    {
                        PMSK = 0x01
                        PIMP = 0x01
                    }
                }

                Device (RHUB)
                {
                    Name (_ADR, 0x00)  // _ADR: Address
                    Device (PRT0)
                    {
                        Name (_ADR, 0x01)  // _ADR: Address
                    }

                    Device (PRT1)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (UPRW (0x0D, 0x03))
                }

                Name (_S3D, 0x02)  // _S3D: S3 Device State
                Name (_S4D, 0x03)  // _S4D: S4 Device State
                Scope (RHUB.PRT0)
                {
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Return (EUPC) /* \EUPC */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Device (HPT0)
                    {
                        Name (_ADR, 0x01)  // _ADR: Address
                    }

                    Device (HPT1)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                    }

                    Device (HPT2)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                    }

                    Device (HPT3)
                    {
                        Name (_ADR, 0x04)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Return (EUPC) /* \EUPC */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Return (EPLD) /* \EPLD */
                        }
                    }

                    Device (HPT4)
                    {
                        Name (_ADR, 0x05)  // _ADR: Address
                        Method (_EJD, 0, NotSerialized)  // _EJD: Ejection Dependent Device
                        {
                            Return ("\\_SB.PCI0.RP02.ECF0")
                        }
                    }

                    Device (HPT5)
                    {
                        Name (_ADR, 0x06)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Return (EUPC) /* \EUPC */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Return (EPLD) /* \EPLD */
                        }
                    }

                    Device (HPT6)
                    {
                        Name (_ADR, 0x07)  // _ADR: Address
                    }

                    Device (HPT7)
                    {
                        Name (_ADR, 0x08)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Return (EUPC) /* \EUPC */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Return (EPLD) /* \EPLD */
                        }
                    }
                }
            }

            Device (EHC2)
            {
                Name (_ADR, 0x001A0000)  // _ADR: Address
                OperationRegion (EHCX, PCI_Config, 0x54, 0x10)
                Field (EHCX, AnyAcc, NoLock, Preserve)
                {
                        ,   15, 
                    PMES,   1, 
                    Offset (0x0E), 
                    PIMP,   1, 
                    PMSK,   8
                }

                Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                {
                    If (((Arg0 == 0x02) && (Arg1 == 0x01)))
                    {
                        PMSK = 0x01
                        PIMP = 0x01
                    }
                }

                Device (RHUB)
                {
                    Name (_ADR, 0x00)  // _ADR: Address
                    Device (PRT0)
                    {
                        Name (_ADR, 0x01)  // _ADR: Address
                    }

                    Device (PRT1)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (UPRW (0x0D, 0x03))
                }

                Name (_S3D, 0x02)  // _S3D: S3 Device State
                Name (_S4D, 0x03)  // _S4D: S4 Device State
                Scope (RHUB.PRT0)
                {
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Return (EUPC) /* \EUPC */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Device (HPT0)
                    {
                        Name (_ADR, 0x01)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Return (EUPC) /* \EUPC */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Return (EPLD) /* \EPLD */
                        }
                    }

                    Device (HPT1)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Return (EUPC) /* \EUPC */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Return (EPLD) /* \EPLD */
                        }
                    }

                    Device (HPT2)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                    }

                    Device (HPT3)
                    {
                        Name (_ADR, 0x04)  // _ADR: Address
                    }

                    Device (HPT4)
                    {
                        Name (_ADR, 0x05)  // _ADR: Address
                    }

                    Device (HPT5)
                    {
                        Name (_ADR, 0x06)  // _ADR: Address
                    }
                }
            }

            Device (PCIB)
            {
                Name (_ADR, 0x001E0000)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x0B, 
                    0x05
                })
            }

            Device (LPCB)
            {
                Name (_ADR, 0x001F0000)  // _ADR: Address
                Scope (\_SB)
                {
                    OperationRegion (\_SB.PCI0.LPCB.LPC1, PCI_Config, 0x40, 0xC0)
                    Field (\_SB.PCI0.LPCB.LPC1, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x20), 
                        PARC,   8, 
                        PBRC,   8, 
                        PCRC,   8, 
                        PDRC,   8, 
                        Offset (0x28), 
                        PERC,   8, 
                        PFRC,   8, 
                        PGRC,   8, 
                        PHRC,   8
                    }

                    Device (LNKA)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x01)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PARC |= 0x80
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,10,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLA, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, _Y15)
                                    {}
                            })
                            CreateWordField (RTLA, \_SB.LNKA._CRS._Y15._INT, IRQ0)  // _INT: Interrupts
                            IRQ0 = Zero
                            IRQ0 = (0x01 << (PARC & 0x0F))
                            Return (RTLA) /* \_SB_.LNKA._CRS.RTLA */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x01, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PARC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PARC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKB)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x02)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PBRC |= 0x80
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,11,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLB, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, _Y16)
                                    {}
                            })
                            CreateWordField (RTLB, \_SB.LNKB._CRS._Y16._INT, IRQ0)  // _INT: Interrupts
                            IRQ0 = Zero
                            IRQ0 = (0x01 << (PBRC & 0x0F))
                            Return (RTLB) /* \_SB_.LNKB._CRS.RTLB */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x01, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PBRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PBRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKC)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x03)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PCRC |= 0x80
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,10,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLC, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, _Y17)
                                    {}
                            })
                            CreateWordField (RTLC, \_SB.LNKC._CRS._Y17._INT, IRQ0)  // _INT: Interrupts
                            IRQ0 = Zero
                            IRQ0 = (0x01 << (PCRC & 0x0F))
                            Return (RTLC) /* \_SB_.LNKC._CRS.RTLC */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x01, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PCRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PCRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKD)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x04)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PDRC |= 0x80
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,11,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLD, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, _Y18)
                                    {}
                            })
                            CreateWordField (RTLD, \_SB.LNKD._CRS._Y18._INT, IRQ0)  // _INT: Interrupts
                            IRQ0 = Zero
                            IRQ0 = (0x01 << (PDRC & 0x0F))
                            Return (RTLD) /* \_SB_.LNKD._CRS.RTLD */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x01, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PDRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PDRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKE)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x05)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PERC |= 0x80
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,10,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLE, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, _Y19)
                                    {}
                            })
                            CreateWordField (RTLE, \_SB.LNKE._CRS._Y19._INT, IRQ0)  // _INT: Interrupts
                            IRQ0 = Zero
                            IRQ0 = (0x01 << (PERC & 0x0F))
                            Return (RTLE) /* \_SB_.LNKE._CRS.RTLE */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x01, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PERC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PERC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKF)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x06)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PFRC |= 0x80
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,11,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLF, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, _Y1A)
                                    {}
                            })
                            CreateWordField (RTLF, \_SB.LNKF._CRS._Y1A._INT, IRQ0)  // _INT: Interrupts
                            IRQ0 = Zero
                            IRQ0 = (0x01 << (PFRC & 0x0F))
                            Return (RTLF) /* \_SB_.LNKF._CRS.RTLF */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x01, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PFRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PFRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKG)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x07)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PGRC |= 0x80
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,10,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLG, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, _Y1B)
                                    {}
                            })
                            CreateWordField (RTLG, \_SB.LNKG._CRS._Y1B._INT, IRQ0)  // _INT: Interrupts
                            IRQ0 = Zero
                            IRQ0 = (0x01 << (PGRC & 0x0F))
                            Return (RTLG) /* \_SB_.LNKG._CRS.RTLG */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x01, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PGRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PGRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKH)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x08)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PHRC |= 0x80
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,11,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLH, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, _Y1C)
                                    {}
                            })
                            CreateWordField (RTLH, \_SB.LNKH._CRS._Y1C._INT, IRQ0)  // _INT: Interrupts
                            IRQ0 = Zero
                            IRQ0 = (0x01 << (PHRC & 0x0F))
                            Return (RTLH) /* \_SB_.LNKH._CRS.RTLH */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x01, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PHRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PHRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }
                }

                OperationRegion (LPC0, PCI_Config, 0x40, 0xC0)
                Field (LPC0, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x40), 
                    IOD0,   8, 
                    IOD1,   8, 
                    Offset (0xB0), 
                    RAEN,   1, 
                        ,   13, 
                    RCBA,   18
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09") /* Embedded Controller Device */)  // _HID: Hardware ID
                    Name (_UID, 0x01)  // _UID: Unique ID
                    Name (_GPE, 0x16)  // _GPE: General Purpose Events
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0062,             // Range Minimum
                            0x0062,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0066,             // Range Minimum
                            0x0066,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                    Mutex (ECMX, 0x00)
                    Name (ECRG, 0x00)
                    Name (HSWK, 0x00)
                    Method (ECRI, 0, Serialized)
                    {
                        OST = \WCOS ()
                        PWUP (0x07, 0xFF)
                        Local0 = GBAP ()
                        ITLB ()
                        SBTN (Local0, 0x81)
                        UHSW ()
                        PRIT ()
                    }

                    Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                    {
                        If ((Arg0 == 0x03))
                        {
                            ECRG = Arg1
                            Local1 = ((\WCOS () == 0x01) || (\WCOS () == 0x02))
                            If ((Arg1 && !Local1))
                            {
                                ECRI ()
                            }
                        }
                    }

                    OperationRegion (ECRM, EmbeddedControl, 0x00, 0xFF)
                    Field (ECRM, ByteAcc, NoLock, Preserve)
                    {
                        PMCD,   32, 
                        S0FL,   8, 
                        SXF0,   8, 
                        SXF1,   8,
                        CPWR,   16, 
                        CVLT,   16, 
                        CCUR,   16, 
                        DIDX,   8, 
                        CIDX,   8, 
                        PMCC,   8, 
                        PMEP,   8, 
                        Offset (0x22), 
                        CRZN,   8, 
                        THTA,   8, 
                        HYST,   8, 
                        CRIT,   8, 
                        TEMP,   8, 
                        TENA,   8, 
                        Offset (0x29), 
                        TOAD,   8, 
                        PHTP,   8, 
                        THEM,   8, 
                        TMPO,   8, 
                        Offset (0x2E), 
                        FRDC,   8, 
                        FTGC,   8, 
                        PLTP,   8, 
                        Offset (0x32), 
                        DTMP,   8, 
                        Offset (0x35), 
                        PL1,    8, 
                        PL2,    8, 
                        BCVD,   8, 
                        Offset (0x40), 
                        ABDI,   8, 
                        ABAD,   8, 
                        ABIX,   8, 
                        ABDA,   8, 
                        ABST,   8, 
                        PORI,   8, 
                        Offset (0x4C), 
                        PSSB,   8, 
                        Offset (0x80), 
                        Offset (0x81), 
                            ,   4, 
                        SLPT,   4, 
                        FNSW,   1, 
                        SFNC,   1, 
                        ACPI,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        DETF,   1, 
                        LIDS,   1, 
                        TBLT,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        COMM,   1, 
                        PME,    1, 
                        SBVD,   1, 
                        ADP,    1, 
                        ADID,   2, 
                        LCTV,   1, 
                        BATP,   4, 
                        BPU,    1, 
                        Offset (0x86), 
                        BSEL,   4, 
                        Offset (0x87), 
                        LB1,    8, 
                        LB2,    8, 
                        BDC,    16, 
                        Offset (0x8D), 
                        BFC,    16, 
                        BRTE,   16, 
                        BTC,    1, 
                        Offset (0x92), 
                        BME,    16, 
                        BDN,    8, 
                        BDV,    16, 
                        BCV1,   16, 
                        BST,    4, 
                        Offset (0x9B), 
                        BATE,   16, 
                        BPR,    16, 
                        BCR,    16, 
                        BRC,    16, 
                        BCC,    16, 
                        BPV,    16, 
                        BCV2,   16, 
                        BCV3,   16, 
                        BCV4,   16, 
                        BCW,    16, 
                        BATF,   16, 
                        BCL,    16, 
                        MAXC,   16, 
                        BCG1,   8, 
                        BT1I,   1, 
                        BT2I,   1, 
                            ,   2, 
                        BATN,   4, 
                        BSTS,   16, 
                        BCG2,   8, 
                        Offset (0xBD), 
                        BMO,    8, 
                        Offset (0xBF), 
                        BRCV,   8, 
                        Offset (0xC1), 
                        BIF,    8, 
                        BRCC,   8, 
                        Offset (0xC9), 
                        BSN,    16, 
                        BDAT,   16, 
                        BMF,    8, 
                        Offset (0xCF), 
                        CTLB,   8, 
                        Offset (0xD1), 
                        BTY,    8, 
                        Offset (0xD5), 
                        MFAC,   8, 
                        CFAN,   8, 
                        PFAN,   8, 
                        OCPS,   8, 
                        OCPR,   8, 
                        OCPE,   8, 
                        TMP1,   8, 
                        TMP2,   8, 
                        NABT,   4, 
                        BCM,    4, 
                        CCBQ,   16, 
                        CBT,    16, 
                        Offset (0xE3), 
                        OST,    4, 
                        Offset (0xE4), 
                        Offset (0xE5), 
                        TPTE,   1, 
                        TBBN,   1, 
                            ,   3, 
                        TP,     1, 
                        Offset (0xE6), 
                        SHK,    8, 
                        AUDS,   1, 
                        SPKR,   1, 
                        Offset (0xE8), 
                        HSEN,   4, 
                        HSST,   4, 
                        Offset (0xEA), 
                            ,   2, 
                        WWP,    1, 
                        WLP,    1, 
                        Offset (0xEF), 
                        INCH,   2, 
                        IDIS,   2, 
                        INAC,   1
                    }

                    Method (_INI, 0, NotSerialized)  // _INI: Initialize
                    {
                        If (((\WCOS () == 0x01) || (\WCOS () == 0x02)))
                        {
                            ECRI ()
                        }
                    }

                    OperationRegion (MAIO, SystemIO, 0x0200, 0x02)
                    Field (MAIO, ByteAcc, NoLock, Preserve)
                    {
                        MAIN,   8, 
                        MADT,   8
                    }

                    IndexField (MAIN, MADT, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x8C), 
                            ,   7, 
                        CLID,   1, 
                        Offset (0x95), 
                        PWM0,   8, 
                        Offset (0x9D), 
                        PWMC,   8
                    }

                    Method (KFCL, 2, NotSerialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            MFAC = Arg1
                            If (((Arg0 >= 0x00) && (Arg0 <= 0x64)))
                            {
                                CFAN = Arg0
                            }
                        }

                        Release (ECMX)
                    }

                    Method (KSFS, 1, NotSerialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            CFAN = Arg0
                        }

                        Release (ECMX)
                    }

                    Method (KGFS, 0, NotSerialized)
                    {
                        Local0 = 0x14
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Local0 = CFAN /* \_SB_.PCI0.LPCB.EC0_.CFAN */
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (KRFS, 0, NotSerialized)
                    {
                        Local0 = 0x1E
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Local0 = PFAN /* \_SB_.PCI0.LPCB.EC0_.PFAN */
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (SFSD, 1, Serialized)
                    {
                        Local1 = (Arg0 * 0x40)
                        Divide (Local1, 0x64, Local2, Local0)
                        Local0 = (0x40 - Local0)
                        Local1 = (PWM0 & 0x80)
                        If ((Local0 == 0x40))
                        {
                            Local1 |= 0x01
                        }
                        Else
                        {
                            Local0 <<= 0x01
                            Local1 |= Local0
                        }

                        PWM0 = Local1
                    }

                    Method (GFSD, 0, Serialized)
                    {
                        Local0 = (PWM0 & 0x7F)
                        If ((Local0 & 0x01))
                        {
                            Local1 = 0x00
                        }
                        Else
                        {
                            Local0 >>= 0x01
                            Local0 = (0x40 - Local0)
                            Local0 *= 0x64
                            Divide ((Local0 + 0x20), 0x40, Local2, Local1)
                            Local1++
                        }

                        Return (Local1)
                    }

                    Method (GSHK, 0, Serialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Local0 = SHK /* \_SB_.PCI0.LPCB.EC0_.SHK_ */
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (SSHK, 1, Serialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Debug = Arg0
                            SHK = Arg0
                        }

                        Release (ECMX)
                    }

                    Method (SAST, 1, Serialized)
                    {
                        Local0 = 0x00
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            AUDS = Arg0
                            Local0 = 0x01
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (HSPW, 2, Serialized)
                    {
                        If (HSED)
                        {
                            Local0 = HSWK /* \_SB_.PCI0.LPCB.EC0_.HSWK */
                            If (Arg0)
                            {
                                HSWK = (Local0 | Arg1)
                            }
                            Else
                            {
                                HSWK = (Local0 & ~Arg1)
                            }
                        }
                        Else
                        {
                            HSWK = 0x00
                        }
                    }

                    Method (UHSW, 0, Serialized)
                    {
                    }

                    Method (CHSW, 1, Serialized)
                    {
                        Local1 = 0x00
                        Return (Local1)
                    }

                    Method (HWLP, 1, NotSerialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            WLP = (Arg0 ^ 0x00)
                        }

                        Release (ECMX)
                    }

                    Method (HWWP, 1, NotSerialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            If (((WWIX & 0x80) && (Arg0 == 0x00)))
                            {
                                Sleep (0x1388)
                            }

                            WWP = (Arg0 ^ 0x01)
                        }

                        Release (ECMX)
                    }

                    Method (ECAB, 4, Serialized)
                    {
                        Local0 = 0xECAB
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Local0 = 0xFF00
                            ABDI = Arg0
                            ABAD = Arg1
                            ABIX = Arg2
                            If (((Arg1 & 0x01) == 0x00))
                            {
                                ABDA = Arg3
                            }

                            ABST = 0xFF
                            Sleep (0x5A)
                            Local0 = 0x80
                            Local1 = 0x0B
                            While (((Local0 & 0x80) && (Local1 > 0x00)))
                            {
                                Sleep (0x0A)
                                Local0 = ABST /* \_SB_.PCI0.LPCB.EC0_.ABST */
                                Local1--
                            }

                            Local0 <<= 0x08
                            If (((Local0 == 0x00) && (Arg1 & 0x01)))
                            {
                                Local1 = (ABDA & 0xFF)
                                Local0 |= Local1
                            }
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Name (NGBF, 0xFF)
                    Name (NGBT, 0xFF)
                    Name (GACP, 0x07)
                    Name (ACST, 0x01)
                    Name (SMAR, 0x00)
                    Name (NBAP, 0x00)
                    Name (NNBO, 0x01)
                    Name (NDCB, 0x00)
                    Name (NLB1, 0xC8)
                    Name (NLB2, 0x64)
                    Mutex (BTMX, 0x00)
                    Name (NBTT, Package (0x08)
                    {
                        "Unknown", 
                        "NiMH", 
                        "LiIon"
                    })
                    Method (UPAD, 0, Serialized)
                    {
                        Acquire (BTMX, 0xFFFF)
                        If ((GACP & 0x01))
                        {
                            GACP &= 0x06
                            Release (BTMX)
                            Local0 = 0x01
                            Local1 = 0x00
                            Acquire (ECMX, 0xFFFF)
                            If (ECRG)
                            {
                                Local0 = ADP /* \_SB_.PCI0.LPCB.EC0_.ADP_ */
                                Local1 = ADID /* \_SB_.PCI0.LPCB.EC0_.ADID */
                            }

                            Release (ECMX)
                            ACST = Local0
                            If ((DTCD & 0x0800))
                            {
                                If ((DTCD & 0x1000))
                                {
                                    ACST = 0x00
                                }
                                Else
                                {
                                    ACST = 0x01
                                }
                            }

                            SMAR = Local1
                        }
                        Else
                        {
                            Release (BTMX)
                        }
                    }

                    Method (GACS, 0, Serialized)
                    {
                        UPAD ()
                        Return (ACST) /* \_SB_.PCI0.LPCB.EC0_.ACST */
                    }

                    Method (GPID, 0, Serialized)
                    {
                        UPAD ()
                        Return (SMAR) /* \_SB_.PCI0.LPCB.EC0_.SMAR */
                    }

                    Method (GBAP, 0, Serialized)
                    {
                        Acquire (BTMX, 0xFFFF)
                        If ((GACP & 0x02))
                        {
                            GACP &= 0x05
                            Release (BTMX)
                            Acquire (ECMX, 0xFFFF)
                            If (ECRG)
                            {
                                NBAP = BATP /* \_SB_.PCI0.LPCB.EC0_.BATP */
                            }

                            Release (ECMX)
                        }
                        Else
                        {
                            Release (BTMX)
                        }

                        Return (NBAP) /* \_SB_.PCI0.LPCB.EC0_.NBAP */
                    }

                    Method (PWUP, 2, Serialized)
                    {
                        Local0 = 0x00
                        Acquire (BTMX, 0xFFFF)
                        Local1 = (Arg0 | GACP) /* \_SB_.PCI0.LPCB.EC0_.GACP */
                        GACP = (Local1 & 0x07)
                        If ((GACP & 0x02))
                        {
                            NGBF |= Arg1
                        }

                        If ((GACP & 0x04))
                        {
                            If ((NGBT != 0xFF))
                            {
                                Local0 = 0x01
                            }

                            NGBT |= Arg1
                        }

                        Release (BTMX)
                        Return (Local0)
                    }

                    Method (BTDR, 1, Serialized)
                    {
                        If ((Arg0 == 0x01))
                        {
                            NNBO = 0x01
                        }
                        ElseIf ((Arg0 == 0x00))
                        {
                            NNBO = 0x00
                        }

                        Return (NNBO) /* \_SB_.PCI0.LPCB.EC0_.NNBO */
                    }

                    Method (BSTA, 1, Serialized)
                    {
                        BTDR (0x01)
                        Local0 = GBAP ()
                        Local1 = 0x0F
                        If ((Local0 & Arg0))
                        {
                            Local1 = 0x1F
                        }

                        Return (Local1)
                    }

                    Method (GBSS, 2, Serialized)
                    {
                        ToBCD (Arg0, Local0)
                        Local3 = \ISTR (Local0, 0x05)
                        Concatenate (Local3, " ", Local4)
                        Local0 = (Arg1 >> 0x09)
                        Local1 = (Local0 + 0x07BC)
                        ToBCD (Local1, Local0)
                        Local2 = \ISTR (Local0, 0x04)
                        Concatenate (Local4, Local2, Local3)
                        Concatenate (Local3, "/", Local4)
                        Local0 = (Arg1 >> 0x05)
                        Local1 = (Local0 & 0x0F)
                        ToBCD (Local1, Local0)
                        Local2 = \ISTR (Local0, 0x02)
                        Concatenate (Local4, Local2, Local3)
                        Concatenate (Local3, "/", Local4)
                        Local1 = (Arg1 & 0x1F)
                        ToBCD (Local1, Local0)
                        Local2 = \ISTR (Local0, 0x02)
                        Concatenate (Local4, Local2, Local3)
                        Return (Local3)
                    }

                    Method (GBMF, 0, Serialized)
                    {
                        Local0 = Buffer (0x12){}
                        Local3 = 0x00
                        Local1 = BMF /* \_SB_.PCI0.LPCB.EC0_.BMF_ */
                        While (((Local3 < 0x10) && (Local1 != 0x00)))
                        {
                            Local0 [Local3] = Local1
                            Local3++
                            Local1 = BMF /* \_SB_.PCI0.LPCB.EC0_.BMF_ */
                        }

                        Return (Local0)
                    }

                    Method (GCTL, 1, Serialized)
                    {
                        Name (CTBF, Buffer (0x10){})
                        Local3 = 0x00
                        Local2 = 0x00
                        While ((Local3 != 0x10))
                        {
                            CTBF [Local2] = CTLB /* \_SB_.PCI0.LPCB.EC0_.CTLB */
                            Local2++
                            Local3++
                        }

                        Return (CTBF) /* \_SB_.PCI0.LPCB.EC0_.GCTL.CTBF */
                    }

                    Method (GDNM, 1, Serialized)
                    {
                        Name (DNBF, Buffer (0x07){})
                        Local3 = 0x00
                        Local2 = 0x00
                        While ((Local3 != 0x07))
                        {
                            DNBF [Local2] = BDN /* \_SB_.PCI0.LPCB.EC0_.BDN_ */
                            Local2++
                            Local3++
                        }

                        Return (DNBF) /* \_SB_.PCI0.LPCB.EC0_.GDNM.DNBF */
                    }

                    Method (GDCH, 1, Serialized)
                    {
                        Name (DCBF, Buffer (0x04){})
                        Local3 = 0x00
                        Local2 = 0x00
                        While ((Local3 != 0x04))
                        {
                            DCBF [Local2] = BTY /* \_SB_.PCI0.LPCB.EC0_.BTY_ */
                            Local2++
                            Local3++
                        }

                        Return (DCBF) /* \_SB_.PCI0.LPCB.EC0_.GDCH.DCBF */
                    }

                    Method (BTIF, 1, Serialized)
                    {
                        Local7 = (0x01 << Arg0)
                        BTDR (0x01)
                        If ((BSTA (Local7) == 0x0F))
                        {
                            Return (0xFF)
                        }

                        Acquire (BTMX, 0xFFFF)
                        Local0 = NGBF /* \_SB_.PCI0.LPCB.EC0_.NGBF */
                        Release (BTMX)
                        If (((Local0 & Local7) == 0x00))
                        {
                            Return (0x00)
                        }

                        NBST [Arg0] = NDBS /* \_SB_.NDBS */
                        Acquire (BTMX, 0xFFFF)
                        NGBT |= Local7
                        Release (BTMX)
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            BSEL = Arg0
                            Local0 = BFC /* \_SB_.PCI0.LPCB.EC0_.BFC_ */
                            DerefOf (NBTI [Arg0]) [0x01] = Local0
                            DerefOf (NBTI [Arg0]) [0x02] = Local0
                            DerefOf (NBTI [Arg0]) [0x04] = BDV /* \_SB_.PCI0.LPCB.EC0_.BDV_ */
                            DerefOf (NBTI [Arg0]) [0x05] = NLB1 /* \_SB_.PCI0.LPCB.EC0_.NLB1 */
                            DerefOf (NBTI [Arg0]) [0x06] = NLB2 /* \_SB_.PCI0.LPCB.EC0_.NLB2 */
                            Local0 = BSN /* \_SB_.PCI0.LPCB.EC0_.BSN_ */
                            Local1 = BDAT /* \_SB_.PCI0.LPCB.EC0_.BDAT */
                        }

                        Release (ECMX)
                        Local2 = GBSS (Local0, Local1)
                        DerefOf (NBTI [Arg0]) [0x0A] = Local2
                        Acquire (BTMX, 0xFFFF)
                        NGBF &= ~Local7
                        Release (BTMX)
                        Return (0x00)
                    }

                    Method (BTST, 2, Serialized)
                    {
                        Local7 = (0x01 << Arg0)
                        BTDR (0x01)
                        If ((BSTA (Local7) == 0x0F))
                        {
                            NBST [Arg0] = Package (0x04)
                                {
                                    0x00, 
                                    0xFFFFFFFF, 
                                    0xFFFFFFFF, 
                                    0xFFFFFFFF
                                }
                            Return (0xFF)
                        }

                        Acquire (BTMX, 0xFFFF)
                        If (Arg1)
                        {
                            NGBT = 0xFF
                        }

                        Local0 = NGBT /* \_SB_.PCI0.LPCB.EC0_.NGBT */
                        Release (BTMX)
                        If (((Local0 & Local7) == 0x00))
                        {
                            Return (0x00)
                        }

                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            BSEL = Arg0
                            Local0 = BST /* \_SB_.PCI0.LPCB.EC0_.BST_ */
                            Local3 = BPR /* \_SB_.PCI0.LPCB.EC0_.BPR_ */
                            DerefOf (NBST [Arg0]) [0x02] = BRC /* \_SB_.PCI0.LPCB.EC0_.BRC_ */
                            DerefOf (NBST [Arg0]) [0x03] = BPV /* \_SB_.PCI0.LPCB.EC0_.BPV_ */
                        }

                        Release (ECMX)
                        If ((GACS () == 0x01))
                        {
                            Local0 &= ~0x01
                        }
                        Else
                        {
                            Local0 &= ~0x02
                        }

                        If ((Local0 & 0x01))
                        {
                            Acquire (BTMX, 0xFFFF)
                            NDCB = Local7
                            Release (BTMX)
                        }

                        DerefOf (NBST [Arg0]) [0x00] = Local0
                        If ((Local0 & 0x01))
                        {
                            If (((Local3 < 0x0190) || (Local3 > 0x1964)))
                            {
                                Local5 = DerefOf (DerefOf (NBST [Arg0]) [0x01])
                                If (((Local5 < 0x0190) || (Local5 > 0x1964)))
                                {
                                    Local3 = (0x1AF4 / 0x02)
                                }
                                Else
                                {
                                    Local3 = Local5
                                }
                            }
                        }
                        ElseIf (((Local0 & 0x02) == 0x00))
                        {
                            Local3 = 0x00
                        }

                        DerefOf (NBST [Arg0]) [0x01] = Local3
                        Acquire (BTMX, 0xFFFF)
                        NGBT &= ~Local7
                        Release (BTMX)
                        Return (0x00)
                    }

                    Method (ITLB, 0, NotSerialized)
                    {
                        Divide ((NLB1 + 0x09), 0x0A, Local0, Local1)
                        Divide ((0x96 + 0x09), 0x0A, Local0, Local2)
                        If (ECRG)
                        {
                            LB1 = Local1
                            LB2 = Local2
                        }
                    }

                    Method (GBTI, 1, NotSerialized)
                    {
                        Debug = "Enter getbattinfo"
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            If ((BATP & (0x01 << Arg0)))
                            {
                                BSEL = Arg0
                                Local0 = Package (0x03)
                                    {
                                        0x00, 
                                        0x6B, 
                                        Buffer (0x6B){}
                                    }
                                DerefOf (Local0 [0x02]) [0x00] = BDC /* \_SB_.PCI0.LPCB.EC0_.BDC_ */
                                DerefOf (Local0 [0x02]) [0x01] = (BDC >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x02] = BFC /* \_SB_.PCI0.LPCB.EC0_.BFC_ */
                                DerefOf (Local0 [0x02]) [0x03] = (BFC >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x04] = BRC /* \_SB_.PCI0.LPCB.EC0_.BRC_ */
                                DerefOf (Local0 [0x02]) [0x05] = (BRC >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x06] = BME /* \_SB_.PCI0.LPCB.EC0_.BME_ */
                                DerefOf (Local0 [0x02]) [0x07] = (BME >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x08] = BCC /* \_SB_.PCI0.LPCB.EC0_.BCC_ */
                                DerefOf (Local0 [0x02]) [0x09] = (BCC >> 0x08
                                    )
                                Local1 = CBT /* \_SB_.PCI0.LPCB.EC0_.CBT_ */
                                Local1 -= 0x0AAC
                                Divide (Local1, 0x0A, Local2, Local3)
                                DerefOf (Local0 [0x02]) [0x0A] = Local3
                                DerefOf (Local0 [0x02]) [0x0B] = (Local3 >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x0C] = BPV /* \_SB_.PCI0.LPCB.EC0_.BPV_ */
                                DerefOf (Local0 [0x02]) [0x0D] = (BPV >> 0x08
                                    )
                                Local1 = BPR /* \_SB_.PCI0.LPCB.EC0_.BPR_ */
                                If (Local1)
                                {
                                    If ((BSTS & 0x40))
                                    {
                                        Local1 = (~Local1 + 0x01)
                                        Local1 &= 0xFFFF
                                    }
                                }

                                DerefOf (Local0 [0x02]) [0x0E] = Local1
                                DerefOf (Local0 [0x02]) [0x0F] = (Local1 >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x10] = BDV /* \_SB_.PCI0.LPCB.EC0_.BDV_ */
                                DerefOf (Local0 [0x02]) [0x11] = (BDV >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x12] = BSTS /* \_SB_.PCI0.LPCB.EC0_.BSTS */
                                DerefOf (Local0 [0x02]) [0x13] = (BSTS >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x14] = BCV1 /* \_SB_.PCI0.LPCB.EC0_.BCV1 */
                                DerefOf (Local0 [0x02]) [0x15] = (BCV1 >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x16] = BCV2 /* \_SB_.PCI0.LPCB.EC0_.BCV2 */
                                DerefOf (Local0 [0x02]) [0x17] = (BCV2 >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x18] = BCV3 /* \_SB_.PCI0.LPCB.EC0_.BCV3 */
                                DerefOf (Local0 [0x02]) [0x19] = (BCV3 >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x1A] = BCV4 /* \_SB_.PCI0.LPCB.EC0_.BCV4 */
                                DerefOf (Local0 [0x02]) [0x1B] = (BCV4 >> 0x08
                                    )
                                CreateField (DerefOf (Local0 [0x02]), (0x1C * 0x08), (0x10 * 
                                    0x08), BTSN)
                                BTSN = GBSS (BSN, BDAT)
                                Local1 = GBMF ()
                                Local2 = SizeOf (Local1)
                                CreateField (DerefOf (Local0 [0x02]), (0x2C * 0x08), (Local2 * 
                                    0x08), BMAN)
                                BMAN = Local1
                                Local2 += 0x2C
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x10 * 
                                    0x08), CLBL)
                                CLBL = GCTL (0x00)
                                Local2 += 0x11
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x07 * 
                                    0x08), DNAM)
                                DNAM = GDNM (0x00)
                                Local2 += 0x07
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x04 * 
                                    0x08), DCHE)
                                DCHE = GDCH (0x00)
                                Local2 += 0x04
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), BMAC)
                                BMAC = 0x00
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), BMAD)
                                BMAD = BDAT /* \_SB_.PCI0.LPCB.EC0_.BDAT */
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), BCCU)
                                BCCU = BRCC /* \_SB_.PCI0.LPCB.EC0_.BRCC */
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), BCVO)
                                BCVO = BRCV /* \_SB_.PCI0.LPCB.EC0_.BRCV */
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), BAVC)
                                Local1 = BCR /* \_SB_.PCI0.LPCB.EC0_.BCR_ */
                                If (Local1)
                                {
                                    If ((BSTS & 0x40))
                                    {
                                        Local1 = (~Local1 + 0x01)
                                        Local1 &= 0xFFFF
                                    }
                                }

                                BAVC = Local1
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), RTTE)
                                RTTE = BRTE /* \_SB_.PCI0.LPCB.EC0_.BRTE */
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), ATTE)
                                RTTE = BATE /* \_SB_.PCI0.LPCB.EC0_.BATE */
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), ATTF)
                                RTTE = BATF /* \_SB_.PCI0.LPCB.EC0_.BATF */
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x01 * 
                                    0x08), NOBS)
                                NOBS = BATN /* \_SB_.PCI0.LPCB.EC0_.BATN */
                            }
                            Else
                            {
                                Local0 = Package (0x02)
                                    {
                                        0x34, 
                                        0x00
                                    }
                            }
                        }
                        Else
                        {
                            Local0 = Package (0x02)
                                {
                                    0x0D, 
                                    0x00
                                }
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (GBTC, 0, NotSerialized)
                    {
                        Debug = "Enter GetBatteryControl"
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Local0 = Package (0x03)
                                {
                                    0x00, 
                                    0x04, 
                                    Buffer (0x04){}
                                }
                            If ((BATP & 0x01))
                            {
                                BSEL = 0x00
                                DerefOf (Local0 [0x02]) [0x00] = 0x00
                                If ((((INAC == 0x00) && (INCH == 0x00)) && (IDIS == 0x00)))
                                {
                                    DerefOf (Local0 [0x02]) [0x00] = 0x00
                                }
                                ElseIf (((((INAC == 0x00) && (INCH == 0x02)) && (
                                    IDIS == 0x01)) && (MAXC == 0x00)))
                                {
                                    DerefOf (Local0 [0x02]) [0x00] = 0x01
                                }
                                ElseIf (((INAC == 0x01) && (IDIS == 0x02)))
                                {
                                    DerefOf (Local0 [0x02]) [0x00] = 0x02
                                }
                                ElseIf (((((INAC == 0x00) && (INCH == 0x02)) && (
                                    IDIS == 0x01)) && (MAXC == 0xFA)))
                                {
                                    DerefOf (Local0 [0x02]) [0x00] = 0x03
                                }
                                ElseIf (((INAC == 0x00) && (INCH == 0x03)))
                                {
                                    DerefOf (Local0 [0x02]) [0x00] = 0x04
                                }
                            }
                            Else
                            {
                                DerefOf (Local0 [0x02]) [0x00] = 0xFF
                            }

                            If ((BATP & 0x02))
                            {
                                BSEL = 0x01
                                DerefOf (Local0 [0x02]) [0x01] = 0x00
                                If ((((INAC == 0x00) && (INCH == 0x00)) && (IDIS == 0x00)))
                                {
                                    DerefOf (Local0 [0x02]) [0x01] = 0x00
                                }
                                ElseIf (((((INAC == 0x00) && (INCH == 0x01)) && (
                                    IDIS == 0x02)) && (MAXC == 0x00)))
                                {
                                    DerefOf (Local0 [0x02]) [0x01] = 0x01
                                }
                                ElseIf (((INAC == 0x01) && (IDIS == 0x01)))
                                {
                                    DerefOf (Local0 [0x02]) [0x01] = 0x02
                                }
                                ElseIf (((((INAC == 0x00) && (INCH == 0x01)) && (
                                    IDIS == 0x02)) && (MAXC == 0xFA)))
                                {
                                    DerefOf (Local0 [0x02]) [0x01] = 0x03
                                }
                                ElseIf (((INAC == 0x00) && (INCH == 0x03)))
                                {
                                    DerefOf (Local0 [0x02]) [0x01] = 0x04
                                }
                            }
                            Else
                            {
                                DerefOf (Local0 [0x02]) [0x01] = 0xFF
                            }
                        }
                        Else
                        {
                            Local0 = Package (0x02)
                                {
                                    0x35, 
                                    0x00
                                }
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (SBTC, 3, NotSerialized)
                    {
                        Debug = "Enter SetBatteryControl"
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Local0 = Arg2
                            Debug = Local0
                            Local4 = Package (0x02)
                                {
                                    0x06, 
                                    0x00
                                }
                            Local1 = 0x00
                            Local2 = 0x00
                            Local1 = DerefOf (Local0 [0x10])
                            If ((Local1 == 0x00))
                            {
                                Debug = "battery 0"
                                If ((BATP & 0x01))
                                {
                                    Local2 = DerefOf (Local0 [0x11])
                                    If ((Local2 == 0x00))
                                    {
                                        INCH = 0x00
                                        IDIS = 0x00
                                        INAC = 0x00
                                        MAXC = 0x00
                                        PSSB = 0x01
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x01))
                                    {
                                        INAC = 0x00
                                        INCH = 0x02
                                        IDIS = 0x01
                                        MAXC = 0x00
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x02))
                                    {
                                        INAC = 0x01
                                        INCH = 0x01
                                        IDIS = 0x02
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x03))
                                    {
                                        INCH = 0x02
                                        IDIS = 0x01
                                        INAC = 0x00
                                        MAXC = 0xFA
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x04))
                                    {
                                        MAXC = 0xFA
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x05))
                                    {
                                        INAC = 0x00
                                        INCH = 0x03
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }
                                }
                                Else
                                {
                                    Local4 = Package (0x02)
                                        {
                                            0x34, 
                                            0x00
                                        }
                                }
                            }

                            If ((Local1 == 0x01))
                            {
                                If ((BATP & 0x02))
                                {
                                    Debug = "battery 1"
                                    Local2 = DerefOf (Local0 [0x11])
                                    If ((Local2 == 0x00))
                                    {
                                        INCH = 0x00
                                        IDIS = 0x00
                                        INAC = 0x00
                                        MAXC = 0x00
                                        PSSB = 0x01
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x01))
                                    {
                                        INAC = 0x00
                                        INCH = 0x01
                                        IDIS = 0x02
                                        MAXC = 0x00
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x02))
                                    {
                                        INAC = 0x01
                                        INCH = 0x02
                                        IDIS = 0x01
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x03))
                                    {
                                        INCH = 0x01
                                        IDIS = 0x02
                                        INAC = 0x00
                                        MAXC = 0xFA
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x04))
                                    {
                                        INCH = 0x00
                                        IDIS = 0x00
                                        INAC = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x05))
                                    {
                                        INAC = 0x00
                                        INCH = 0x03
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }
                                }
                                Else
                                {
                                    Local4 = Package (0x02)
                                        {
                                            0x34, 
                                            0x00
                                        }
                                }
                            }
                        }

                        Release (ECMX)
                        Return (Local4)
                    }

                    Mutex (OTMT, 0x00)
                    Name (OTLL, 0x00)
                    Name (OTSI, 0x01)
                    Name (OTRT, 0x00)
                    Name (OTEN, 0x00)
                    Name (LRPC, 0x00)
                    Name (MXCP, 0x00)
                    Method (_Q03, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Acquire (BTMX, 0xFFFF)
                        Local0 = NDCB /* \_SB_.PCI0.LPCB.EC0_.NDCB */
                        Release (BTMX)
                        PWUP (0x04, Local0)
                        SBTN (Local0, 0x80)
                    }

                    Method (_Q04, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Acquire (OTMT, 0xFFFF)
                        OTLL = GTST ()
                        OTSI = 0x01
                        Release (OTMT)
                        RPPC (0x00)
                        PPNT ()
                    }

                    Method (_Q05, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Local0 = THEM /* \_SB_.PCI0.LPCB.EC0_.THEM */
                        \_TZ.ECTE (Local0)
                    }

                    Method (_Q06, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        PWUP (0x05, (0x02 | 0x01))
                        If (BTDR (0x02))
                        {
                            Notify (\_SB.AC, 0x80) // Status Change
                            PNOT ()
                        }

                        \_GPE.VBRE (0x00)
                        If (\_SB.PCI0.RP03.PDSX)
                        {
                            If ((\_SB.PCI0.LPCB.EC0.ADP == One))
                            {
                                \_SB.PCI0.RP03.SMHC.D3EF = 0x00
                            }
                            Else
                            {
                                \_SB.PCI0.RP03.SMHC.D3EF = 0x01
                            }
                        }
                        ElseIf ((\_SB.PCI0.LPCB.EC0.ADP == One))
                        {
                            GI69 = 0x00
                            GL69 = 0x00
                            Sleep (0x05)
                            GL69 = 0x01
                            GI69 = 0x01
                        }
                    }

                    Method (_Q08, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        PWUP (0x06, 0x01)
                        Local0 = GBAP ()
                        If ((Local0 != 0x02))
                        {
                            PWUP (0x04, 0x02)
                            If (BTDR (0x02))
                            {
                                Notify (\_SB.BAT1, 0x80) // Status Change
                            }
                        }

                        If (BTDR (0x02))
                        {
                            Notify (\_SB.BAT0, 0x81) // Information Change
                        }
                    }

                    Method (_Q0A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Local4 = \_GPE.VLET ()
                        Notify (\_SB.LID, 0x80) // Status Change
                        \_SB.PCI0.ACEL.AJAL ()
                        \_SB.WMID.WGWE (0x08, (\_SB.LID._LID () + 0x01))
                    }

                    Method (_Q09, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        PWUP (0x04, 0x01)
                        If (BTDR (0x02))
                        {
                            Notify (\_SB.BAT0, 0x80) // Status Change
                        }
                    }

                    Method (_Q0B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        \_SB.WMID.WGWE (0x00020000, 0x00)
                    }

                    Method (_Q0C, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Local0 = THEM /* \_SB_.PCI0.LPCB.EC0_.THEM */
                        \_TZ.ECTE (Local0)
                    }

                    Method (_Q18, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        PWUP (0x06, 0x02)
                        Local0 = GBAP ()
                        If ((Local0 != 0x01))
                        {
                            PWUP (0x04, 0x01)
                            If (BTDR (0x02))
                            {
                                Notify (\_SB.BAT0, 0x80) // Status Change
                            }
                        }

                        If (BTDR (0x02))
                        {
                            Notify (\_SB.BAT1, 0x81) // Information Change
                        }
                    }

                    Method (_Q19, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        PWUP (0x04, 0x02)
                        If (BTDR (0x02))
                        {
                            Notify (\_SB.BAT1, 0x80) // Status Change
                        }
                    }

                    Method (SBTN, 2, Serialized)
                    {
                        If ((Arg0 & 0x01))
                        {
                            Notify (\_SB.BAT0, Arg1)
                        }

                        If ((Arg0 & 0x02))
                        {
                            Notify (\_SB.BAT1, Arg1)
                        }
                    }

                    Method (PRIT, 0, NotSerialized)
                    {
                        RPPC (0x01)
                        PWRS = GACS ()
                        PNOT ()
                        If ((\_SB.PCI0.HDEF.ASTI == 0x00))
                        {
                            SAST (\_SB.PCI0.HDEF.ASTA)
                        }

                        Local0 = \_SB.HST1.GHID ()
                        If ((GBAP () & 0x01))
                        {
                            BT0P = 0x1F
                        }

                        \_TZ.ECTI (0x00)
                    }

                    Method (GTST, 0, Serialized)
                    {
                        Local0 = 0x02
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Local0 = OCPS /* \_SB_.PCI0.LPCB.EC0_.OCPS */
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (ETSI, 3, Serialized)
                    {
                        If ((Arg2 != 0x00))
                        {
                            OTRT = 0x00
                        }

                        If (((Arg1 != OTRT) || (Arg0 != OTEN)))
                        {
                            Acquire (ECMX, 0xFFFF)
                            If (ECRG)
                            {
                                If ((Arg1 != OTRT))
                                {
                                    OCPR = Arg1
                                    OTRT = Arg1
                                }

                                OCPE = Arg0
                                OTEN = Arg0
                            }

                            Release (ECMX)
                        }
                    }

                    Method (SMCP, 1, Serialized)
                    {
                        Acquire (OTMT, 0xFFFF)
                        If ((Arg0 == 0x00))
                        {
                            MXCP = 0x01
                            If ((LRPC == 0x00))
                            {
                                LRPC = 0x01
                            }
                        }
                        Else
                        {
                            MXCP = 0x00
                            If ((LRPC == 0x01))
                            {
                                LRPC = 0x00
                            }
                        }

                        Release (OTMT)
                        RPPC (0x01)
                        PPNT ()
                    }

                    Method (RPPC, 1, Serialized)
                    {
                        Local1 = 0x00
                        If (CondRefOf (\_PR.CPU0._PSS, Local2))
                        {
                            Local0 = \_PR.CPU0._PSS /* External reference */
                            Local1 = SizeOf (Local0)
                        }

                        Local3 = 0x00
                        If ((Local1 > 0x00))
                        {
                            Local1 -= 0x01
                        }
                        Else
                        {
                            Local3 = 0x03
                        }

                        Acquire (OTMT, 0xFFFF)
                        If (OTSI)
                        {
                            Local0 = OTLL /* \_SB_.PCI0.LPCB.EC0_.OTLL */
                            OTSI = 0x00
                            If ((Local0 == 0x00))
                            {
                                If ((LRPC < Local1))
                                {
                                    LRPC += 0x01
                                }
                            }
                            ElseIf ((Local0 == 0x02))
                            {
                                If ((LRPC > MXCP))
                                {
                                    LRPC -= 0x01
                                }
                            }
                            ElseIf ((Local0 == 0x03))
                            {
                                LRPC = Local1
                            }
                        }

                        If ((LRPC < Local1))
                        {
                            Local3 |= 0x01
                        }

                        If ((LRPC > MXCP))
                        {
                            Local3 |= 0x02
                        }

                        ETSI (Local3, 0x14, Arg0)
                        Release (OTMT)
                        If (CondRefOf (\_PR.CPU0._PPC, Local5))
                        {
                            \_PR.CPU0._PPC = LRPC /* \_SB_.PCI0.LPCB.EC0_.LRPC */
                        }
                    }

                    Method (PPNT, 0, Serialized)
                    {
                        If ((TCNT > 0x01))
                        {
                            If ((PDC0 & 0x08))
                            {
                                Notify (\_PR.CPU0, 0x80) // Performance Capability Change
                            }

                            If ((PDC1 & 0x08))
                            {
                                Notify (\_PR.CPU1, 0x80) // Performance Capability Change
                            }

                            If ((PDC2 & 0x08))
                            {
                                Notify (\_PR.CPU2, 0x80) // Performance Capability Change
                            }

                            If ((PDC3 & 0x08))
                            {
                                Notify (\_PR.CPU3, 0x80) // Performance Capability Change
                            }

                            If ((PDC4 & 0x08))
                            {
                                Notify (\_PR.CPU4, 0x80) // Performance Capability Change
                            }

                            If ((PDC5 & 0x08))
                            {
                                Notify (\_PR.CPU5, 0x80) // Performance Capability Change
                            }

                            If ((PDC6 & 0x08))
                            {
                                Notify (\_PR.CPU6, 0x80) // Performance Capability Change
                            }

                            If ((PDC7 & 0x08))
                            {
                                Notify (\_PR.CPU7, 0x80) // Performance Capability Change
                            }
                        }
                        Else
                        {
                            Notify (\_PR.CPU0, 0x80) // Performance Capability Change
                        }
                    }
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x01,               // Alignment
                            0x11,               // Length
                            )
                        IO (Decode16,
                            0x0093,             // Range Minimum
                            0x0093,             // Range Maximum
                            0x01,               // Alignment
                            0x0D,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        DMA (Compatibility, NotBusMaster, Transfer8_16, )
                            {4}
                    })
                }

                Device (FWHD)
                {
                    Name (_HID, EisaId ("INT0800") /* Intel 82802 Firmware Hub Device */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        Memory32Fixed (ReadOnly,
                            0xFF000000,         // Address Base
                            0x01000000,         // Address Length
                            )
                    })
                }

                Device (HTAM)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x05)  // _UID: Unique ID
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Return (ResourceTemplate ()
                        {
                            IO (Decode16,
                                0xFE00,             // Range Minimum
                                0xFE00,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            IO (Decode16,
                                0xFE80,             // Range Minimum
                                0xFE80,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            Memory32Fixed (ReadWrite,
                                0xFED40000,         // Address Base
                                0x00005000,         // Address Length
                                )
                        })
                    }

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((TPMX == 0x00))
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }
                }

                Device (GTPM)
                {
                    Method (_HID, 0, Serialized)  // _HID: Hardware ID
                    {
                        If ((TVID == 0x15D1))
                        {
                            Return (0x0201D824)
                        }
                        Else
                        {
                            Return (0x310CD041)
                        }
                    }

                    Name (_CID, EisaId ("PNP0C31"))  // _CID: Compatible ID
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Return (ResourceTemplate ()
                        {
                            IO (Decode16,
                                0xFE00,             // Range Minimum
                                0xFE00,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            IO (Decode16,
                                0xFE80,             // Range Minimum
                                0xFE80,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            Memory32Fixed (ReadWrite,
                                0xFED40000,         // Address Base
                                0x00005000,         // Address Length
                                )
                        })
                    }

                    OperationRegion (TMMB, SystemMemory, 0xFED40000, 0x1000)
                    Field (TMMB, ByteAcc, Lock, Preserve)
                    {
                        ACCS,   8, 
                        Offset (0x18), 
                        TSTA,   8, 
                        TBCA,   8, 
                        Offset (0xF00), 
                        TVID,   16, 
                        TDID,   16
                    }

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((ACCS == 0xFF))
                        {
                            Return (0x00)
                        }
                        ElseIf ((TPMX == 0x01))
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }

                    Name (PUID, ToUUID ("3dddfaa6-361b-4eb4-a424-8d10089d1653") /* Physical Presence Interface */)
                    Name (REV1, "1.0")
                    Name (PPIB, Buffer (0x02)
                    {
                         0x00, 0x00                                       // ..
                    })
                    Name (MUID, ToUUID ("376054ed-cc13-4675-901c-4756d7f2d45d"))
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        Local0 = Arg0
                        If ((\SRCP (Local0, PUID) == 0x01))
                        {
                            Return (HPPI (Arg0, Arg1, Arg2, Arg3))
                        }

                        If ((\SRCP (Local0, MUID) == 0x01))
                        {
                            Return (HMOR (Arg0, Arg1, Arg2, Arg3))
                        }

                        Return (0x00)
                    }

                    Method (HPPI, 4, NotSerialized)
                    {
                        If ((Arg1 != 0x01))
                        {
                            Return (Buffer (0x01)
                            {
                                 0x00                                             // .
                            })
                        }

                        If ((Arg2 <= 0x06))
                        {
                            If ((Arg2 == 0x00))
                            {
                                Return (Buffer (0x01)
                                {
                                     0x7F                                             // .
                                })
                            }

                            If ((Arg2 == 0x01))
                            {
                                Return (REV1) /* \_SB_.PCI0.LPCB.GTPM.REV1 */
                            }

                            If ((Arg2 == 0x02))
                            {
                                Local0 = DerefOf (Arg3 [0x00])
                                Debug = "TPM Func 2"
                                Debug = Local0
                                If ((Local0 <= 0x0E))
                                {
                                    If (((Local0 == 0x0C) || (Local0 == 0x0D)))
                                    {
                                        Return (0x01)
                                    }
                                    Else
                                    {
                                        Local2 = 0x02
                                        \_SB.SSMI (0xEA7D, 0x05, 0x00, 0x00, 0x00)
                                        Local1 = ECX /* \ECX_ */
                                        If (((Local1 & 0x01) == 0x01))
                                        {
                                            If (((Local1 & 0x02) == 0x00))
                                            {
                                                If (((Local0 == 0x05) || (Local0 == 0x0E)))
                                                {
                                                    Return (Local2)
                                                }
                                            }

                                            \_SB.SSMI (0xEA7E, 0x00, Local0, 0x00, 0x01)
                                            Debug = EAX /* \EAX_ */
                                            Debug = EBX /* \EBX_ */
                                            Debug = ECX /* \ECX_ */
                                            If ((EBX == 0x00))
                                            {
                                                Local2 = 0x00
                                            }
                                        }

                                        Return (Local2)
                                    }
                                }
                                Else
                                {
                                    Return (0x01)
                                }
                            }

                            If ((Arg2 == 0x03))
                            {
                                Debug = "TPM Func 3"
                                \_SB.SSMI (0xEA7D, 0x00, 0x00, 0x00, 0x01)
                                Debug = EAX /* \EAX_ */
                                Debug = EBX /* \EBX_ */
                                Debug = ECX /* \ECX_ */
                                Name (DSMB, Package (0x02)
                                {
                                    0x01, 
                                    0x00
                                })
                                If ((EBX == 0x00))
                                {
                                    DSMB [0x00] = 0x00
                                    DSMB [0x01] = 0x00
                                    Local0 = ECX /* \ECX_ */
                                    If ((Local0 <= 0x0E))
                                    {
                                        DSMB [0x00] = 0x00
                                        DSMB [0x01] = Local0
                                    }
                                }

                                Return (DSMB) /* \_SB_.PCI0.LPCB.GTPM.HPPI.DSMB */
                            }

                            If ((Arg2 == 0x04))
                            {
                                Return (0x02)
                            }

                            If ((Arg2 == 0x05))
                            {
                                Debug = "TPM Func 5"
                                \_SB.SSMI (0xEA7D, 0x01, 0x00, 0x00, 0x01)
                                Name (DSMC, Package (0x03)
                                {
                                    0x01, 
                                    0x00, 
                                    0x00
                                })
                                Debug = EAX /* \EAX_ */
                                Debug = EBX /* \EBX_ */
                                Debug = ECX /* \ECX_ */
                                If ((EBX == 0x00))
                                {
                                    DSMC [0x00] = 0x00
                                    DSMC [0x01] = ECX /* \ECX_ */
                                    \_SB.SSMI (0xEA7D, 0x02, 0x00, 0x00, 0x01)
                                    DSMC [0x02] = ECX /* \ECX_ */
                                }

                                Return (DSMC) /* \_SB_.PCI0.LPCB.GTPM.HPPI.DSMC */
                            }

                            If ((Arg2 == 0x06))
                            {
                                PPIB = Arg3
                                If ((((DerefOf (PPIB [0x00]) == 0x45) || (DerefOf (
                                    PPIB [0x00]) == 0x65)) && ((DerefOf (PPIB [0x01]) == 0x4E) || 
                                    (DerefOf (PPIB [0x01]) == 0x6E))))
                                {
                                    Return (0x00)
                                }
                                Else
                                {
                                    Return (0x01)
                                }
                            }
                        }

                        Return (Buffer (0x01)
                        {
                             0x00                                             // .
                        })
                    }

                    Method (HMOR, 4, NotSerialized)
                    {
                        If ((Arg1 != 0x01))
                        {
                            Return (0x01)
                        }

                        If ((Arg2 != 0x01))
                        {
                            Return (0x01)
                        }

                        Local0 = DerefOf (Arg3 [0x00])
                        \_SB.SSMI (0xEA7F, Local0, 0x00, 0x00, 0x01)
                        Local0 = 0x00
                        If ((EBX != 0x00))
                        {
                            Local0 = 0x01
                        }

                        Return (Local0)
                    }
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
                    Name (_UID, 0x00)  // _UID: Unique ID
                    Name (BUF0, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            _Y1D)
                    })
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((OSYS >= 0x07D1))
                        {
                            If (HPAE)
                            {
                                Return (0x0F)
                            }
                        }
                        ElseIf (HPAE)
                        {
                            Return (0x0B)
                        }

                        Return (0x00)
                    }

                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        If (HPAE)
                        {
                            CreateDWordField (BUF0, \_SB.PCI0.LPCB.HPET._Y1D._BAS, HPT0)  // _BAS: Base Address
                            If ((HPAS == 0x01))
                            {
                                HPT0 = 0xFED01000
                            }

                            If ((HPAS == 0x02))
                            {
                                HPT0 = 0xFED02000
                            }

                            If ((HPAS == 0x03))
                            {
                                HPT0 = 0xFED03000
                            }
                        }

                        Return (BUF0) /* \_SB_.PCI0.LPCB.HPET.BUF0 */
                    }
                }

                Device (IPIC)
                {
                    Name (_HID, EisaId ("PNP0000") /* 8259-compatible Programmable Interrupt Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0024,             // Range Minimum
                            0x0024,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0028,             // Range Minimum
                            0x0028,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x002C,             // Range Minimum
                            0x002C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0030,             // Range Minimum
                            0x0030,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0034,             // Range Minimum
                            0x0034,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0038,             // Range Minimum
                            0x0038,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x003C,             // Range Minimum
                            0x003C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A4,             // Range Minimum
                            0x00A4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A8,             // Range Minimum
                            0x00A8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00AC,             // Range Minimum
                            0x00AC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B4,             // Range Minimum
                            0x00B4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B8,             // Range Minimum
                            0x00B8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00BC,             // Range Minimum
                            0x00BC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04") /* x87-compatible Floating Point Processing Unit */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (LDRC)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x02)  // _UID: Unique ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x002E,             // Range Minimum
                            0x002E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x004E,             // Range Minimum
                            0x004E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0063,             // Range Minimum
                            0x0063,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0065,             // Range Minimum
                            0x0065,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0067,             // Range Minimum
                            0x0067,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0092,             // Range Minimum
                            0x0092,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00B2,             // Range Minimum
                            0x00B2,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0200,             // Range Minimum
                            0x0200,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0x1000,             // Range Minimum
                            0x1000,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0xFFFF,             // Range Minimum
                            0xFFFF,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0xFFFF,             // Range Minimum
                            0xFFFF,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0400,             // Range Minimum
                            0x0400,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0x0500,             // Range Minimum
                            0x0500,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0xEF80,             // Range Minimum
                            0xEF80,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {8}
                    })
                }

                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0050,             // Range Minimum
                            0x0050,             // Range Maximum
                            0x10,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                }

                Device (SIO)
                {
                    Name (_HID, EisaId ("PNP0A06") /* Generic Container Device */)  // _HID: Hardware ID
                    OperationRegion (SOCG, SystemIO, 0x4E, 0x02)
                    Field (SOCG, ByteAcc, NoLock, Preserve)
                    {
                        SIOI,   8, 
                        SIOD,   8
                    }

                    IndexField (SIOI, SIOD, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x01), 
                            ,   2, 
                        PPPW,   1, 
                        PPM,    1, 
                        Offset (0x02), 
                            ,   3, 
                        S1PW,   1, 
                            ,   3, 
                        S2PW,   1, 
                        Offset (0x04), 
                        PPXM,   2, 
                        Offset (0x0D), 
                        CR0D,   8, 
                        Offset (0x23), 
                        PPBS,   8, 
                        S1BS,   8, 
                        S2BS,   8, 
                        PPDM,   4, 
                        Offset (0x27), 
                        PPIQ,   4, 
                        Offset (0x28), 
                        S2IQ,   4, 
                        S1IQ,   4, 
                        Offset (0x2B), 
                        FRBS,   8, 
                        FRDM,   4
                    }

                    OperationRegion (SORT, SystemIO, 0x0210, 0x10)
                    Field (SORT, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x0C), 
                        GP1,    8, 
                        GP2,    5, 
                        Offset (0x0E), 
                        GP3,    8, 
                        GP4,    8
                    }

                    Mutex (SIOM, 0x00)
                    Name (MSPS, 0x00)
                    Name (MSPV, 0x00)
                    Method (_INI, 0, NotSerialized)  // _INI: Initialize
                    {
                        ECM ()
                        If ((CR0D != 0x7A))
                        {
                            SDFG = 0x00
                        }

                        DCM ()
                    }

                    Method (ECM, 0, NotSerialized)
                    {
                        Acquire (SIOM, 0xFFFF)
                        SIOI = 0x55
                    }

                    Method (DCM, 0, NotSerialized)
                    {
                        SIOI = 0xAA
                        Release (SIOM)
                    }

                    Method (GETS, 1, NotSerialized)
                    {
                        ECM ()
                        Local0 = 0x00
                        If ((Arg0 == 0x01))
                        {
                            Local0 = PPBS /* \_SB_.PCI0.LPCB.SIO_.PPBS */
                        }
                        ElseIf ((Arg0 == 0x02))
                        {
                            Local0 = S1BS /* \_SB_.PCI0.LPCB.SIO_.S1BS */
                        }
                        ElseIf ((Arg0 == 0x03))
                        {
                            Local0 = S2BS /* \_SB_.PCI0.LPCB.SIO_.S2BS */
                        }

                        Local1 = 0x00
                        If ((Local0 & 0xC0))
                        {
                            Local1 = (Local0 << 0x02)
                        }

                        DCM ()
                        Return (Local1)
                    }

                    Method (GETR, 1, NotSerialized)
                    {
                        Name (GRES, Package (0x04)
                        {
                            0x00, 
                            0x00, 
                            0x00, 
                            0x00
                        })
                        ECM ()
                        Local0 = 0x00
                        Local1 = 0x00
                        Local2 = 0x00
                        Local3 = 0x00
                        If ((Arg0 == 0x01))
                        {
                            Local0 = PPBS /* \_SB_.PCI0.LPCB.SIO_.PPBS */
                            Local2 = PPIQ /* \_SB_.PCI0.LPCB.SIO_.PPIQ */
                            Local3 = PPDM /* \_SB_.PCI0.LPCB.SIO_.PPDM */
                        }
                        ElseIf ((Arg0 == 0x02))
                        {
                            Local0 = S1BS /* \_SB_.PCI0.LPCB.SIO_.S1BS */
                            Local2 = S1IQ /* \_SB_.PCI0.LPCB.SIO_.S1IQ */
                        }
                        ElseIf ((Arg0 == 0x03))
                        {
                            Local0 = S2BS /* \_SB_.PCI0.LPCB.SIO_.S2BS */
                            Local1 = FRBS /* \_SB_.PCI0.LPCB.SIO_.FRBS */
                            Local2 = S2IQ /* \_SB_.PCI0.LPCB.SIO_.S2IQ */
                            Local3 = FRDM /* \_SB_.PCI0.LPCB.SIO_.FRDM */
                        }

                        GRES [0x00] = (Local0 << 0x02)
                        GRES [0x01] = (Local1 << 0x03)
                        Local4 = 0x00
                        If ((Local2 > 0x00))
                        {
                            Local4 = (0x01 << Local2)
                        }

                        GRES [0x02] = Local4
                        Local4 = 0x00
                        If (((Local3 > 0x00) && (Local3 < 0x04)))
                        {
                            Local4 = (0x01 << Local3)
                        }

                        GRES [0x03] = Local4
                        DCM ()
                        Return (GRES) /* \_SB_.PCI0.LPCB.SIO_.GETR.GRES */
                    }

                    Method (SETR, 5, NotSerialized)
                    {
                        ECM ()
                        Local0 = (Arg1 >> 0x02)
                        FindSetRightBit (Arg3, Local1)
                        If (((Local1 > 0x01) && (Local1 < 0x11)))
                        {
                            Local1--
                        }
                        Else
                        {
                            Local1 = 0x00
                        }

                        FindSetRightBit (Arg4, Local2)
                        If (((Local2 > 0x01) && (Local2 < 0x05)))
                        {
                            Local2--
                        }
                        Else
                        {
                            Local2 = 0x0F
                        }

                        If ((Arg0 == 0x01))
                        {
                            PPBS = Local0
                            PPIQ = Local1
                            PPDM = Local2
                        }
                        ElseIf ((Arg0 == 0x02))
                        {
                            S1BS = (Local0 & 0xFE)
                            S1IQ = Local1
                        }
                        ElseIf ((Arg0 == 0x03))
                        {
                            S2BS = (Local0 & 0xFE)
                            FRBS = (Arg2 >> 0x03)
                            S2IQ = Local1
                            FRDM = Local2
                        }

                        DCM ()
                    }

                    Method (GLPM, 0, NotSerialized)
                    {
                        ECM ()
                        Local0 = PPM /* \_SB_.PCI0.LPCB.SIO_.PPM_ */
                        Local1 = PPXM /* \_SB_.PCI0.LPCB.SIO_.PPXM */
                        DCM ()
                        If (Local0)
                        {
                            Local2 = 0x00
                        }
                        Else
                        {
                            Local2 = 0x03
                            If ((Local1 == 0x00))
                            {
                                Local2 = 0x01
                            }

                            If ((Local1 == 0x01))
                            {
                                Local2 = 0x02
                            }
                        }

                        Return (Local2)
                    }

                    Method (DPWS, 1, Serialized)
                    {
                        ECM ()
                        If ((Arg0 == 0x01))
                        {
                            Local0 = PPPW /* \_SB_.PCI0.LPCB.SIO_.PPPW */
                        }
                        ElseIf ((Arg0 == 0x02))
                        {
                            Local0 = S1PW /* \_SB_.PCI0.LPCB.SIO_.S1PW */
                        }
                        ElseIf ((Arg0 == 0x03))
                        {
                            Local0 = S2PW /* \_SB_.PCI0.LPCB.SIO_.S2PW */
                        }

                        DCM ()
                        Return (Local0)
                    }

                    Method (DPW, 2, Serialized)
                    {
                        ECM ()
                        If ((Arg0 == 0x01))
                        {
                            PPPW = Arg1
                        }
                        ElseIf ((Arg0 == 0x02))
                        {
                            S1PW = Arg1
                        }
                        ElseIf ((Arg0 == 0x03))
                        {
                            S2PW = Arg1
                        }

                        DCM ()
                    }

                    Method (GDPA, 0, Serialized)
                    {
                        Local0 = GETS (0x02)
                        Return (Local0)
                    }

                    Alias (GDPA, \_SB.GDPA)
                    Method (SODS, 2, Serialized)
                    {
                        Local1 = (~SDFG & Arg1)
                        If ((LEGF || Local1))
                        {
                            Local0 = 0x00
                        }
                        Else
                        {
                            Local1 = GETS (Arg0)
                            Local0 = 0x0D
                            If (Local1)
                            {
                                Local0 = 0x0F
                            }
                        }

                        Return (Local0)
                    }

                    Method (DSOD, 1, Serialized)
                    {
                        If (GETS (Arg0))
                        {
                            Local0 = GETR (Arg0)
                            Local1 = DerefOf (Local0 [0x01])
                            Local2 = DerefOf (Local0 [0x02])
                            Local3 = DerefOf (Local0 [0x03])
                            Local4 = DerefOf (Local0 [0x00])
                            Local3 |= (Local4 << 0x08)
                            \_SB.PCI0.LPCB.CFG (Arg0, 0x00, Local1, Local2, Local3)
                            SETR (Arg0, 0x00, 0x00, 0x00, 0x00)
                        }
                    }

                    Device (HCOM)
                    {
                        Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                        Name (_UID, 0x04)  // _UID: Unique ID
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (CMRS, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x03F8,             // Range Minimum
                                    0x03F8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    _Y1E)
                            })
                            CreateWordField (CMRS, \_SB.PCI0.LPCB.SIO.HCOM._CRS._Y1E._MIN, MIN1)  // _MIN: Minimum Base Address
                            CreateWordField (CMRS, \_SB.PCI0.LPCB.SIO.HCOM._CRS._Y1E._MAX, MAX1)  // _MAX: Maximum Base Address
                            Local1 = GETR (0x02)
                            MIN1 = DerefOf (Local1 [0x00])
                            MAX1 = MIN1 /* \_SB_.PCI0.LPCB.SIO_.HCOM._CRS.MIN1 */
                            Return (CMRS) /* \_SB_.PCI0.LPCB.SIO_.HCOM._CRS.CMRS */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Local0 = 0x00
                            If (LEGF)
                            {
                                If (GETS (0x02))
                                {
                                    Local0 = 0x0F
                                }
                            }

                            Return (Local0)
                        }
                    }

                    Device (COM1)
                    {
                        Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                        Name (_CID, EisaId ("PNP0500") /* Standard PC COM Serial Port */)  // _CID: Compatible ID
                        Name (_DDN, "COM1")  // _DDN: DOS Device Name
                        Name (RCOD, 0x00)
                        Name (POSS, ResourceTemplate ()
                        {
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x03F8,             // Range Minimum
                                    0x03F8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IRQNoFlags ()
                                    {4}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x02F8,             // Range Minimum
                                    0x02F8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IRQNoFlags ()
                                    {3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x03E8,             // Range Minimum
                                    0x03E8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IRQNoFlags ()
                                    {4}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x02E8,             // Range Minimum
                                    0x02E8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IRQNoFlags ()
                                    {3}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                        {
                            Return (POSS) /* \_SB_.PCI0.LPCB.SIO_.COM1.POSS */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Local0 = 0x00
                            If ((\_SB.DCKD () || ICPT))
                            {
                                If (!RCOD)
                                {
                                    Local0 = SODS (0x02, 0x02)
                                }
                                Else
                                {
                                    Local0 = 0x0D
                                }
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                        {
                            DSOD (0x02)
                            Return (0x00)
                        }

                        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x02, MIN1)
                            CreateWordField (Arg0, 0x09, IRQ0)
                            If (SODS (0x02, 0x02))
                            {
                                _DIS ()
                                \_SB.PCI0.LPCB.CFG (0x02, MIN1, 0x00, IRQ0, 0x00)
                                SETR (0x02, MIN1, 0x00, IRQ0, 0x00)
                            }

                            RCOD = 0x00
                        }

                        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                        {
                            Name (CRES, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x03F8,             // Range Minimum
                                    0x03F8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    _Y1F)
                                IRQNoFlags (_Y20)
                                    {4}
                            })
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.COM1._CRS._Y1F._MIN, MIN1)  // _MIN: Minimum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.COM1._CRS._Y1F._MAX, MAX1)  // _MAX: Maximum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.COM1._CRS._Y20._INT, IRQ0)  // _INT: Interrupts
                            If (RCOD)
                            {
                                Local0 = 0x00
                            }
                            Else
                            {
                                Local0 = SODS (0x02, 0x02)
                            }

                            If ((Local0 == 0x00))
                            {
                                MIN1 = 0x00
                                MAX1 = 0x00
                                IRQ0 = 0x00
                                Return (CRES) /* \_SB_.PCI0.LPCB.SIO_.COM1._CRS.CRES */
                            }

                            Local1 = GETR (0x02)
                            MIN1 = DerefOf (Local1 [0x00])
                            MAX1 = MIN1 /* \_SB_.PCI0.LPCB.SIO_.COM1._CRS.MIN1 */
                            IRQ0 = DerefOf (Local1 [0x02])
                            Return (CRES) /* \_SB_.PCI0.LPCB.SIO_.COM1._CRS.CRES */
                        }

                        PowerResource (COMP, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                Return (DPWS (0x02))
                            }

                            Method (_ON, 0, NotSerialized)  // _ON_: Power On
                            {
                                DPW (0x02, 0x01)
                            }

                            Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                            {
                            }
                        }

                        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                        {
                            COMP
                        })
                    }

                    Device (LPT0)
                    {
                        Method (_HID, 0, Serialized)  // _HID: Hardware ID
                        {
                            If (GTM ())
                            {
                                Local0 = 0x0104D041
                            }
                            Else
                            {
                                Local0 = 0x0004D041
                            }

                            Return (Local0)
                        }

                        Name (LPM, 0xFF)
                        Method (GTM, 0, Serialized)
                        {
                            If ((LPM == 0xFF))
                            {
                                Local0 = GLPM ()
                                LPM = 0x00
                                If ((Local0 > 0x01))
                                {
                                    LPM = 0x01
                                }
                            }

                            Return (LPM) /* \_SB_.PCI0.LPCB.SIO_.LPT0.LPM_ */
                        }

                        Name (RLPD, 0x00)
                        Name (POSS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16,
                                    0x0378,             // Range Minimum
                                    0x0378,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0778,             // Range Minimum
                                    0x0778,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {1,3}
                            }
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16,
                                    0x0278,             // Range Minimum
                                    0x0278,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0678,             // Range Minimum
                                    0x0678,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x03BC,             // Range Minimum
                                    0x03BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x04,               // Length
                                    )
                                IO (Decode16,
                                    0x07BC,             // Range Minimum
                                    0x07BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x0378,             // Range Minimum
                                    0x0378,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0778,             // Range Minimum
                                    0x0778,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x0278,             // Range Minimum
                                    0x0278,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0678,             // Range Minimum
                                    0x0678,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x03BC,             // Range Minimum
                                    0x03BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x04,               // Length
                                    )
                                IO (Decode16,
                                    0x07BC,             // Range Minimum
                                    0x07BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x0378,             // Range Minimum
                                    0x0378,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0778,             // Range Minimum
                                    0x0778,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x0278,             // Range Minimum
                                    0x0278,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0678,             // Range Minimum
                                    0x0678,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x03BC,             // Range Minimum
                                    0x03BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x04,               // Length
                                    )
                                IO (Decode16,
                                    0x07BC,             // Range Minimum
                                    0x07BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                        {
                            Return (POSS) /* \_SB_.PCI0.LPCB.SIO_.LPT0.POSS */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (RLPD)
                            {
                                Local0 = 0x0D
                            }
                            Else
                            {
                                Local0 = SODS (0x01, 0x04)
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                        {
                            DSOD (0x01)
                            Return (0x00)
                        }

                        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x02, MIN1)
                            CreateWordField (Arg0, 0x0A, MIN2)
                            CreateWordField (Arg0, 0x11, IRQ0)
                            CreateWordField (Arg0, 0x14, DMA0)
                            If (SODS (0x01, 0x04))
                            {
                                _DIS ()
                                \_SB.PCI0.LPCB.CFG (0x01, MIN1, MIN2, IRQ0, DMA0)
                                SETR (0x01, MIN1, MIN2, IRQ0, DMA0)
                            }

                            RLPD = 0x00
                        }

                        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                        {
                            Name (CRES, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x0378,             // Range Minimum
                                    0x0378,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    _Y21)
                                IO (Decode16,
                                    0x0778,             // Range Minimum
                                    0x0778,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    _Y22)
                                IRQNoFlags (_Y23)
                                    {7}
                                DMA (Compatibility, NotBusMaster, Transfer8, _Y24)
                                    {3}
                            })
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y21._MIN, MIN1)  // _MIN: Minimum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y21._MAX, MAX1)  // _MAX: Maximum Base Address
                            CreateByteField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y21._LEN, LEN1)  // _LEN: Length
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y22._MIN, MIN2)  // _MIN: Minimum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y22._MAX, MAX2)  // _MAX: Maximum Base Address
                            CreateByteField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y22._LEN, LEN2)  // _LEN: Length
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y23._INT, IRQ0)  // _INT: Interrupts
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y24._DMA, DMA0)  // _DMA: Direct Memory Access
                            If (RLPD)
                            {
                                Local0 = 0x00
                            }
                            Else
                            {
                                Local0 = SODS (0x01, 0x04)
                            }

                            If ((Local0 == 0x00))
                            {
                                MIN1 = 0x00
                                MAX1 = 0x00
                                MIN2 = 0x00
                                MAX2 = 0x00
                                IRQ0 = 0x00
                                DMA0 = 0x00
                                Return (CRES) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.CRES */
                            }

                            Local1 = GETR (0x01)
                            MIN1 = DerefOf (Local1 [0x00])
                            MAX1 = MIN1 /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.MIN1 */
                            If ((MIN1 == 0x0278))
                            {
                                LEN1 = 0x08
                                LEN2 = 0x03
                            }

                            If ((MIN1 == 0x03BC))
                            {
                                LEN1 = 0x04
                                LEN2 = 0x03
                            }

                            MIN2 = (MIN1 + 0x0400)
                            MAX2 = MIN2 /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.MIN2 */
                            IRQ0 = DerefOf (Local1 [0x02])
                            DMA0 = DerefOf (Local1 [0x03])
                            Return (CRES) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.CRES */
                        }

                        PowerResource (LPP, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                Return (DPWS (0x01))
                            }

                            Method (_ON, 0, NotSerialized)  // _ON_: Power On
                            {
                                DPW (0x01, 0x01)
                            }

                            Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                            {
                            }
                        }

                        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                        {
                            LPP
                        })
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {1}
                    })
                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            FixedIO (
                                0x0060,             // Address
                                0x01,               // Length
                                )
                            FixedIO (
                                0x0064,             // Address
                                0x01,               // Length
                                )
                            IRQNoFlags ()
                                {1}
                        }
                        EndDependentFn ()
                    })
                }

                Device (PS2M)
                {
                    Name (_CID, Package (0x03)  // _CID: Compatible ID
                    {
                        EisaId ("SYN0100"), 
                        EisaId ("SYN0002"), 
                        EisaId ("PNP0F13") /* PS/2 Mouse */
                    })
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {12}
                    })
                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            IRQNoFlags ()
                                {12}
                        }
                        EndDependentFn ()
                    })
                }
            }

            Device (SATA)
            {
                Name (_ADR, 0x001F0002)  // _ADR: Address
                OperationRegion (SACS, PCI_Config, 0x40, 0xC0)
                Field (SACS, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16, 
                    SECT,   16, 
                    PSIT,   4, 
                    SSIT,   4, 
                    Offset (0x08), 
                    SYNC,   4, 
                    Offset (0x0A), 
                    SDT0,   2, 
                        ,   2, 
                    SDT1,   2, 
                    Offset (0x0B), 
                    SDT2,   2, 
                        ,   2, 
                    SDT3,   2, 
                    Offset (0x14), 
                    ICR0,   4, 
                    ICR1,   4, 
                    ICR2,   4, 
                    ICR3,   4, 
                    ICR4,   4, 
                    ICR5,   4, 
                    Offset (0x50), 
                    MAPV,   2
                }
            }

            Device (SAT1)
            {
                Name (_ADR, 0x001F0005)  // _ADR: Address
                OperationRegion (SACS, PCI_Config, 0x40, 0xC0)
                Field (SACS, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16, 
                    SECT,   16, 
                    PSIT,   4, 
                    SSIT,   4, 
                    Offset (0x08), 
                    SYNC,   4, 
                    Offset (0x0A), 
                    SDT0,   2, 
                        ,   2, 
                    SDT1,   2, 
                    Offset (0x0B), 
                    SDT2,   2, 
                        ,   2, 
                    SDT3,   2, 
                    Offset (0x14), 
                    ICR0,   4, 
                    ICR1,   4, 
                    ICR2,   4, 
                    ICR3,   4, 
                    ICR4,   4, 
                    ICR5,   4, 
                    Offset (0x50), 
                    MAPV,   2
                }
            }

            Device (SBUS)
            {
                Name (_ADR, 0x001F0003)  // _ADR: Address
                OperationRegion (SMBP, PCI_Config, 0x40, 0xC0)
                Field (SMBP, DWordAcc, NoLock, Preserve)
                {
                        ,   2, 
                    I2CE,   1
                }

                OperationRegion (SMBI, SystemIO, 0xEF80, 0x10)
                Field (SMBI, ByteAcc, NoLock, Preserve)
                {
                    HSTS,   8, 
                    Offset (0x02), 
                    HCON,   8, 
                    HCOM,   8, 
                    TXSA,   8, 
                    DAT0,   8, 
                    DAT1,   8, 
                    HBDR,   8, 
                    PECR,   8, 
                    RXSA,   8, 
                    SDAT,   16
                }

                Method (SSXB, 2, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0x00)
                    }

                    I2CE = 0x00
                    HSTS = 0xBF
                    TXSA = Arg0
                    HCOM = Arg1
                    HCON = 0x48
                    If (COMP ())
                    {
                        HSTS |= 0xFF
                        Return (0x01)
                    }

                    Return (0x00)
                }

                Method (SRXB, 1, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0xFFFF)
                    }

                    I2CE = 0x00
                    HSTS = 0xBF
                    TXSA = (Arg0 | 0x01)
                    HCON = 0x44
                    If (COMP ())
                    {
                        HSTS |= 0xFF
                        Return (DAT0) /* \_SB_.PCI0.SBUS.DAT0 */
                    }

                    Return (0xFFFF)
                }

                Method (SWRB, 3, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0x00)
                    }

                    I2CE = 0x00
                    HSTS = 0xBF
                    TXSA = Arg0
                    HCOM = Arg1
                    DAT0 = Arg2
                    HCON = 0x48
                    If (COMP ())
                    {
                        HSTS |= 0xFF
                        Return (0x01)
                    }

                    Return (0x00)
                }

                Method (SRDB, 2, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0xFFFF)
                    }

                    I2CE = 0x00
                    HSTS = 0xBF
                    TXSA = (Arg0 | 0x01)
                    HCOM = Arg1
                    HCON = 0x48
                    If (COMP ())
                    {
                        HSTS |= 0xFF
                        Return (DAT0) /* \_SB_.PCI0.SBUS.DAT0 */
                    }

                    Return (0xFFFF)
                }

                Method (SWRW, 3, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0x00)
                    }

                    I2CE = 0x00
                    HSTS = 0xBF
                    TXSA = Arg0
                    HCOM = Arg1
                    DAT1 = (Arg2 & 0xFF)
                    DAT0 = ((Arg2 >> 0x08) & 0xFF)
                    HCON = 0x4C
                    If (COMP ())
                    {
                        HSTS |= 0xFF
                        Return (0x01)
                    }

                    Return (0x00)
                }

                Method (SRDW, 2, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0xFFFF)
                    }

                    I2CE = 0x00
                    HSTS = 0xBF
                    TXSA = (Arg0 | 0x01)
                    HCOM = Arg1
                    HCON = 0x4C
                    If (COMP ())
                    {
                        HSTS |= 0xFF
                        Return (((DAT0 << 0x08) | DAT1))
                    }

                    Return (0xFFFFFFFF)
                }

                Method (SBLW, 4, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0x00)
                    }

                    I2CE = Arg3
                    HSTS = 0xBF
                    TXSA = Arg0
                    HCOM = Arg1
                    DAT0 = SizeOf (Arg2)
                    Local1 = 0x00
                    HBDR = DerefOf (Arg2 [0x00])
                    HCON = 0x54
                    While ((SizeOf (Arg2) > Local1))
                    {
                        Local0 = 0x0FA0
                        While ((!(HSTS & 0x80) && Local0))
                        {
                            Local0--
                            Stall (0x32)
                        }

                        If (!Local0)
                        {
                            KILL ()
                            Return (0x00)
                        }

                        HSTS = 0x80
                        Local1++
                        If ((SizeOf (Arg2) > Local1))
                        {
                            HBDR = DerefOf (Arg2 [Local1])
                        }
                    }

                    If (COMP ())
                    {
                        HSTS |= 0xFF
                        Return (0x01)
                    }

                    Return (0x00)
                }

                Method (SBLR, 3, Serialized)
                {
                    Name (TBUF, Buffer (0x0100){})
                    If (STRT ())
                    {
                        Return (0x00)
                    }

                    I2CE = Arg2
                    HSTS = 0xBF
                    TXSA = (Arg0 | 0x01)
                    HCOM = Arg1
                    HCON = 0x54
                    Local0 = 0x0FA0
                    While ((!(HSTS & 0x80) && Local0))
                    {
                        Local0--
                        Stall (0x32)
                    }

                    If (!Local0)
                    {
                        KILL ()
                        Return (0x00)
                    }

                    TBUF [0x00] = DAT0 /* \_SB_.PCI0.SBUS.DAT0 */
                    HSTS = 0x80
                    Local1 = 0x01
                    While ((Local1 < DerefOf (TBUF [0x00])))
                    {
                        Local0 = 0x0FA0
                        While ((!(HSTS & 0x80) && Local0))
                        {
                            Local0--
                            Stall (0x32)
                        }

                        If (!Local0)
                        {
                            KILL ()
                            Return (0x00)
                        }

                        TBUF [Local1] = HBDR /* \_SB_.PCI0.SBUS.HBDR */
                        HSTS = 0x80
                        Local1++
                    }

                    If (COMP ())
                    {
                        HSTS |= 0xFF
                        Return (TBUF) /* \_SB_.PCI0.SBUS.SBLR.TBUF */
                    }

                    Return (0x00)
                }

                Method (STRT, 0, Serialized)
                {
                    Local0 = 0xC8
                    While (Local0)
                    {
                        If ((HSTS & 0x40))
                        {
                            Local0--
                            Sleep (0x01)
                            If ((Local0 == 0x00))
                            {
                                Return (0x01)
                            }
                        }
                        Else
                        {
                            Local0 = 0x00
                        }
                    }

                    Local0 = 0x0FA0
                    While (Local0)
                    {
                        If ((HSTS & 0x01))
                        {
                            Local0--
                            Stall (0x32)
                            If ((Local0 == 0x00))
                            {
                                KILL ()
                            }
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }

                    Return (0x01)
                }

                Method (COMP, 0, Serialized)
                {
                    Local0 = 0x0FA0
                    While (Local0)
                    {
                        If ((HSTS & 0x02))
                        {
                            Return (0x01)
                        }
                        Else
                        {
                            Local0--
                            Stall (0x32)
                            If ((Local0 == 0x00))
                            {
                                KILL ()
                            }
                        }
                    }

                    Return (0x00)
                }

                Method (KILL, 0, Serialized)
                {
                    HCON |= 0x02
                    HSTS |= 0xFF
                }
            }

            Scope (\)
            {
                OperationRegion (THMR, SystemMemory, TBRB, 0xDC)
                Field (THMR, AnyAcc, Lock, Preserve)
                {
                    Offset (0x30), 
                    CTV1,   16, 
                    CTV2,   16, 
                    Offset (0x60), 
                    PTV,    8, 
                    Offset (0xD8), 
                    PCHT,   8, 
                    MCHT,   8
                }
            }

            Device (RP01)
            {
                Name (_ADR, 0x001C0000)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                PDCX = 0x01
                                HPSX = 0x01
                                \_SB.SSMI (0x5D, 0x00, 0x00, 0x00, 0x00)
                                Notify (^, 0x00) // Bus Check
                            }
                            Else
                            {
                                HPSX = 0x01
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                PSPX = 0x01
                            }

                            PMSX = 0x01
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        HPCE = Arg0
                        If (Arg0)
                        {
                            Local6 = (SCTL & 0xFFC0)
                            If (SI)
                            {
                                Local6 |= 0x01
                            }

                            SCTL = Local6
                            SSTS = 0x3F
                        }
                        Else
                        {
                            ABPX = 0x01
                            PDCX = 0x01
                            HPSX = 0x01
                        }

                        PMCE = Arg1
                        If ((Arg1 == 0x00))
                        {
                            PMSX = 0x01
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (\GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                0x00, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                0x00, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                0x00, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                0x00, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                LNKA, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                LNKB, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKC, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKD, 
                                0x00
                            }
                        })
                    }
                }
            }

            Device (RP02)
            {
                Name (_ADR, 0x001C0001)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                PDCX = 0x01
                                HPSX = 0x01
                                \_SB.SSMI (0x5D, 0x00, 0x00, 0x00, 0x00)
                                Notify (^, 0x00) // Bus Check
                            }
                            Else
                            {
                                HPSX = 0x01
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                PSPX = 0x01
                            }

                            PMSX = 0x01
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        HPCE = Arg0
                        If (Arg0)
                        {
                            Local6 = (SCTL & 0xFFC0)
                            If (SI)
                            {
                                Local6 |= 0x01
                            }

                            SCTL = Local6
                            SSTS = 0x3F
                        }
                        Else
                        {
                            ABPX = 0x01
                            PDCX = 0x01
                            HPSX = 0x01
                        }

                        PMCE = Arg1
                        If ((Arg1 == 0x00))
                        {
                            PMSX = 0x01
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (\GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                0x00, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                0x00, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                0x00, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                0x00, 
                                0x10
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                LNKB, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                LNKC, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKD, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKA, 
                                0x00
                            }
                        })
                    }
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
                Device (ECF0)
                {
                    Name (_ADR, 0x00)  // _ADR: Address
                    Method (_PRW, 0, Serialized)  // _PRW: Power Resources for Wake
                    {
                        Return (^^_PRW) /* \_SB_.PCI0.RP02._PRW */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (0x01)
                    }
                }

                Device (ECF1)
                {
                    Name (_ADR, 0x01)  // _ADR: Address
                }

                Device (ECF2)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                }

                Device (ECF3)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                }

                Device (ECF4)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                }

                Device (ECF5)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                }

                Device (ECF6)
                {
                    Name (_ADR, 0x06)  // _ADR: Address
                }

                Device (ECF7)
                {
                    Name (_ADR, 0x07)  // _ADR: Address
                }

                Scope (ECF0)
                {
                    Method (_EJD, 0, NotSerialized)  // _EJD: Ejection Dependent Device
                    {
                        Return ("\\_SB.PCI0.EHC1.RHUB.PRT0.HPT4")
                    }
                }
            }

            Device (RP03)
            {
                Name (_ADR, 0x001C0002)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                PDCX = 0x01
                                HPSX = 0x01
                                \_SB.SSMI (0x5D, 0x00, 0x00, 0x00, 0x00)
                                Notify (^, 0x00) // Bus Check
                            }
                            Else
                            {
                                HPSX = 0x01
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                PSPX = 0x01
                            }

                            PMSX = 0x01
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        HPCE = Arg0
                        If (Arg0)
                        {
                            Local6 = (SCTL & 0xFFC0)
                            If (SI)
                            {
                                Local6 |= 0x01
                            }

                            SCTL = Local6
                            SSTS = 0x3F
                        }
                        Else
                        {
                            ABPX = 0x01
                            PDCX = 0x01
                            HPSX = 0x01
                        }

                        PMCE = Arg1
                        If ((Arg1 == 0x00))
                        {
                            PMSX = 0x01
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (\GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                0x00, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                0x00, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                0x00, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                0x00, 
                                0x11
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                LNKC, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                LNKD, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKA, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKB, 
                                0x00
                            }
                        })
                    }
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
                Device (SMHC)
                {
                    OperationRegion (JMDE, PCI_Config, 0xAC, 0x10)
                    Field (JMDE, AnyAcc, NoLock, Preserve)
                    {
                            ,   6, 
                        D3EF,   1, 
                        Offset (0x01)
                    }

                    Name (_ADR, 0x00)  // _ADR: Address
                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        If (\_OSI ("Windows 2009"))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (One)
                        }
                    }
                }

                Device (MSHC)
                {
                    Name (_ADR, 0x01)  // _ADR: Address
                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        If (\_OSI ("Windows 2009"))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (One)
                        }
                    }
                }

                Device (XDCC)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        If (\_OSI ("Windows 2009"))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (One)
                        }
                    }
                }

                Device (I1C)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        If (\_OSI ("Windows 2009"))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (One)
                        }
                    }
                }
            }

            Device (RP04)
            {
                Name (_ADR, 0x001C0003)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                PDCX = 0x01
                                HPSX = 0x01
                                \_SB.SSMI (0x5D, 0x00, 0x00, 0x00, 0x00)
                                Notify (^, 0x00) // Bus Check
                            }
                            Else
                            {
                                HPSX = 0x01
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                PSPX = 0x01
                            }

                            PMSX = 0x01
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        HPCE = Arg0
                        If (Arg0)
                        {
                            Local6 = (SCTL & 0xFFC0)
                            If (SI)
                            {
                                Local6 |= 0x01
                            }

                            SCTL = Local6
                            SSTS = 0x3F
                        }
                        Else
                        {
                            ABPX = 0x01
                            PDCX = 0x01
                            HPSX = 0x01
                        }

                        PMCE = Arg1
                        If ((Arg1 == 0x00))
                        {
                            PMSX = 0x01
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (\GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                0x00, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                0x00, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                0x00, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                0x00, 
                                0x12
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                LNKD, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                LNKA, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKB, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKC, 
                                0x00
                            }
                        })
                    }
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x05
                })
                Device (WNIC)
                {
                    Name (_ADR, 0x00)  // _ADR: Address
                    Method (_PRW, 0, Serialized)  // _PRW: Power Resources for Wake
                    {
                        Return (^^_PRW) /* \_SB_.PCI0.RP04._PRW */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }
                }
            }

            Device (RP05)
            {
                Name (_ADR, 0x001C0004)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                PDCX = 0x01
                                HPSX = 0x01
                                \_SB.SSMI (0x5D, 0x00, 0x00, 0x00, 0x00)
                                Notify (^, 0x00) // Bus Check
                            }
                            Else
                            {
                                HPSX = 0x01
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                PSPX = 0x01
                            }

                            PMSX = 0x01
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        HPCE = Arg0
                        If (Arg0)
                        {
                            Local6 = (SCTL & 0xFFC0)
                            If (SI)
                            {
                                Local6 |= 0x01
                            }

                            SCTL = Local6
                            SSTS = 0x3F
                        }
                        Else
                        {
                            ABPX = 0x01
                            PDCX = 0x01
                            HPSX = 0x01
                        }

                        PMCE = Arg1
                        If ((Arg1 == 0x00))
                        {
                            PMSX = 0x01
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (^^RP01._PRT ())
                }
            }

            Device (RP06)
            {
                Name (_ADR, 0x001C0005)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                PDCX = 0x01
                                HPSX = 0x01
                                \_SB.SSMI (0x5D, 0x00, 0x00, 0x00, 0x00)
                                Notify (^, 0x00) // Bus Check
                            }
                            Else
                            {
                                HPSX = 0x01
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                PSPX = 0x01
                            }

                            PMSX = 0x01
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        HPCE = Arg0
                        If (Arg0)
                        {
                            Local6 = (SCTL & 0xFFC0)
                            If (SI)
                            {
                                Local6 |= 0x01
                            }

                            SCTL = Local6
                            SSTS = 0x3F
                        }
                        Else
                        {
                            ABPX = 0x01
                            PDCX = 0x01
                            HPSX = 0x01
                        }

                        PMCE = Arg1
                        If ((Arg1 == 0x00))
                        {
                            PMSX = 0x01
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (^^RP02._PRT ())
                }
            }

            Device (RP07)
            {
                Name (_ADR, 0x001C0006)  // _ADR: Address
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP7D))
                }

                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                PDCX = 0x01
                                HPSX = 0x01
                                \_SB.SSMI (0x5D, 0x00, 0x00, 0x00, 0x00)
                                Notify (^, 0x00) // Bus Check
                            }
                            Else
                            {
                                HPSX = 0x01
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                PSPX = 0x01
                            }

                            PMSX = 0x01
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        HPCE = Arg0
                        If (Arg0)
                        {
                            Local6 = (SCTL & 0xFFC0)
                            If (SI)
                            {
                                Local6 |= 0x01
                            }

                            SCTL = Local6
                            SSTS = 0x3F
                        }
                        Else
                        {
                            ABPX = 0x01
                            PDCX = 0x01
                            HPSX = 0x01
                        }

                        PMCE = Arg1
                        If ((Arg1 == 0x00))
                        {
                            PMSX = 0x01
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (^^RP03._PRT ())
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }

            Device (RP08)
            {
                Name (_ADR, 0x001C0007)  // _ADR: Address
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP8D))
                }

                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                PDCX = 0x01
                                HPSX = 0x01
                                \_SB.SSMI (0x5D, 0x00, 0x00, 0x00, 0x00)
                                Notify (^, 0x00) // Bus Check
                            }
                            Else
                            {
                                HPSX = 0x01
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                PSPX = 0x01
                            }

                            PMSX = 0x01
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        HPCE = Arg0
                        If (Arg0)
                        {
                            Local6 = (SCTL & 0xFFC0)
                            If (SI)
                            {
                                Local6 |= 0x01
                            }

                            SCTL = Local6
                            SSTS = 0x3F
                        }
                        Else
                        {
                            ABPX = 0x01
                            PDCX = 0x01
                            HPSX = 0x01
                        }

                        PMCE = Arg1
                        If ((Arg1 == 0x00))
                        {
                            PMSX = 0x01
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (^^RP04._PRT ())
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (UPRW (0x09, 0x04))
                }
            }

            Method (POSC, 2, Serialized)
            {
                If ((Arg1 || ((Arg0 & 0x01) || (Arg0 & 0x04))))
                {
                    Local4 = ((Arg0 & 0x01) ^ 0x01)
                    Local5 = (((Arg0 >> 0x02) & 0x01) ^ 0x01)
                    \_SB.PCI0.RP01.OSC (Local4, Local5)
                    \_SB.PCI0.RP02.OSC (Local4, Local5)
                    If ((\_SB.PCI0.RP03.HPCE && 0x00))
                    {
                        \_SB.PCI0.RP03.OSC (Local4, Local5)
                    }
                    Else
                    {
                        \_SB.PCI0.RP03.OSC (0x01, Local5)
                    }

                    \_SB.PCI0.RP04.OSC (Local4, Local5)
                    \_SB.PCI0.RP05.OSC (Local4, Local5)
                    \_SB.PCI0.RP06.OSC (Local4, Local5)
                    \_SB.PCI0.RP07.OSC (Local4, Local5)
                    \_SB.PCI0.RP08.OSC (Local4, Local5)
                    \_SB.PCI0.LPCB.BPEE = Local5
                }
            }

            Device (B0D4)
            {
                Name (_ADR, 0x00040000)  // _ADR: Address
            }

            Scope (\)
            {
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x22), 
                    GPIS,   16, 
                    Offset (0x2A), 
                    GPIE,   16, 
                    Offset (0x30), 
                    GSIE,   1, 
                    EOS,    1, 
                        ,   2, 
                    SSME,   1, 
                    Offset (0x34), 
                        ,   5, 
                    APMS,   1, 
                    Offset (0x38), 
                    AGSE,   16, 
                    AGSS,   16
                }

                Field (GPIO, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x04), 
                    GPSL,   32, 
                    Offset (0x0C), 
                    GPL0,   32, 
                    Offset (0x2C), 
                    GIV,    32, 
                    Offset (0x38), 
                    GPL2,   32, 
                    Offset (0x48), 
                    GPL3,   32
                }
            }

            Method (GUPT, 1, NotSerialized)
            {
                Local2 = (Arg0 & 0x0F)
                Local1 = 0x06
                If ((Arg0 == 0x001D0003))
                {
                    Local0 = 0x0A
                    Return (Local0)
                }

                Local0 = (Local2 << 0x01)
                If (((Arg0 & 0x001A0000) == 0x001A0000))
                {
                    Local0 += Local1
                }

                Return (Local0)
            }

            Method (UPSW, 1, Serialized)
            {
                Local0 = 0x01
                Local1 = (0x0407 >> Arg0)
                Local0 = (Local1 & 0x01)
                Return (Local0)
            }

            Method (\_SB.PCI0.GSWS, 1, NotSerialized)
            {
                While (APMS)
                {
                    Stall (0x01)
                }

                SSMP = 0xF3
                Stall (0x32)
                While (APMS)
                {
                    Stall (0x01)
                }
            }

            Mutex (SMIM, 0x00)
            Name (SMIS, 0x00)
            Name (SMID, 0x00)
            Method (DSMI, 0, NotSerialized)
            {
                Acquire (SMIM, 0xFFFF)
                If ((SMID == 0x00))
                {
                    GSIE = 0x00
                    EOS = 0x00
                }

                SMID++
                Release (SMIM)
            }

            Method (ESMI, 0, NotSerialized)
            {
                Acquire (SMIM, 0xFFFF)
                SMID--
                If ((SMID == 0x00))
                {
                    EOS = 0x01
                    GSIE = 0x01
                }

                Release (SMIM)
            }

            Alias (DSMI, \DSMI)
            Alias (ESMI, \ESMI)
            Name (PUID, ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */)
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                CreateDWordField (Arg3, 0x00, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                Local1 = Arg0
                If ((\SRCP (Local1, PUID) == 0x01))
                {
                    Local2 = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
                    Local3 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
                    If (((Local2 & 0x16) != 0x16))
                    {
                        Local3 &= 0x1E
                    }

                    Local3 &= 0x1D
                    If (!(CDW1 & 0x01))
                    {
                        POSC (Local3, 0x01)
                        If ((Local3 & 0x10)){}
                    }

                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != Local3))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = Local3
                    OSCC = Local3
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }

            Method (ICST, 1, NotSerialized)
            {
                Local0 = 0x0F
                If ((Arg0 == 0x01))
                {
                    Local0 = 0x00
                }

                Return (Local0)
            }

            Scope (RP01)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP1D))
                }
            }

            Scope (RP02)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP2D))
                }
            }

            Scope (RP03)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP3D))
                }
            }

            Scope (RP04)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP4D))
                }
            }

            Scope (RP05)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP5D))
                }
            }

            Scope (RP06)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP6D))
                }
            }

            Scope (HDEF)
            {
                Name (ASTA, 0x00)
                Name (ASTI, 0x00)
                PowerResource (APPR, 0x00, 0x0000)
                {
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (ASTA) /* \_SB_.PCI0.HDEF.ASTA */
                    }

                    Method (_ON, 0, NotSerialized)  // _ON_: Power On
                    {
                        ASTA = 0x01
                        ASTI = \_SB.PCI0.LPCB.EC0.SAST (0x01)
                    }

                    Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                    {
                        ASTA = 0x00
                        ASTI = \_SB.PCI0.LPCB.EC0.SAST (0x00)
                    }
                }

                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    APPR
                })
            }

            Scope (LPCB)
            {
                OperationRegion (LPC2, PCI_Config, 0x80, 0x3C)
                Field (LPC2, AnyAcc, NoLock, Preserve)
                {
                    CMAD,   3, 
                        ,   1, 
                    CMBD,   3, 
                    Offset (0x01), 
                    LPDC,   2, 
                        ,   2, 
                    FDDC,   1, 
                    Offset (0x02), 
                    CALE,   1, 
                    CBLE,   1, 
                    LLPE,   1, 
                    FDLE,   1, 
                    Offset (0x08), 
                    G2DC,   16, 
                    G2MK,   8, 
                    Offset (0x20), 
                        ,   10, 
                    BPEE,   1, 
                    Offset (0x38), 
                    GPRO,   32
                }

                Name (CDC, Package (0x08)
                {
                    0x03F8, 
                    0x02F8, 
                    0x0220, 
                    0x0228, 
                    0x0238, 
                    0x02E8, 
                    0x0338, 
                    0x03E8
                })
                Name (LPD, Package (0x03)
                {
                    0x0378, 
                    0x0278, 
                    0x03BC
                })
                Method (\_SB.PCI0.LPCB.SMAB, 3, Serialized)
                {
                    If (((Arg0 & 0x01) == 0x00))
                    {
                        Local0 = 0x01
                        Local1 = \_SB.PCI0.SBUS.SWRB (Arg0, Arg1, Arg2)
                        If (Local1)
                        {
                            Local0 = 0x00
                        }
                    }
                    Else
                    {
                        Local0 = \_SB.PCI0.SBUS.SRDB (Arg0, Arg1)
                    }

                    Return (Local0)
                }

                Method (DCS, 3, NotSerialized)
                {
                    Local1 = 0x00
                    Local0 = Match (Arg0, MEQ, Arg1, MTR, 0x00, 0x00)
                    If ((Local0 != Ones))
                    {
                        Local1 = (Local0 << Arg2)
                    }

                    Return (Local1)
                }

                Method (DPD, 2, Serialized)
                {
                    If ((Arg0 == 0x00))
                    {
                        FDLE = 0x00
                    }
                    ElseIf ((Arg0 == 0x01))
                    {
                        LLPE = 0x00
                    }
                    ElseIf ((Arg0 == 0x02))
                    {
                        CALE = 0x00
                    }
                    ElseIf ((Arg0 == 0x03))
                    {
                        CBLE = 0x00
                        G2DC &= ~0x01
                    }
                }

                Method (EPD, 3, Serialized)
                {
                    If ((Arg0 == 0x00))
                    {
                        Local0 = 0x00
                        If ((Arg1 == 0x0370))
                        {
                            Local0 = 0x01
                        }

                        FDDC = Local0
                        FDLE = 0x01
                    }
                    ElseIf ((Arg0 == 0x01))
                    {
                        LPDC = DCS (LPD, Arg1, 0x00)
                        LLPE = 0x01
                    }
                    ElseIf ((Arg0 == 0x02))
                    {
                        CMAD = DCS (CDC, Arg1, 0x00)
                        CALE = 0x01
                    }
                    ElseIf ((Arg0 == 0x03))
                    {
                        CMBD = DCS (CDC, Arg1, 0x00)
                        CBLE = 0x01
                        G2MK = 0x0C
                        G2DC = (Arg2 | 0x01)
                    }
                }

                Method (CFG, 5, Serialized)
                {
                    If ((Arg1 == 0x00))
                    {
                        ^DPD (Arg0, Arg2)
                    }
                    Else
                    {
                        ^EPD (Arg0, Arg1, Arg2)
                    }
                }
            }

            Device (ACEL)
            {
                Name (_HID, EisaId ("HPQ0004"))  // _HID: Hardware ID
                Name (DEPT, 0xFF)
                Name (CTST, 0xFF)
                Method (_INI, 0, NotSerialized)  // _INI: Initialize
                {
                    ITAL ()
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000017,
                    }
                })
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((DEPT == 0xFF))
                    {
                        Local0 = 0x0F
                        Local1 = ALRD (0x20)
                        If ((Local1 & 0xFF00))
                        {
                            Local0 = 0x00
                        }

                        DEPT = Local0
                    }

                    Return (DEPT) /* \_SB_.PCI0.ACEL.DEPT */
                }

                Method (ITAL, 0, Serialized)
                {
                    If (_STA ())
                    {
                        ALWR (0x20, 0x5F)
                        ALWR (0x21, 0x22)
                        ALWR (0x32, 0x16)
                        ALWR (0x33, 0x02)
                        ALWR (0x30, 0x95)
                        ALWR (0x36, 0x13)
                        ALWR (0x37, 0x01)
                        ALWR (0x34, 0x0A)
                        CTST = 0xFF
                        AJAL ()
                    }
                }

                Method (AJAL, 0, Serialized)
                {
                    If (_STA ())
                    {
                        Local0 = \_SB.PCI0.LPCB.EC0.GACS ()
                        If (((\_SB.LID._LID () == 0x00) && (Local0 == 0x00)))
                        {
                            If ((CTST != 0x01))
                            {
                                CTST = 0x01
                                ALWR (0x22, 0x60)
                            }
                        }
                        ElseIf ((CTST != 0x00))
                        {
                            CTST = 0x00
                            ALWR (0x22, 0x40)
                        }
                    }
                }

                Method (CLRI, 0, Serialized)
                {
                    Local2 = 0x00
                    If ((\_SB.PCI0.LPCB.EC0.GACS () == 0x00))
                    {
                        Local0 = 0x04
                        Local1 = 0x04
                        If ((\_SB.BAT0._STA () == 0x1F))
                        {
                            Local0 = DerefOf (DerefOf (NBST [0x00]) [0x00])
                        }

                        If ((\_SB.BAT1._STA () == 0x1F))
                        {
                            Local1 = DerefOf (DerefOf (NBST [0x01]) [0x00])
                        }

                        Local0 &= Local1
                        If ((Local0 & 0x04))
                        {
                            Local2 = 0x01
                        }
                    }

                    Return (Local2)
                }

                Method (ALRD, 1, Serialized)
                {
                    Local0 = \_SB.PCI0.LPCB.SMAB (0x33, Arg0, 0x00)
                    Return (Local0)
                }

                Method (ALWR, 2, Serialized)
                {
                    Local0 = \_SB.PCI0.LPCB.SMAB (0x32, Arg0, Arg1)
                    Return (Local0)
                }

                Method (ALID, 1, Serialized)
                {
                    Return (\_SB.LID._LID ())
                }

                Method (ADSN, 0, Serialized)
                {
                    Local0 = HDDS /* \HDDS */
                    Local0 = 0x00
                    Return (Local0)
                }
            }

            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (GPIC)
                {
                    Return (Package (0x1A)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF, 
                            0x00, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            0x00, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x00, 
                            0x00, 
                            0x15
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x01, 
                            0x00, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x02, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x03, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x00, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001AFFFF, 
                            0x00, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001BFFFF, 
                            0x00, 
                            0x00, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x00, 
                            0x00, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x01, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x02, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x03, 
                            0x00, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0019FFFF, 
                            0x00, 
                            0x00, 
                            0x14
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x00, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x01, 
                            0x00, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x02, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x03, 
                            0x00, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x00, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x01, 
                            0x00, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x02, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x03, 
                            0x00, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x00, 
                            0x00, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x01, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x02, 
                            0x00, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x03, 
                            0x00, 
                            0x12
                        }
                    })
                }
                Else
                {
                    Return (Package (0x1A)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF, 
                            0x00, 
                            LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            0x00, 
                            LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0019FFFF, 
                            0x00, 
                            LNKE, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001AFFFF, 
                            0x00, 
                            LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001BFFFF, 
                            0x00, 
                            LNKG, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x00, 
                            LNKB, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x01, 
                            LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x02, 
                            LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x03, 
                            LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x00, 
                            LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x00, 
                            LNKF, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x01, 
                            LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x02, 
                            LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x03, 
                            LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x00, 
                            LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x01, 
                            LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x02, 
                            LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x03, 
                            LNKB, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x00, 
                            LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x01, 
                            LNKB, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x02, 
                            LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x03, 
                            LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x00, 
                            LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x01, 
                            LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x02, 
                            LNKB, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x03, 
                            LNKC, 
                            0x00
                        }
                    })
                }
            }

            Method (PCIB._PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (GPIC)
                {
                    Return (Package (0x06)
                    {
                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x00, 
                            0x00, 
                            0x14
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x01, 
                            0x00, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x02, 
                            0x00, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x03, 
                            0x00, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x04, 
                            0x00, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x05, 
                            0x00, 
                            0x16
                        }
                    })
                }
                Else
                {
                    Return (Package (0x06)
                    {
                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x00, 
                            LNKE, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x01, 
                            LNKG, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x02, 
                            LNKG, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x03, 
                            LNKG, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x04, 
                            LNKG, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x05, 
                            LNKG, 
                            0x00
                        }
                    })
                }
            }

            Field (GPIO, ByteAcc, NoLock, Preserve)
            {
                Offset (0x0C), 
                Offset (0x0C), 
                GLEP,   1
            }

            Scope (RP06)
            {
                Method (_PRW, 0, Serialized)  // _PRW: Power Resources for Wake
                {
                    Local0 = Package (0x02)
                        {
                            0x09, 
                            0x05
                        }
                    If (WOLD)
                    {
                        Local0 [0x01] = 0x00
                    }

                    Return (Local0)
                }

                OperationRegion (NPCI, PCI_Config, 0x19, 0x01)
                Field (NPCI, ByteAcc, NoLock, Preserve)
                {
                    BUSN,   8
                }

                Method (GADD, 0, Serialized)
                {
                    Local0 = BUSN /* \_SB_.PCI0.RP06.BUSN */
                    Local0 <<= 0x14
                    Local1 = (0xE0000000 + Local0)
                    Return (Local1)
                }

                Device (NIC)
                {
                    Name (_ADR, 0x00)  // _ADR: Address
                    Method (_PRW, 0, Serialized)  // _PRW: Power Resources for Wake
                    {
                        Return (^^_PRW ())
                    }

                    Method (EJ0, 0, NotSerialized)
                    {
                        Sleep (0x0A)
                        GLEP = 0x00
                    }

                    Method (LPON, 0, NotSerialized)
                    {
                        Local1 = CondRefOf (\_GPE._L1C, Local0)
                        Return (Local1)
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    OperationRegion (PCIR, PCI_Config, 0x0C, 0x01)
                    Field (PCIR, AnyAcc, NoLock, Preserve)
                    {
                        CLSZ,   8
                    }
                }
            }

            Scope (\_GPE)
            {
                Name (CBID, 0x00)
                Method (L1C, 0, NotSerialized)
                {
                    Sleep (0x64)
                    If ((CBID == 0x01))
                    {
                        HNLP (0x1000)
                        Local0 = GIV /* \GIV_ */
                        GIV = (Local0 ^ 0x1000)
                        CBID = 0x00
                    }
                    Else
                    {
                        CBID++
                    }
                }

                Method (HNLP, 1, Serialized)
                {
                    If (\_SB.PCI0.RP06.NIC.LPON ())
                    {
                        If (NNST ())
                        {
                            INIC ()
                        }
                        ElseIf (\_SB.PCI0.GLEP)
                        {
                            If (ILUX)
                            {
                                Notify (\_SB.PCI0.RP06.NIC, 0x03) // Eject Request
                            }
                            Else
                            {
                                \_SB.PCI0.RP06.NIC.EJ0 ()
                            }
                        }

                        Sleep (0x64)
                        Notify (\_SB.PCI0.RP06, 0x00) // Bus Check
                    }
                }

                Method (NNST, 0, Serialized)
                {
                    Local1 = GPL0 /* \GPL0 */
                    Local3 = 0x01
                    If ((Local1 & 0x2000))
                    {
                        If ((\_SB.PCI0.LPCB.EC0.GACS () == 0x00))
                        {
                            If ((Local1 & 0x1000))
                            {
                                Local3 = 0x00
                            }
                        }
                    }

                    Return (Local3)
                }

                Method (INIC, 0, Serialized)
                {
                    OperationRegion (NPC2, SystemMemory, \_SB.PCI0.RP06.GADD (), 0x02)
                    Field (NPC2, AnyAcc, NoLock, Preserve)
                    {
                        VEID,   16
                    }

                    Local1 = 0x0B
                    Local3 = 0x01
                    If (\_SB.PCI0.GLEP)
                    {
                        If ((VEID == 0x11AB))
                        {
                            Local1 = 0x00
                            Local3 = 0x00
                        }
                    }

                    Local2 = \_SB.PCI0.RP06.HPCE
                    While (((Local1 > 0x00) && NNST ()))
                    {
                        \_SB.PCI0.GLEP = 0x01
                        Sleep (0x012C)
                        Local0 = VEID /* \_GPE.INIC.VEID */
                        If (((Local0 == 0x11AB) || (Local1 == 0x01)))
                        {
                            Local1 = 0x00
                        }
                        Else
                        {
                            \_SB.PCI0.GLEP = 0x00
                            Sleep (0xC8)
                            Local1--
                        }
                    }

                    \_SB.PCI0.RP06.HPCE = Local2
                    If (Local3)
                    {
                        \_SB.SSMI (0xEA3E, 0x00, 0x00, 0x00, 0x00)
                    }

                    If ((\WCOS () == 0x03))
                    {
                        \_SB.PCI0.RP06.NIC.CLSZ = 0x10
                    }
                }
            }
        }

        Name (NBTI, Package (0x02)
        {
            Package (0x0D)
            {
                0x01, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x01, 
                0xFFFFFFFF, 
                0x00, 
                0x00, 
                0x64, 
                0x64, 
                "Primary", 
                "100000", 
                "LIon", 
                "Hewlett-Packard"
            }, 

            Package (0x0D)
            {
                0x01, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x01, 
                0xFFFFFFFF, 
                0x00, 
                0x00, 
                0x64, 
                0x64, 
                "Travel", 
                "100000", 
                "LIon", 
                "Hewlett-Packard"
            }
        })
        Name (NBST, Package (0x02)
        {
            Package (0x04)
            {
                0x00, 
                0x00, 
                0x0FA0, 
                0x04B0
            }, 

            Package (0x04)
            {
                0x00, 
                0x00, 
                0x0FA0, 
                0x04B0
            }
        })
        Name (NDBS, Package (0x04)
        {
            0x00, 
            0x00, 
            0x0FA0, 
            0x04B0
        })
        Name (ACST, 0x01)
        Name (SMAR, 0x00)
        Name (BT0P, 0x0F)
        Method (BTIF, 1, Serialized)
        {
            Local0 = \_SB.PCI0.LPCB.EC0.BTIF (Arg0)
            If ((Local0 == 0xFF))
            {
                Return (Package (0x0D)
                {
                    0x00, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF, 
                    0x01, 
                    0xFFFFFFFF, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    "", 
                    "", 
                    "", 
                    0x00
                })
            }
            Else
            {
                Return (DerefOf (NBTI [Arg0]))
            }
        }

        Name (NFBS, 0x01)
        Method (BTST, 1, Serialized)
        {
            Local1 = NFBS /* \_SB_.NFBS */
            If (NFBS)
            {
                NFBS = 0x00
            }

            Local0 = \_SB.PCI0.LPCB.EC0.BTST (Arg0, Local1)
            Return (DerefOf (NBST [Arg0]))
        }

        Device (BAT0)
        {
            Name (_HID, EisaId ("PNP0C0A") /* Control Method Battery */)  // _HID: Hardware ID
            Name (_UID, 0x01)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = \_SB.PCI0.LPCB.EC0.BSTA (0x01)
                If ((BT0P ^ Local0))
                {
                    BT0P = Local0
                    Local1 = Local0
                    If ((Local1 != 0x1F))
                    {
                        Local1 = 0x00
                    }

                    \_SB.SSMI (0xEA3A, 0x00, Local1, 0x00, 0x00)
                    Local1 = ECX /* \ECX_ */
                    \_GPE.HWWP (0x01)
                    If ((FCIN == 0x00))
                    {
                        \_SB.PCI0.LPCB.EC0.HWWP (Local1)
                    }

                    \_SB.WMID.WGWE (0x05, 0x00)
                }

                Return (Local0)
            }

            Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
            {
                Return (BTIF (0x00))
            }

            Method (_BST, 0, NotSerialized)  // _BST: Battery Status
            {
                Return (BTST (0x00))
            }

            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                \_SB
            })
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A") /* Control Method Battery */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x00)
            }

            Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
            {
                Return (BTIF (0x01))
            }

            Method (_BST, 0, NotSerialized)  // _BST: Battery Status
            {
                Return (BTST (0x01))
            }

            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                \_SB
            })
        }

        Device (AC)
        {
            Name (_HID, "ACPI0003" /* Power Source Device */)  // _HID: Hardware ID
            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                \_SB
            })
            Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
            {
                Local0 = \_SB.PCI0.LPCB.EC0.GACS ()
                PWRS = Local0
                Local1 = \_SB.PCI0.LPCB.EC0.GPID ()
                If ((Local0 ^ ACST))
                {
                    \_GPE.HNLP (0x00)
                    \_SB.PCI0.ACEL.AJAL ()
                    \_GPE.VPUP (Local0, Local1)
                    \_SB.PCI0.LPCB.EC0.SMCP (Local0)
                }

                If (((Local0 && !ACST) || (Local1 && !SMAR)))
                {
                    \_SB.WMID.WGWE (0x03, 0x00)
                }

                ACST = Local0
                SMAR = Local1
                Return (Local0)
            }
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E") /* Sleep Button Device */)  // _HID: Hardware ID
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D") /* Lid Device */)  // _HID: Hardware ID
            Method (_LID, 0, NotSerialized)  // _LID: Lid Status
            {
                Local0 = \_SB.PCI0.LPCB.EC0.CLID
                Return (Local0)
            }
        }

        Device (HST1)
        {
            Name (_HID, EisaId ("PNP0C32"))  // _HID: Hardware ID
            Name (_UID, 0x01)  // _UID: Unique ID
            Name (HS1S, 0xFF)
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If ((HS1S == 0xFF))
                {
                    Local0 = 0x00
                    If ((\WCOS () >= 0x06))
                    {
                        If (ISUD ())
                        {
                            Local0 = 0x0F
                        }
                    }

                    HS1S = Local0
                }

                Return (HS1S) /* \_SB_.HST1.HS1S */
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x0A, 
                0x05
            })
            Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
            {
                \_SB.PCI0.LPCB.EC0.HSPW (Arg0, 0x01)
            }

            Method (GHID, 0, Serialized)
            {
                If (_STA ())
                {
                    If (\_SB.PCI0.LPCB.EC0.CHSW (0x01))
                    {
                        Notify (\_SB.HST1, 0x02) // Device Wake
                    }
                }

                Return (Buffer (0x01)
                {
                     0x01                                             // .
                })
            }
        }

        Name (WSIP, Buffer (0x09)
        {
            /* 0000 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0008 */  0xFF                                             // .
        })
        Name (SUIP, Buffer (0x03)
        {
             0xFF, 0xFF, 0xFF                                 // ...
        })
        Name (BSOL, Package (0x02)
        {
            Package (0x1D)
            {
                "Legacy Boot Order", 
                " Notebook Upgrade Bay, Notebook Hard Drive, USB Floppy, USB CD-ROM, USB Hard Drive, Notebook Ethernet, SD Card, Dock Upgrade Bay, eSATA Drive, , , , , , , ,", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0x0104, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x09, 
                " Notebook Upgrade Bay ", 
                " Notebook Hard Drive ", 
                " USB Floppy ", 
                " USB CD-ROM ", 
                " USB Hard Drive ", 
                " Notebook Ethernet ", 
                " SD Card ", 
                " Dock Upgrade Bay", 
                " eSATA Drive", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1D)
            {
                "UEFI Boot Order", 
                " Notebook Upgrade Bay (UEFI), OS Boot Manager, Notebook Ethernet (UEFI), , , , , , , , , , , , , ,", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0x0143, 
                0x03, 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'UEFI Boot Mode\' AND CurrentValue=\'Enable\'", 
                " ", 
                " ", 
                0x00, 
                0x03, 
                " Notebook Upgrade Bay (UEFI)", 
                " OS Boot Manager", 
                " Notebook Ethernet (UEFI)", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }
        })
        Name (RMBI, Package (0x09)
        {
            Package (0x02)
            {
                0x01, 
                " Notebook Upgrade Bay "
            }, 

            Package (0x02)
            {
                0x02, 
                " Notebook Hard Drive "
            }, 

            Package (0x02)
            {
                0x03, 
                " USB Floppy "
            }, 

            Package (0x02)
            {
                0x05, 
                " USB CD-ROM "
            }, 

            Package (0x02)
            {
                0x06, 
                " USB Hard Drive "
            }, 

            Package (0x02)
            {
                0x07, 
                " Notebook Ethernet "
            }, 

            Package (0x02)
            {
                0x08, 
                " SD Card "
            }, 

            Package (0x02)
            {
                0x0A, 
                " Dock Upgrade Bay "
            }, 

            Package (0x02)
            {
                0x0B, 
                " eSATA Drive "
            }
        })
        Name (UEBL, Package (0x03)
        {
            Package (0x02)
            {
                0x01, 
                " Notebook Upgrade Bay (UEFI)"
            }, 

            Package (0x02)
            {
                0x02, 
                " OS Boot Manager"
            }, 

            Package (0x02)
            {
                0x03, 
                " Notebook Ethernet (UEFI)"
            }
        })
        Name (CRBI, Package (0x09)
        {
            " Boot Device 1", 
            " Boot Device 2", 
            " Boot Device 3", 
            " Boot Device 5", 
            " Boot Device 6", 
            " Boot Device 7", 
            " Boot Device 8", 
            " Boot Device 10", 
            " Boot Device 11"
        })
        Name (CUBO, Package (0x03)
        {
            " UEFI Boot Device 1", 
            " UEFI Boot Device 2", 
            " UEFI Boot Device 3"
        })
        Name (FLAG, Buffer (0x01)
        {
             0x05                                             // .
        })
        Name (PCHG, Buffer (0x01)
        {
             0x00                                             // .
        })
        Name (WTB1, Buffer (0xCE){})
        Name (DVAL, Buffer (0x01)
        {
             0x00                                             // .
        })
        Name (VFSZ, Buffer (0x01)
        {
             0x00                                             // .
        })
        Name (PCBF, Buffer (0x0190){})
        Name (WSPS, Buffer (0x3F){})
        Name (WNWP, Buffer (0x3F){})
        Name (WPPS, Buffer (0x3F){})
        Name (WNPP, Buffer (0x3F){})
        Name (WTB2, Buffer (0xC8){})
        Name (BUFU, Buffer (0x21){})
        Name (WTB3, Buffer (0x12){})
        Name (WTB4, Buffer (0x28){})
        Name (WBOR, Buffer (0x09){})
        Name (BOID, Buffer (0x64)
        {
            /* 0000 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0008 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0018 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0020 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0028 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0030 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0038 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0040 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0048 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0050 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0058 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
            /* 0060 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
        })
        Name (TEMP, Buffer (0x32){})
        Name (ST01, Buffer (0x64){})
        Name (STG0, Buffer (0x1E){})
        Name (STG1, Buffer (0x1E){})
        Name (ST02, Buffer (0xA2){})
        Name (WATS, Buffer (0x12){})
        Name (WONT, Buffer (0x50){})
        Name (ST03, Buffer (0x32){})
        Name (ST14, Buffer (0x32){})
        Name (BF01, Buffer (0x32){})
        Name (BF02, Buffer (0x32){})
        Name (BVAL, Buffer (0x0190){})
        Name (BF03, Buffer (0x96){})
        Name (TM01, Buffer (0x32){})
        Name (TM02, Buffer (0x1E){})
        Name (TM03, Buffer (0x1E){})
        Name (ST04, "serial port")
        Name (ST05, "infrared port")
        Name (ST10, "Parallel Port")
        Name (ST15, "My asset tag")
        Name (ST06, "Enable")
        Name (ST07, "Disable")
        Name (ST08, " Disable, *Enable")
        Name (ST09, "*Disable,  Enable")
        Name (PXEN, " *PXE, RPL")
        Name (RPEN, " PXE, *RPL")
        Name (PXE, "PXE")
        Name (RPL, "RPL")
        Name (ST11, Buffer (0x96){})
        Name (VSTR, "*View, Change, Hide")
        Name (VIEW, "View")
        Name (CSTR, " View, *Change, Hide")
        Name (CHGE, "Change")
        Name (HSTR, " View, Change, *Hide")
        Name (HIDE, "Hide")
        Name (SALL, Package (0x04)
        {
            "Default", 
            "View", 
            "Change", 
            "Hide"
        })
        Name (DALL, "*Default, View, Change, Hide")
        Name (DFLT, "Default")
        Name (VALL, " Default, *View, Change, Hide")
        Name (CALL, " Default, View, *Change, Hide")
        Name (HALL, " Default, View, Change, *Hide")
        Name (ONST, " *On, Off")
        Name (OFST, "  On, *Off")
        Name (ONON, "On")
        Name (OFOF, "Off")
        Name (ULST, " *Unlock, Lock")
        Name (LKST, "  Unlock, *Lock")
        Name (UNLK, "Unlock")
        Name (LLCK, "Lock")
        Name (TPMA, "*Available,  Hidden")
        Name (TPMH, " Available, *Hidden")
        Name (HID, "Hidden")
        Name (AVA, "Available")
        Name (NOIN, "Information Not Available")
        Name (SETA, "*ANSI,  VT100")
        Name (SETV, " ANSI, *VT100")
        Name (ANSI, "ANSI")
        Name (V100, "VT100")
        Name (YESN, " *Yes,  No")
        Name (YESY, "Yes")
        Name (NYES, " *No,  Yes")
        Name (NONO, "No")
        Name (LSG1, "*Generation 1, Generation 2")
        Name (LSG2, "Generation 1, *Generation 2")
        Name (GEN1, "Generation 1")
        Name (GEN2, "Generation 2")
        Name (DPRE, "*Enabled, Disabled")
        Name (DPRD, "Enabled, *Disabled")
        Name (ENAD, "Enabled")
        Name (DISD, "Disabled")
        Name (SSG2, "*3.0 Gbps, 6.0 Gbps")
        Name (SSG3, "3.0 Gbps, *6.0 Gbps")
        Name (SGN2, "3.0 Gbps")
        Name (SGN3, "6.0 Gbps")
        Name (BF2S, "                                                                                                                                                            ")
        Name (BB2S, "                                                                                                                                                                                           ")
        Name (BOIN, Buffer (0x1000){})
        Name (WLNF, Buffer (0xA2){})
        Name (TATM, Buffer (0x05){})
        Name (TPCD, Buffer (0x40){})
        Name (TURL, Buffer (0x82){})
        Name (TBUF, Buffer (0x22){})
        Name (TSKU, Buffer (0x10){})
        Name (TBCT, Buffer (0x0F){})
        Name (TROS, Package (0x1C)
        {
            "Manufacturer", 
            "Processor Type", 
            "Processor Speed", 
            "Total Memory Size", 
            "BIOS Date", 
            "BIOS Version", 
            "Video BIOS Revision", 
            "Keyboard Controller Version", 
            "Hard Disk Serial Number", 
            "Hard Disk Make and Model", 
            "Completion Date", 
            "Completion Status", 
            "Write Cycles Completed", 
            "Warranty Start Date", 
            "System Board ID", 
            "Primary Battery Serial Number", 
            "Secondary Battery Serial Number", 
            "Bluetooth FCC ID", 
            "WLAN FCC ID", 
            "WWAN FCC ID", 
            "GPS FCC ID", 
            "MicroCode Revision", 
            "Universal Unique Identifier(UUID)", 
            "System Configuration ID", 
            "Memory Slot 1 Information", 
            "Memory Slot 2 Information", 
            "Memory Slot 3 Information", 
            "Memory Slot 4 Information"
        })
        Name (MPMS, Package (0x05)
        {
            "PCID", 
            "Notebook Model", 
            "Serial Number", 
            "Product Number", 
            "System Board CT"
        })
        Name (MPMI, Buffer (0x01)
        {
             0x01                                             // .
        })
        Name (BISE, Package (0xCE)
        {
            Package (0x1A)
            {
                "Serial port", 
                " Disable, *Enable", 
                "\\System Configuration\\Port Options", 
                0x00, 
                0x01, 
                0x00, 
                0x64, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Parallel port", 
                " Disable, *Enable", 
                "\\System Configuration\\Port Options", 
                0x00, 
                0x01, 
                0x00, 
                0x67, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "CD-ROM boot", 
                " Disable, *Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0xDC, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Floppy boot", 
                " Disable, *Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0xE6, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "USB legacy support", 
                " Disable, *Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x012D, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "PXE Internal NIC boot", 
                " Disable, *Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0xF0, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Fn Key switch", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x01, 
                0x00, 
                0x00, 
                0x012C, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Fan Always on while on AC Power", 
                " Disable, *Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0130, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Flash media reader", 
                " Disable, *Enable", 
                "\\System Configuration\\Port Options", 
                0x00, 
                0x01, 
                0x00, 
                0x68, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Startup Menu Delay (Sec.)", 
                " *0, 5, 10, 15, 20, 25, 30, 35", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0xC8, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "0", 
                0x0C, 
                "0", 
                "5", 
                "10", 
                "15", 
                "20", 
                "25", 
                "30", 
                "35", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Parallel port mode", 
                " *EPP ,  Bidirectional,  Standard,  ECP", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x012E, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "EPP", 
                0x0C, 
                "EPP", 
                "Bidirectional", 
                "Standard", 
                "ECP", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Multiboot Express Popup Delay(Sec)", 
                " *0, 5, 10, 15, 20, 25, 30, 35", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0xD7, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "0", 
                0x0C, 
                "0", 
                "5", 
                "10", 
                "15", 
                "20", 
                "25", 
                "30", 
                "35", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "LAN/WLAN Switching", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x0208, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded Bluetooth Device", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x01FE, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded WLAN Device", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x01F5, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded WWAN Device", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x01F4, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "LAN Power Saving", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x01, 
                0x00, 
                0x00, 
                0x0133, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Power-On Authentication Support", 
                " Disable, *Enable", 
                "\\Security\\TPM Embedded Security", 
                0x00, 
                0x01, 
                0x00, 
                0x028A, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Embedded Security Device Availability\' AND CurrentValue=\'Available\'", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Data Execution Prevention", 
                " Disable, *Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0132, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "SATA Device Mode", 
                " IDE, *AHCI", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0134, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "AHCI", 
                0x0C, 
                "IDE", 
                "AHCI", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "USB Port", 
                " Disable, *Enable", 
                "\\System Configuration\\Port Options", 
                0x00, 
                0x01, 
                0x00, 
                0x69, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "1394 Port", 
                " *Disable, Enable", 
                "\\System Configuration\\Port Options", 
                0x01, 
                0x00, 
                0x00, 
                0x6A, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Express Card Slot", 
                " Disable, *Enable", 
                "\\System Configuration\\Port Options", 
                0x00, 
                0x01, 
                0x00, 
                0x6B, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Multi Core CPU", 
                " Disable, *Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0135, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Wake on LAN", 
                " Disable, *Boot to Network, Follow Boot Order", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x021C, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Boot to Network", 
                0x0C, 
                "Disable", 
                "Boot to Network", 
                "Follow Boot Order", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Ambient Light Sensor", 
                " *Disable, Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x01, 
                0x00, 
                0x00, 
                0x01F9, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Secondary Battery Fast Charge", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x01, 
                0x00, 
                0x00, 
                0x0136, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded Security Device Availability", 
                "*Available, Hidden", 
                "\\Security\\TPM Embedded Security", 
                0x00, 
                0x01, 
                0x00, 
                0x0288, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Available", 
                0x0C, 
                "Available", 
                "Hidden", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Activate Embedded Security On Next Boot", 
                " Disable, *Enable", 
                "\\Security\\TPM Embedded Security", 
                0x00, 
                0x01, 
                0x00, 
                0x0287, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Embedded Security Device Availability\' AND CurrentValue=\'Available\'", 
                " ", 
                0x01, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded Security Activation Policy", 
                " *F1 to Boot, Allow user to reject, No prompts", 
                "\\Security\\TPM Embedded Security", 
                0x00, 
                0x00, 
                0x00, 
                0x0289, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Embedded Security Device Availability\' AND CurrentValue=\'Available\'", 
                " ", 
                0x03, 
                "F1 to Boot", 
                0x0C, 
                "F1 to Boot", 
                "Allow user to reject", 
                "No prompts", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Fingerprint Device", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x01F6, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Notebook Upgrade Bay", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x01F7, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Network Interface Controller (LAN)", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x01F8, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "OS Management of TPM", 
                " Disable, *Enable", 
                "\\Security\\TPM Embedded Security", 
                0x00, 
                0x01, 
                0x00, 
                0x0286, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Embedded Security Device Availability\' AND CurrentValue=\'Available\'", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Reset of TPM from OS", 
                " Disable, *Enable", 
                "\\Security\\TPM Embedded Security", 
                0x00, 
                0x01, 
                0x00, 
                0x0285, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'OS Management of TPM\' AND CurrentValue=\'Enable\'", 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Embedded Security Device Availability\' AND CurrentValue=\'Available\'", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Virtualization Technology", 
                " Disable, *Enable, Reset to default", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x013D, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                "Reset to default", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Terminal Emulation Mode", 
                " ANSI, *VT100", 
                "\\System Configuration\\AMT Options", 
                0x01, 
                0x00, 
                0x00, 
                0x02BD, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "ANSI", 
                0x0C, 
                "ANSI", 
                "VT100", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Firmware Verbosity", 
                " *Disable, Enable", 
                "\\System Configuration\\AMT Options", 
                0x01, 
                0x00, 
                0x00, 
                0x02BD, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Firmware Progress Event Support", 
                " *Disable, Enable", 
                "\\System Configuration\\AMT Options", 
                0x01, 
                0x00, 
                0x00, 
                0x02C2, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Unconfigure AMT on next boot", 
                " *Disable, Enable", 
                "\\System Configuration\\AMT Options", 
                0x01, 
                0x00, 
                0x00, 
                0x02C0, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Integrated Camera", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x01FA, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Custom Logo", 
                " Disable, *Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0xC9, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "SD Card boot", 
                " Disable, *Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0xE1, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "HP QuickLook", 
                " Disable, *Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0137, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Wireless Button State", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x01F3, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Modem Device", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x01FF, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "At least one symbol required", 
                " Yes, *No", 
                "\\Security\\Administrator Tools\\Password Policy", 
                0x00, 
                0x01, 
                0x00, 
                0x0296, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "No", 
                0x0C, 
                "Yes", 
                "No", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "At least one number required", 
                " Yes, *No", 
                "\\Security\\Administrator Tools\\Password Policy", 
                0x00, 
                0x01, 
                0x00, 
                0x0297, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "No", 
                0x0C, 
                "Yes", 
                "No", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "At least one upper case character required", 
                "  Yes, *No", 
                "\\Security\\Administrator Tools\\Password Policy", 
                0x00, 
                0x01, 
                0x00, 
                0x0298, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "No", 
                0x0C, 
                "Yes", 
                "No", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "At least one lower case character required", 
                "  Yes, *No", 
                "\\Security\\Administrator Tools\\Password Policy", 
                0x00, 
                0x01, 
                0x00, 
                0x0299, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "No", 
                0x0C, 
                "Yes", 
                "No", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Are spaces allowed in password", 
                "  Yes, *No", 
                "\\Security\\Administrator Tools\\Password Policy", 
                0x00, 
                0x01, 
                0x00, 
                0x029B, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "No", 
                0x0C, 
                "Yes", 
                "No", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Fingerprint Reset on Reboot (If Present)", 
                " *Disable, Enable", 
                "\\Security\\Administrator Tools", 
                0x00, 
                0x01, 
                0x00, 
                0x029D, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "HP SpareKey", 
                " Disable, *Enable", 
                "\\Security\\Administrator Tools", 
                0x00, 
                0x01, 
                0x00, 
                0x029A, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "TXT Technology", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x01, 
                0x00, 
                0x00, 
                0x013A, 
                0x03, 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Embedded Security Device Availability\' AND CurrentValue=\'Available\'", 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Virtualization Technology\' AND CurrentValue=\'Enable\'", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Display Diagnostic URL", 
                " Disable, *Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0x0105, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Smart Card", 
                " Disable, *Enable", 
                "\\System Configuration\\Port Options", 
                0x00, 
                0x01, 
                0x00, 
                0x6C, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Always Prompt for HP SpareKey Enrollment", 
                " Disable, *Enable", 
                "\\Security\\Administrator Tools", 
                0x00, 
                0x01, 
                0x00, 
                0x029E, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'HP SpareKey\' AND CurrentValue=\'Enable\' ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "USB Key Provisioning Support", 
                " *Disable, Enable", 
                "\\System Configuration\\AMT Options", 
                0x01, 
                0x00, 
                0x00, 
                0x02C1, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "AMT Setup Prompt(Ctrl-P)", 
                " *Disable, Enable", 
                "\\System Configuration\\AMT Options", 
                0x01, 
                0x00, 
                0x00, 
                0x02C3, 
                0x03, 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Firmware Verbosity\' AND CurrentValue=\'Enable\'", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Bypass Power-on password on restart", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x00, 
                0x00, 
                0x02C4, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Microphone", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x0200, 
                0x03, 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Audio Device\' AND CurrentValue=\'Enable\'", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Language", 
                " *English, Francais, Deutsch, Espanol, Italiano, Dansk, Nederlands, Suomi, Japanese, Norsk, Portugues, Svenska", 
                "\\System Configuration", 
                0x00, 
                0x01, 
                0x00, 
                0x79, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "English", 
                0x0C, 
                "English", 
                "Francais", 
                "Deutsch", 
                "Espanol", 
                "Italiano", 
                "Dansk", 
                "Nederlands", 
                "Suomi", 
                "Japanese", 
                "Norsk", 
                "Portugues", 
                "Svenska"
            }, 

            Package (0x1A)
            {
                "NumLock on at boot", 
                " On, *Off", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x013B, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Off", 
                0x0C, 
                "On", 
                "Off", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Preboot authentication on HP QuickLook Boot", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0138, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "HP QuickWeb", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x013C, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "HP QuickWeb: Write Protect", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x013D, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Initiate Intel CIRA", 
                " *Disable, Enable", 
                "\\System Configuration\\AMT Options", 
                0x01, 
                0x00, 
                0x00, 
                0x02C5, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Intel (R) Anti-Theft", 
                " Disable, *Enable", 
                "\\Security\\Anti Theft", 
                0x00, 
                0x01, 
                0x00, 
                0x029C, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Power Monitor Circuit", 
                " Disable, *Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x013E, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Reset Authentication Credential", 
                " Yes, *No", 
                "\\Security\\TPM Embedded Security", 
                0x00, 
                0x01, 
                0x00, 
                0x028B, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "No", 
                0x0C, 
                "Yes", 
                "No", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Speakers and Headphones", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x0208, 
                0x03, 
                "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Audio Device\' AND CurrentValue=\'Enable\'", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Audio Device", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x0209, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Ctrl I Prompt", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x01, 
                0x00, 
                0x00, 
                0x013F, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "eSATA", 
                " Disable, *Enable", 
                "\\System Configuration\\Port Options", 
                0x00, 
                0x01, 
                0x00, 
                0x71, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Wake on USB", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0140, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Intel (R) HT Technology", 
                " Disable, *Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0141, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "UEFI Boot Mode", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0142, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "HP DayStarter", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0143, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Backlit Keyboard Timeout", 
                " 5 secs., *15 secs., 30 secs., 1 min., 5 mins., Never", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0xDD, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "15 secs.", 
                0x0C, 
                "5 secs.", 
                "15 secs.", 
                "30 secs.", 
                "1 min.", 
                "5 mins.", 
                "Never", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Sunday", 
                " *Disable, Enable", 
                "\\System Configuration\\BIOS Power-on", 
                0x00, 
                0x01, 
                0x00, 
                0x32, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Monday", 
                " *Disable, Enable", 
                "\\System Configuration\\BIOS Power-on", 
                0x00, 
                0x01, 
                0x00, 
                0x33, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Tuesday", 
                " *Disable, Enable", 
                "\\System Configuration\\BIOS Power-on", 
                0x00, 
                0x01, 
                0x00, 
                0x34, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Wednesday", 
                " *Disable, Enable", 
                "\\System Configuration\\BIOS Power-on", 
                0x00, 
                0x01, 
                0x00, 
                0x35, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Thursday", 
                " *Disable, Enable", 
                "\\System Configuration\\BIOS Power-on", 
                0x00, 
                0x01, 
                0x00, 
                0x36, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Friday", 
                " *Disable, Enable", 
                "\\System Configuration\\BIOS Power-on", 
                0x00, 
                0x01, 
                0x00, 
                0x37, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Saturday", 
                " *Disable, Enable", 
                "\\System Configuration\\BIOS Power-on", 
                0x00, 
                0x01, 
                0x00, 
                0x38, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "USB device boot", 
                " Disable, *Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0x013E, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Upgrade Bay Hard Drive boot", 
                " Disable, *Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0x013F, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Audio alerts during boot", 
                " Disable, *Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0x0144, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Fast Boot", 
                " Disable, *Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0xDC, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "DriveLock password on restart", 
                " Disabled, *Enabled", 
                "\\Security", 
                0x00, 
                0x01, 
                0x00, 
                0x028F, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enabled", 
                0x0C, 
                "Disabled", 
                "Enabled", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Virtualization Technology for Directed I/O", 
                " Disable, *Enable, Reset to default", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0xDE, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                "Reset to default", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Custom Help and URL message", 
                " *Disable, Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0x0146, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "USB Charging Port", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0147, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Disable charging port in all sleep/off states below(%):", 
                " *10, 20, 30, 40, 50, 60, 70, 80, 90, 100", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x018F, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "10", 
                0x0C, 
                "10", 
                "20", 
                "30", 
                "40", 
                "50", 
                "60", 
                "70", 
                "80", 
                "90", 
                "100", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "System Management Command", 
                " *Disable, Enable", 
                "\\Security", 
                0x00, 
                0x01, 
                0x00, 
                0x0147, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "CFAST", 
                " *Disable, Enable", 
                "\\System Configuration\\Port Options", 
                0x01, 
                0x00, 
                0x00, 
                0x70, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Manufacturing Programming Mode", 
                " *Unlock, Lock", 
                "\\Place holder for Path", 
                0x00, 
                0x01, 
                0x00, 
                0x0377, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Unlock", 
                0x0C, 
                "Lock", 
                "Unlock", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "eSATA boot", 
                " Disable, *Enable", 
                "\\System Configuration\\Boot Options", 
                0x00, 
                0x01, 
                0x00, 
                0x0149, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Enable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Express Card Link Speed", 
                " *Generation 1, Generation 2", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x014A, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Generation 1", 
                0x0C, 
                "Generation 1", 
                "Generation 2", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "TPM Reset to Factory Defaults", 
                " Yes, *No", 
                "\\Security\\TPM Embedded Security", 
                0x00, 
                0x01, 
                0x00, 
                0x014C, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "No", 
                0x0C, 
                "Yes", 
                "No", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded GPS Device", 
                " Disable, *Enable", 
                "\\System Configuration\\Built-In Device Options", 
                0x00, 
                0x01, 
                0x00, 
                0x020A, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Switchable Graphics", 
                " Disable, *Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x020B, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Restore Defaults", 
                " *No, Yes", 
                "\\File", 
                0x00, 
                0x01, 
                0x00, 
                0x020C, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "No", 
                0x0C, 
                "No", 
                "Yes", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Reset BIOS security to factory default", 
                " *No, Yes", 
                "\\File", 
                0x00, 
                0x01, 
                0x00, 
                0x020D, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "No", 
                0x0C, 
                "No", 
                "Yes", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Power Control", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x020E, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Power-On when AC is detected", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x020F, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Require acknowledgment of battery errors", 
                " *Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x01, 
                0x00, 
                0x0211, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                " ", 
                " ", 
                " ", 
                0x01, 
                0x00, 
                0x01, 
                0x02CA, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                " ", 
                0x0C, 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Bypass Power-on password on ALL restarts", 
                "*Disable, Enable", 
                "\\System Configuration\\Device Configurations", 
                0x00, 
                0x00, 
                0x00, 
                0x02D8, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Disable", 
                0x0C, 
                "Disable", 
                "Enable", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Serial port Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0320, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Parallel port Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0322, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "CD-ROM boot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0323, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Floppy boot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0324, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "PXE Internal NIC boot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0325, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Fn Key Switch Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x0326, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "USB legacy support Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0327, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Fan Always on while on AC Power Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0328, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Flash media reader Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0329, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Startup Menu Delay (Sec.) Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x032A, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Parallel port mode Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x032B, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Multiboot Express Popup Delay(Sec) Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x032C, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "LAN/WLAN Switching Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x032E, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded Bluetooth Device Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x032F, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded WLAN Device Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0330, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded WWAN Device Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0331, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "LAN Power Saving Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x0332, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Hide", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Power-On Authentication Support Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0333, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Data Execution Prevention Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0336, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "SATA Device Mode Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0337, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "USB Port Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0338, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "1394 Port Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x0339, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Hide", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Express Card Slot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x033B, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Multi Core CPU Security Level", 
                " Change, *View, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x033C, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Wake on LAN Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x033D, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Ambient Light Sensor Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x033E, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Hide", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Secondary Battery Fast Charge Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x033F, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Hide", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded Security Device Availability Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0340, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Activate Embedded Security On Next Boot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x00, 
                0x00, 
                0x0341, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded Security Activation Policy Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x00, 
                0x00, 
                0x0342, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Fingerprint Device Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0346, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Notebook Upgrade Bay Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0347, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Network Interface Controller (LAN) Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0348, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "OS Management of TPM Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0349, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Reset of TPM from OS Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x034A, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Virtualization Technology Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x034B, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Terminal Emulation Mode Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x0350, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Hide", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Firmware Verbosity Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x034C, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Hide", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Firmware Progress Event Support Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x0351, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Hide", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Unconfigure AMT on next boot Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x034F, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Hide", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Integrated Camera Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0352, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Notebook Asset Tag Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0353, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Notebook Ownership Tag Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0354, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Legacy Boot Order Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0355, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Custom Logo Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0356, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "SD Card boot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0357, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "HP QuickLook Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0358, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Wireless Button State Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0359, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Modem Device Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x035A, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Finger Print reset Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x035B, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "HP SpareKey Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x035C, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "TXT Technology Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x035D, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Hide", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Display Diagnostic URL Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x035E, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Smart Card Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x035F, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Hide", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "USB Key Provisioning Support Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x034E, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "AMT Setup Prompt(Ctrl-P) Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x035E, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Microphone Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0360, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Disk Sanitizer Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0361, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "UEFI Boot Mode Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0362, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "NumLock on at boot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0361, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Preboot authentication on HP QuickLook Boot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0362, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "HP QuickWeb Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0363, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Initiate Intel CIRA Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x0365, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Intel (R) Anti-Theft Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0366, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Power Monitor Circuit Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0367, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Speakers and Headphones Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0368, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Audio Device Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0369, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "eSATA Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x036A, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Wake on USB Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x036B, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Intel (R) HT Technology Security Level", 
                " Change, *View, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x036C, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "UEFI Boot Order Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x036C, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Set DriveLock Password Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x036D, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                " ", 
                " ", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x036D, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                " ", 
                0x0C, 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Backlit Keyboard Timeout Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x036E, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "HP DayStarter Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x036F, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "BIOS Power-on Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0370, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "USB device boot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0372, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Upgrade Bay Hard Drive boot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0373, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Fast Boot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x036F, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "DriveLock password on restart Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0370, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Virtualization Technology for Directed I/O Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0xDF, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Set All Security Levels", 
                " *Default, View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0371, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "Default", 
                0x0C, 
                "Default", 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Custom Help and URL message Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0372, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "USB Charging Port Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0373, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "System Management Command Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0374, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "CFAST Security Level", 
                " View, Change, *Hide", 
                "\\System Configuration\\Security Level", 
                0x01, 
                0x00, 
                0x00, 
                0x0375, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "eSATA boot Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0376, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "TPM Embedded Security Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0377, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Express Card Link Speed Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0378, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Embedded GPS Device Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x037A, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Switchable Graphics Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x037B, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Secure Erase Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x037C, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Power Control Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x037D, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Power-On when AC is detected Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x037E, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                "Require acknowledgment of battery errors Security Level", 
                " *View, Change, Hide", 
                "\\System Configuration\\Security Level", 
                0x00, 
                0x01, 
                0x00, 
                0x0380, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                "View", 
                0x0C, 
                "Change", 
                "View", 
                "Hide", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }, 

            Package (0x1A)
            {
                " ", 
                " ", 
                " ", 
                0x01, 
                0x00, 
                0x00, 
                0x038E, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                " ", 
                0x0C, 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }
        })
        Name (BSPV, Package (0x05)
        {
            Package (0x12)
            {
                "Setup Password", 
                " ", 
                "\\Security", 
                0x00, 
                0x01, 
                0x01, 
                0x0258, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x08, 
                0x20, 
                "utf-16", 
                " ", 
                0x00, 
                0x00
            }, 

            Package (0x12)
            {
                "Notebook hard drive drivelock master password", 
                " ", 
                "\\Security", 
                0x00, 
                0x01, 
                0x00, 
                0x025E, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x08, 
                0x20, 
                "utf-16", 
                " ", 
                0x00, 
                0x00
            }, 

            Package (0x12)
            {
                "Notebook hard drive drivelock user password", 
                " ", 
                "\\Security", 
                0x00, 
                0x01, 
                0x01, 
                0x025F, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x08, 
                0x20, 
                "utf-16", 
                " ", 
                0x00, 
                0x00
            }, 

            Package (0x12)
            {
                "Upgrade bay hard drive drivelock master password", 
                " ", 
                "\\Security", 
                0x00, 
                0x01, 
                0x01, 
                0x0260, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x08, 
                0x20, 
                "utf-16", 
                " ", 
                0x00, 
                0x00
            }, 

            Package (0x12)
            {
                "Upgrade bay hard drive drivelock user password", 
                " ", 
                "\\Security", 
                0x00, 
                0x01, 
                0x01, 
                0x0261, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x08, 
                0x20, 
                "utf-16", 
                " ", 
                0x00, 
                0x00
            }
        })
        Name (BSIN, Package (0x02)
        {
            Package (0x0F)
            {
                "Password Minimum Length", 
                "Place holder ", 
                "\\Security\\Administrator Tools\\Password Policy", 
                0x00, 
                0x01, 
                0x00, 
                0x0295, 
                0x03, 
                "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
                " ", 
                " ", 
                0x00, 
                0x04, 
                0x20, 
                0x04
            }, 

            Package (0x0F)
            {
                "Manufacturing Programming Mode Counter", 
                "Place holder ", 
                "\\Place holder for Path", 
                0x00, 
                0x01, 
                0x00, 
                0x0376, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x0A, 
                0x00
            }
        })
        Name (BSSS, Package (0x29)
        {
            Package (0x0E)
            {
                "Notebook Asset Tag", 
                "Asset Tag Place Holder", 
                "\\Security\\System IDs", 
                0x00, 
                0x01, 
                0x00, 
                0x63, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "Notebook Ownership Tag", 
                "Ownershiptag place holder", 
                "\\Security\\System IDs", 
                0x00, 
                0x01, 
                0x00, 
                0x62, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x50
            }, 

            Package (0x0E)
            {
                " ", 
                " ", 
                " ", 
                0x01, 
                0x00, 
                0x00, 
                0x5B, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0xA0
            }, 

            Package (0x0E)
            {
                "Set Alarm Time", 
                "Asset Tag Place Holder", 
                "\\System Configuration\\BIOS Power-on", 
                0x00, 
                0x01, 
                0x00, 
                0x39, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x05
            }, 

            Package (0x0E)
            {
                "PCID", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x00, 
                0x01, 
                0x00, 
                0x3B, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x40
            }, 

            Package (0x0E)
            {
                "Define Custom URL", 
                "Asset Tag Place Holder", 
                "\\System Configuration\\Device Configuration", 
                0x00, 
                0x01, 
                0x00, 
                0x3D, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x82
            }, 

            Package (0x0E)
            {
                "PCID Version", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x3A, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x05
            }, 

            Package (0x0E)
            {
                "Manufacturer", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x14, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "Notebook Model", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x00, 
                0x01, 
                0x00, 
                0x1E, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x20
            }, 

            Package (0x0E)
            {
                "Processor Type", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x28, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "Processor Speed", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x32, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x0A
            }, 

            Package (0x0E)
            {
                "Total Memory Size", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x50, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "BIOS Date", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x5A, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "BIOS Version", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x5C, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "Serial Number", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x00, 
                0x01, 
                0x00, 
                0x5E, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "Video BIOS Revision", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x5F, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "Video BIOS Revision 2", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x60, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "Keyboard Controller Version", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x61, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "Hard Disk Serial Number", 
                "No Status to Display", 
                "\\Security\\Hard Disk Sanitization Completion Report", 
                0x01, 
                0x01, 
                0x00, 
                0x044C, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x14
            }, 

            Package (0x0E)
            {
                "Hard Disk Make and Model", 
                "No Status to Display", 
                "\\Security\\Hard Disk Sanitization Completion Report", 
                0x01, 
                0x01, 
                0x00, 
                0x044D, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x28
            }, 

            Package (0x0E)
            {
                "Completion Date", 
                "No Status to Display", 
                "\\Security\\Hard Disk Sanitization Completion Report", 
                0x01, 
                0x01, 
                0x00, 
                0x044E, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x11
            }, 

            Package (0x0E)
            {
                "Completion Status", 
                "No Status to Display", 
                "\\Security\\Hard Disk Sanitization Completion Report", 
                0x01, 
                0x01, 
                0x00, 
                0x044F, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x16
            }, 

            Package (0x0E)
            {
                "Write Cycles Completed", 
                "No Status to Display", 
                "\\Security\\Hard Disk Sanitization Completion Report", 
                0x01, 
                0x01, 
                0x00, 
                0x0450, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x01
            }, 

            Package (0x0E)
            {
                "Warranty Start Date", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x2A, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x0A
            }, 

            Package (0x0E)
            {
                "Product Number", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x00, 
                0x01, 
                0x00, 
                0x29, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x10
            }, 

            Package (0x0E)
            {
                "System Board ID", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x1F, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x04
            }, 

            Package (0x0E)
            {
                "Primary Battery Serial Number", 
                "No Battery Present", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x64, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "Secondary Battery Serial Number", 
                "No Battery Present", 
                "\\File\\System Information", 
                0x01, 
                0x00, 
                0x00, 
                0x66, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x0E)
            {
                "Bluetooth FCC ID", 
                "No Device Present", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x6F, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x14
            }, 

            Package (0x0E)
            {
                "WLAN FCC ID", 
                "No Device Present", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x6E, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x14
            }, 

            Package (0x0E)
            {
                "WWAN FCC ID", 
                "No Device Present", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x6D, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x14
            }, 

            Package (0x0E)
            {
                "GPS FCC ID", 
                "No Device Present", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x72, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x14
            }, 

            Package (0x0E)
            {
                "Universal Unique Identifier(UUID)", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x20, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x20
            }, 

            Package (0x0E)
            {
                "System Configuration ID", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x21, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x1A
            }, 

            Package (0x0E)
            {
                "System Board CT", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x00, 
                0x01, 
                0x00, 
                0x70, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x0F
            }, 

            Package (0x0E)
            {
                "MicroCode Revision", 
                "Asset Tag Place Holder", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x77, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x0F
            }, 

            Package (0x0E)
            {
                "Disk Sanitation Method", 
                "No Status to Display", 
                "\\Security\\Hard Disk Sanitization Completion Report", 
                0x01, 
                0x01, 
                0x00, 
                0x0451, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x1A
            }, 

            Package (0x0E)
            {
                "Memory Slot 1 Information", 
                " ", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x51, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x50
            }, 

            Package (0x0E)
            {
                "Memory Slot 2 Information", 
                " ", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x52, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x50
            }, 

            Package (0x0E)
            {
                "Memory Slot 3 Information", 
                " ", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x53, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x50
            }, 

            Package (0x0E)
            {
                "Memory Slot 4 Information", 
                " ", 
                "\\File\\System Information", 
                0x01, 
                0x01, 
                0x00, 
                0x54, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x00, 
                0x50
            }
        })
        Name (DSTS, Package (0x04)
        {
            "Success", 
            "Error writing to disk", 
            "Error verifying disk", 
            "User aborted operation"
        })
        Name (DSMD, Package (0x05)
        {
            " ", 
            "Fast", 
            "Optimum", 
            "Custom", 
            "Secure Erase"
        })
        Name (F12D, Package (0x08)
        {
            "0", 
            "5", 
            "10", 
            "15", 
            "20", 
            "25", 
            "30", 
            "35"
        })
        Name (BPPD, Package (0x08)
        {
            "0", 
            "5", 
            "10", 
            "15", 
            "20", 
            "25", 
            "30", 
            "35"
        })
        Name (PPMD, Package (0x04)
        {
            "EPP", 
            "Bidirectional", 
            "Standard", 
            "ECP"
        })
        Name (PPMS, Package (0x04)
        {
            "*EPP , Bidirectional, Standard, ECP", 
            " EPP , *Bidirectional, Standard, ECP", 
            " EPP , Bidirectional, *Standard, ECP", 
            " EPP , Bidirectional, Standard, *ECP"
        })
        Name (SWRD, Package (0x1A)
        {
            "SATA Device Mode", 
            " IDE, *AHCI, RAID", 
            "\\System Configuration\\Device Configurations", 
            0x00, 
            0x01, 
            0x00, 
            0x0134, 
            0x03, 
            " ", 
            " ", 
            " ", 
            0x00, 
            "AHCI", 
            0x0C, 
            "IDE", 
            "AHCI", 
            "RAID", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (CTIP, Package (0x1A)
        {
            "Ctrl I Prompt", 
            " *Disable, Enable", 
            "\\System Configuration\\Device Configurations", 
            0x00, 
            0x01, 
            0x00, 
            0x013F, 
            0x03, 
            "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'SATA Device Mode\' AND CurrentValue=\'RAID\' ", 
            " ", 
            " ", 
            0x00, 
            "Disable", 
            0x0C, 
            "Disable", 
            "Enable", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (TXTS, Package (0x1A)
        {
            "TXT Technology", 
            " Disable, *Enable", 
            "\\System Configuration\\Device Configurations", 
            0x00, 
            0x01, 
            0x00, 
            0x013A, 
            0x03, 
            "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Embedded Security Device Availability\' AND CurrentValue=\'Available\'", 
            "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Virtualization Technology\' AND CurrentValue=\'Enable\'", 
            " ", 
            0x00, 
            "Enable", 
            0x0C, 
            "Disable", 
            "Enable", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (TXTP, Package (0x1A)
        {
            "TXT Technology Security Level", 
            " *View, Change, Hide", 
            "\\System Configuration\\Security Level", 
            0x00, 
            0x01, 
            0x00, 
            0x035D, 
            0x03, 
            "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
            " ", 
            " ", 
            0x00, 
            "View", 
            0x0C, 
            "Change", 
            "View", 
            "Hide", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (ATEM, Package (0x1A)
        {
            "Terminal Emulation Mode", 
            " ANSI, *VT100", 
            "\\System Configuration\\AMT Options", 
            0x00, 
            0x01, 
            0x00, 
            0x02BD, 
            0x03, 
            " ", 
            " ", 
            " ", 
            0x00, 
            "ANSI", 
            0x0C, 
            "ANSI", 
            "VT100", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (AFWV, Package (0x1A)
        {
            "Firmware Verbosity", 
            " Disable, *Enable", 
            "\\System Configuration\\AMT Options", 
            0x00, 
            0x01, 
            0x00, 
            0x02BD, 
            0x03, 
            " ", 
            " ", 
            " ", 
            0x00, 
            "Enable", 
            0x0C, 
            "Disable", 
            "Enable", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (APES, Package (0x1A)
        {
            "Firmware Progress Event Support", 
            " Disable, *Enable", 
            "\\System Configuration\\AMT Options", 
            0x00, 
            0x01, 
            0x00, 
            0x02C2, 
            0x03, 
            " ", 
            " ", 
            " ", 
            0x00, 
            "Enable", 
            0x0C, 
            "Disable", 
            "Enable", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (AUNB, Package (0x1A)
        {
            "Unconfigure AMT on next boot", 
            " Disable, *Enable", 
            "\\System Configuration\\AMT Options", 
            0x00, 
            0x01, 
            0x00, 
            0x02C0, 
            0x03, 
            " ", 
            " ", 
            " ", 
            0x00, 
            "Enable", 
            0x0C, 
            "Disable", 
            "Enable", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (AUKP, Package (0x1A)
        {
            "USB Key Provisioning Support", 
            " Disable, *Enable", 
            "\\System Configuration\\AMT Options", 
            0x00, 
            0x01, 
            0x00, 
            0x02C1, 
            0x03, 
            " ", 
            " ", 
            " ", 
            0x00, 
            "Enable", 
            0x0C, 
            "Disable", 
            "Enable", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (ASUP, Package (0x1A)
        {
            "AMT Setup Prompt(Ctrl-P)", 
            " *Disable, Enable", 
            "\\System Configuration\\AMT Options", 
            0x00, 
            0x01, 
            0x00, 
            0x02C3, 
            0x03, 
            "SELECT * FROM HP_BIOSEnumeration WHERE Name=\'Firmware Verbosity\' AND CurrentValue=\'Enable\'", 
            " ", 
            " ", 
            0x00, 
            "Disable", 
            0x0C, 
            "Disable", 
            "Enable", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (AIIC, Package (0x1A)
        {
            "Initiate Intel CIRA", 
            " *Disable, Enable", 
            "\\System Configuration\\AMT Options", 
            0x00, 
            0x01, 
            0x00, 
            0x02C5, 
            0x03, 
            " ", 
            " ", 
            " ", 
            0x00, 
            "Disable", 
            0x0C, 
            "Disable", 
            "Enable", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (ATEP, Package (0x1A)
        {
            "Terminal Emulation Mode Security Level", 
            " *View, Change, Hide", 
            "\\System Configuration\\Security Level", 
            0x00, 
            0x01, 
            0x00, 
            0x0350, 
            0x03, 
            "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
            " ", 
            " ", 
            0x00, 
            "View", 
            0x0C, 
            "Change", 
            "View", 
            "Hide", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (AFWP, Package (0x1A)
        {
            "Firmware Verbosity Security Level", 
            " *View, Change, Hide", 
            "\\System Configuration\\Security Level", 
            0x00, 
            0x01, 
            0x00, 
            0x034C, 
            0x03, 
            "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
            " ", 
            " ", 
            0x00, 
            "View", 
            0x0C, 
            "Change", 
            "View", 
            "Hide", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (APEP, Package (0x1A)
        {
            "Firmware Progress Event Support Security Level", 
            " *View, Change, Hide", 
            "\\System Configuration\\Security Level", 
            0x00, 
            0x01, 
            0x00, 
            0x0351, 
            0x03, 
            "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
            " ", 
            " ", 
            0x00, 
            "View", 
            0x0C, 
            "Change", 
            "View", 
            "Hide", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (AUNP, Package (0x1A)
        {
            "Unconfigure AMT on next boot Security Level", 
            " *View, Change, Hide", 
            "\\System Configuration\\Security Level", 
            0x00, 
            0x01, 
            0x00, 
            0x034F, 
            0x03, 
            "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
            " ", 
            " ", 
            0x00, 
            "View", 
            0x0C, 
            "Change", 
            "View", 
            "Hide", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (AUPP, Package (0x1A)
        {
            "USB Key Provisioning Support Security Level", 
            " *View, Change, Hide", 
            "\\System Configuration\\Security Level", 
            0x00, 
            0x01, 
            0x00, 
            0x034E, 
            0x03, 
            "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
            " ", 
            " ", 
            0x00, 
            "View", 
            0x0C, 
            "Change", 
            "View", 
            "Hide", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (ASPP, Package (0x1A)
        {
            "AMT Setup Prompt(Ctrl-P) Security Level", 
            " *View, Change, Hide", 
            "\\System Configuration\\Security Level", 
            0x00, 
            0x01, 
            0x00, 
            0x035E, 
            0x03, 
            "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
            " ", 
            " ", 
            0x00, 
            "View", 
            0x0C, 
            "Change", 
            "View", 
            "Hide", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (AIIP, Package (0x1A)
        {
            "Initiate Intel CIRA Security Level", 
            " *View, Change, Hide", 
            "\\System Configuration\\Security Level", 
            0x00, 
            0x01, 
            0x00, 
            0x0365, 
            0x03, 
            "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
            " ", 
            " ", 
            0x00, 
            "View", 
            0x0C, 
            "Change", 
            "View", 
            "Hide", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (BKTO, Package (0x1A)
        {
            " ", 
            " ", 
            " ", 
            0x01, 
            0x00, 
            0x01, 
            0xDD, 
            0x03, 
            " ", 
            " ", 
            " ", 
            0x00, 
            " ", 
            0x0C, 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (BKTP, Package (0x1A)
        {
            " ", 
            " ", 
            " ", 
            0x01, 
            0x00, 
            0x00, 
            0x036E, 
            0x03, 
            "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1", 
            " ", 
            " ", 
            0x00, 
            " ", 
            0x0C, 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " ", 
            " "
        })
        Name (SMDE, Package (0x03)
        {
            "IDE", 
            "AHCI", 
            "RAID"
        })
        Name (RDFD, Package (0x03)
        {
            " *IDE, AHCI, RAID", 
            " IDE, *AHCI, RAID", 
            " IDE,  AHCI, *RAID"
        })
        Name (NRDF, Package (0x02)
        {
            " *IDE, AHCI", 
            " IDE, *AHCI"
        })
        Name (F1PS, "*F1 to Boot, Allow user to reject, No prompts")
        Name (F1F2, " F1 to Boot, *Allow user to reject, No prompts")
        Name (NOPS, " F1 to Boot, Allow user to reject, *No prompts")
        Name (F1PV, "F1 to Boot")
        Name (F12V, "Allow user to reject")
        Name (NOPR, "No prompts")
        Name (WOLV, Package (0x03)
        {
            "Disable", 
            "Boot to Network", 
            "Follow Boot Order"
        })
        Name (VTVL, Package (0x03)
        {
            "Disable", 
            "Enable", 
            "Reset to default"
        })
        Name (BCPP, Package (0x0A)
        {
            "10", 
            "20", 
            "30", 
            "40", 
            "50", 
            "60", 
            "70", 
            "80", 
            "90", 
            "100"
        })
        Name (BUSR, Package (0x05)
        {
            Package (0x13)
            {
                " ", 
                " ", 
                "\\Security", 
                0x01, 
                0x00, 
                0x01, 
                0x0259, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x08, 
                0x20, 
                "utf-16", 
                " ", 
                0x00, 
                0x00, 
                0x00
            }, 

            Package (0x13)
            {
                " ", 
                " ", 
                "\\Security", 
                0x01, 
                0x00, 
                0x01, 
                0x025A, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x08, 
                0x20, 
                "utf-16", 
                " ", 
                0x00, 
                0x00, 
                0x00
            }, 

            Package (0x13)
            {
                " ", 
                " ", 
                "\\Security", 
                0x01, 
                0x00, 
                0x01, 
                0x025B, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                0x08, 
                0x20, 
                "utf-16", 
                " ", 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (LANG, Package (0x0C)
        {
            "English", 
            "Francais", 
            "Deutsch", 
            "Espanol", 
            "Italiano", 
            "Dansk", 
            "Nederlands", 
            "Suomi", 
            "Japanese", 
            "Norsk", 
            "Portugues", 
            "Svenska"
        })
        Name (BSED, Package (0x01)
        {
            Package (0x1A)
            {
                "Name", 
                "Value", 
                "Path", 
                0x00, 
                0x01, 
                0x00, 
                0x65, 
                0x03, 
                " ", 
                " ", 
                " ", 
                0x00, 
                "Current Value", 
                0x0C, 
                "Possible Value1", 
                "Possible Value2", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " ", 
                " "
            }
        })
        Name (BLKB, Package (0x06)
        {
            "5 secs.", 
            "15 secs.", 
            "30 secs.", 
            "1 min.", 
            "5 mins.", 
            "Never"
        })
        Name (VTDV, Package (0x03)
        {
            "Disable", 
            "Enable", 
            "Reset to default"
        })
        Name (ETYP, Buffer (0x01){})
        Device (WMID)
        {
            Name (WCDS, Package (0x38)
            {
                0x04, 
                0x04, 
                0x04, 
                0x00, 
                0x04, 
                0x04, 
                0x00, 
                0x00, 
                0x04, 
                0x04, 
                0x0C, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x05, 
                0x00, 
                0x00, 
                0x00, 
                0x04, 
                0x00, 
                0x00, 
                0x00, 
                0x04, 
                0x04, 
                0x00, 
                0x04, 
                0x00, 
                0x04, 
                0x00, 
                0x04, 
                0x00, 
                0x04, 
                0x04, 
                0x02, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x80, 
                0x80, 
                0x04, 
                0x04, 
                0x00, 
                0x04, 
                0x00, 
                0x80, 
                0x00, 
                0x00, 
                0x00, 
                0x04, 
                0x04, 
                0x00, 
                0x80, 
                0x80, 
                0x04
            })
            Name (ZOBF, Buffer ((0x1000 + 0x10)){})
            Method (WHCM, 2, NotSerialized)
            {
                CreateDWordField (Arg1, 0x00, SNIN)
                CreateDWordField (Arg1, 0x04, COMD)
                CreateDWordField (Arg1, 0x08, CMTP)
                CreateDWordField (Arg1, 0x0C, DASI)
                Debug = "HandleWMICommand Enter"
                If ((Arg0 == 0x01))
                {
                    Local0 = 0x00
                }

                If ((Arg0 == 0x02))
                {
                    Local0 = 0x04
                }

                If ((Arg0 == 0x03))
                {
                    Local0 = 0x80
                }

                If ((Arg0 == 0x04))
                {
                    Local0 = 0x0400
                }

                If ((Arg0 == 0x05))
                {
                    Local0 = 0x1000
                }

                Debug = Local0
                Local1 = Buffer ((0x08 + Local0)){}
                CreateDWordField (Local1, 0x00, SNOU)
                CreateDWordField (Local1, 0x04, RTCD)
                SNOU = 0x4C494146
                Local5 = DASI /* \_SB_.WMID.WHCM.DASI */
                If ((DASI > 0x2000))
                {
                    RTCD = 0x05
                    Return (Local1)
                }

                Local5 = DASI /* \_SB_.WMID.WHCM.DASI */
                CreateField (Arg1, 0x00, ((Local5 + 0x10) * 0x08), DAIN)
                ASMB = DAIN /* \_SB_.WMID.WHCM.DAIN */
                RTCD = 0x02
                Debug = SNIN /* \_SB_.WMID.WHCM.SNIN */
                If ((SNIN == 0x55434553))
                {
                    Debug = "SECU Ready"
                    RTCD = 0x03
                    Debug = "CommandType"
                    Debug = CMTP /* \_SB_.WMID.WHCM.CMTP */
                    If ((COMD == 0x01))
                    {
                        Debug = "Read BIOS"
                        RTCD = 0x04
                        If ((CMTP == 0x01))
                        {
                            Local2 = ^WGDD ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x02))
                        {
                            Local2 = ^WGHP ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x03))
                        {
                            Local2 = ^WALS ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x04))
                        {
                            Local2 = ^WGDS ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x07))
                        {
                            If (DASI)
                            {
                                Local3 = DerefOf (Arg1 [0x10])
                                Local2 = WGBI (Local3)
                                RTCD = 0x00
                            }
                            Else
                            {
                                RTCD = 0x05
                            }
                        }

                        If ((CMTP == 0x08))
                        {
                            Debug = "Bezel button table"
                            Local2 = ^WGBN ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x0D))
                        {
                            Debug = "Feature Report"
                            Local2 = ^GFRT ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x09))
                        {
                            Debug = "Hotkey Scancode"
                            Local2 = ^GHKS ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x0A))
                        {
                            Debug = "Hotkey Function"
                            Local2 = ^GHKF ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x0C))
                        {
                            Debug = "Bezel button"
                            Local2 = ^WGBV ()
                            Debug = Local2
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x0F))
                        {
                            Local2 = ^GSAS ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x10))
                        {
                            Local2 = ^GSRV ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x11))
                        {
                            Local2 = ^GVPR ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x12))
                        {
                            Local2 = ^GBRS ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x14))
                        {
                            Local2 = ^GWPT ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x18))
                        {
                            Debug = "Get system configuration"
                            Local2 = ^GDBT ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x1B))
                        {
                            Local2 = ^WGWS ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x1C))
                        {
                            Local2 = ^GPMC (0x00)
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x1D))
                        {
                            Debug = "Get Diags mode"
                            Local2 = ^GDMD ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x1E))
                        {
                            Debug = "Get BIOS Update status"
                            Local2 = ^GBUS ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x28))
                        {
                            Debug = "Get thermal status"
                            If ((DASI != 0x04))
                            {
                                RTCD = 0x05
                            }
                            Else
                            {
                                CreateField (Arg1, 0x80, (DASI * 0x08), GTSD)
                                Local2 = ^GTMS (GTSD)
                                RTCD = 0x00
                            }
                        }

                        If ((CMTP == 0x2B))
                        {
                            Debug = "Get Battery control"
                            Local2 = ^WGBC ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x20))
                        {
                            Local2 = ^GBTT ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x21))
                        {
                            If ((DASI < DerefOf (WCDS [(CMTP - 0x01)])))
                            {
                                RTCD = 0x05
                            }
                            ElseIf ((\WCOS () >= 0x06))
                            {
                                RTCD = 0x04
                            }
                            Else
                            {
                                CreateDWordField (Arg1, 0x10, BTYP)
                                Local2 = ^GBTL (BTYP)
                                RTCD = 0x00
                            }
                        }

                        If ((CMTP == 0x22))
                        {
                            Debug = "Quick Button Policy"
                            Local2 = ^GQBP ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x23))
                        {
                            Local2 = ^GPIN ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x25))
                        {
                            Local2 = ^GPMC (0x01)
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x29))
                        {
                            Local2 = ^GFCC ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x2A))
                        {
                            Local2 = ^GPES ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x2E))
                        {
                            Local2 = ^GLID ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x30))
                        {
                            Local2 = ^GEID ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x33))
                        {
                            Local2 = ^GDES ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x36))
                        {
                            Local2 = ^GPST ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x37))
                        {
                            Local2 = ^GBCT ()
                            RTCD = 0x00
                        }

                        If ((CMTP == 0x38))
                        {
                            Local2 = ^GPSH ()
                            RTCD = 0x00
                        }
                    }

                    Debug = "Not Read BIOS"
                    If ((COMD == 0x02))
                    {
                        Debug = "write BIOS command"
                        RTCD = 0x04
                        If (((CMTP > 0x00) && (CMTP <= 0x38)))
                        {
                            If ((DASI < DerefOf (WCDS [(CMTP - 0x01)])))
                            {
                                RTCD = 0x05
                            }
                            Else
                            {
                                CreateDWordField (Arg1, 0x10, DDWD)
                                If ((CMTP == 0x01))
                                {
                                    Debug = "set display switch"
                                    Local2 = ^WSDD (DDWD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x02))
                                {
                                    Local2 = ^WITH (DDWD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x03))
                                {
                                    Local2 = ^WSAL (DDWD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x06))
                                {
                                    Debug = "write Brightness"
                                    Local2 = ^SBBC (DDWD)
                                    Debug = Local2
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x09))
                                {
                                    Debug = "Hotkey Scancode"
                                    Local2 = ^SHKS (DDWD)
                                    Debug = Local2
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x0A))
                                {
                                    Debug = "Hotkey Function"
                                    Local2 = ^SHKF (DDWD)
                                    Debug = Local2
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x10))
                                {
                                    Debug = "Set Service ID"
                                    Local2 = ^SSRV (DDWD)
                                    Debug = Local2
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x14))
                                {
                                    Local2 = ^SWPT (DDWD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x18))
                                {
                                    Debug = "Set System configuration"
                                    Local2 = ^SDBT (DDWD)
                                    Local3 = (DDWD ^ DTCD) /* \DTCD */
                                    If ((Local3 & 0x1800))
                                    {
                                        \_SB.PCI0.LPCB.EC0.PWUP (0x01, 0x00)
                                        Notify (\_SB.AC, 0x80) // Status Change
                                        DTCD = DDWD /* \_SB_.WMID.WHCM.DDWD */
                                    }

                                    Debug = Local2
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x1B))
                                {
                                    Local2 = ^WSWS (DDWD)
                                    RTCD = 0x00
                                    WGWE (0x05, 0x00)
                                }

                                If ((CMTP == 0x1D))
                                {
                                    Debug = "Get Diags mode"
                                    Local2 = ^SDMD (DDWD)
                                    Debug = Local2
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x1E))
                                {
                                    Debug = "Get BIOS Update status"
                                    Local2 = ^SBUS (DDWD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x28))
                                {
                                    Debug = "Set thermal status"
                                    CreateField (Arg1, 0x80, (DASI * 0x08), STSD)
                                    Local2 = ^STMM (STSD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x2B))
                                {
                                    Debug = "Get Battery control"
                                    Local2 = ^WSBC (CMTP, DASI, DAIN)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x21))
                                {
                                    If ((\WCOS () >= 0x06))
                                    {
                                        RTCD = 0x04
                                    }
                                    Else
                                    {
                                        Local2 = ^SBRT ((DDWD & 0xFF), ((DDWD >> 0x08) & 
                                            0xFFFF))
                                        If ((Local2 != Ones))
                                        {
                                            BRID = Local2
                                            \_SB.SSMI (0xEA74, 0x08, Local2, 0x00, 0x00)
                                            \_SB.WBRT ()
                                            Local2 = Package (0x02)
                                                {
                                                    0x00, 
                                                    0x00
                                                }
                                        }
                                        Else
                                        {
                                            Local2 = Package (0x02)
                                                {
                                                    0x06, 
                                                    0x00
                                                }
                                        }

                                        RTCD = 0x00
                                    }
                                }

                                If ((CMTP == 0x22))
                                {
                                    Debug = "Set Quick Button Policy"
                                    Local2 = ^SQBP (DDWD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x23))
                                {
                                    Local2 = ^SPIN (DDWD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x25))
                                {
                                    Local2 = ^CPMC ()
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x29))
                                {
                                    Local2 = ^SFCC (DDWD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x2A))
                                {
                                    Local2 = ^SPES (DDWD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x36))
                                {
                                    Local2 = ^SPST (DDWD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x37))
                                {
                                    Local2 = ^SBCP (DDWD)
                                    RTCD = 0x00
                                }

                                If ((CMTP == 0x38))
                                {
                                    Local2 = ^SPSH (DDWD)
                                    RTCD = 0x00
                                }
                            }
                        }
                    }

                    If ((COMD == 0x03))
                    {
                        Local2 = \_SB.HODM (CMTP, DASI, DAIN)
                        RTCD = 0x00
                    }

                    If ((COMD == 0x00020000))
                    {
                        \_SB.SSMI (0xEA75, COMD, CMTP, 0x574D4953, 0x00)
                        Local2 = WFDA ()
                        RTCD = 0x00
                    }

                    If ((COMD == 0x00020001))
                    {
                        \_SB.SSMI (0xEA75, COMD, CMTP, 0x574D4953, 0x00)
                        If ((EDX == 0x5A5A))
                        {
                            While ((EDX == 0x5A5A))
                            {
                                \_SB.SSMI (0xEA75, COMD, 0x10, 0x574D4953, 0x00)
                                Sleep (0x19)
                            }

                            ECX = 0x00
                            EDX = 0x574D4953
                        }

                        Local2 = WFDA ()
                        RTCD = 0x00
                    }

                    If ((COMD == 0x00020002))
                    {
                        \_SB.SSMI (0xEA75, COMD, CMTP, 0x574D4953, 0x00)
                        Local2 = WFDA ()
                        RTCD = 0x00
                    }

                    If ((COMD == 0x00020003))
                    {
                        If ((CMTP == 0x06))
                        {
                            If ((DASI == 0x04))
                            {
                                CreateDWordField (Arg1, 0x10, EVNR)
                                Local2 = HPMC (CMTP, EVNR)
                            }
                            Else
                            {
                                Local2 = Package (0x02)
                                    {
                                        0x05, 
                                        0x00
                                    }
                            }
                        }
                        Else
                        {
                            Local2 = HPMC (CMTP, 0x00)
                        }

                        RTCD = 0x00
                    }

                    If ((COMD == 0x00020004))
                    {
                        \_SB.SSMI (0xEA75, COMD, CMTP, 0x574D4953, 0x00)
                        Local2 = WFDA ()
                        RTCD = 0x00
                    }
                }

                If ((RTCD == 0x00))
                {
                    RTCD = DerefOf (Local2 [0x00])
                    If ((RTCD == 0x00))
                    {
                        Local3 = DerefOf (Local2 [0x01])
                        If ((Local3 <= Local0))
                        {
                            Local5 = 0x00
                            While ((Local5 < Local3))
                            {
                                Local1 [(Local5 + 0x08)] = DerefOf (DerefOf (
                                    Local2 [0x02]) [Local5])
                                Local5++
                            }

                            If ((COMD == 0x00020000))
                            {
                                If (EDX)
                                {
                                    Debug = "Encrypted Data Out"
                                    RTCD |= (Local3 << 0x10) /* \_SB_.WMID.WHCM.RTCD */
                                }
                                Else
                                {
                                    Debug = "No Encrypted Data Out"
                                }
                            }

                            SNOU = 0x53534150
                        }
                        Else
                        {
                            RTCD = 0x05
                        }
                    }
                }

                ASMB = ZOBF /* \_SB_.WMID.ZOBF */
                Return (Local1)
            }

            Method (WFDA, 0, NotSerialized)
            {
                If (((ECX == 0x00) || (EBX != 0x00)))
                {
                    Local0 = Package (0x02)
                        {
                            0x00, 
                            0x00
                        }
                }
                Else
                {
                    Local1 = ECX /* \ECX_ */
                    Local0 = Package (0x03)
                        {
                            0x00, 
                            0x00, 
                            Buffer (Local1){}
                        }
                    Debug = ECX /* \ECX_ */
                }

                Local0 [0x00] = EBX /* \EBX_ */
                If ((EBX == 0x00))
                {
                    Local0 [0x01] = ECX /* \ECX_ */
                    If ((ECX != 0x00))
                    {
                        Local1 = ASMB /* \ASMB */
                        Local2 = 0x00
                        While ((Local2 < ECX))
                        {
                            DerefOf (Local0 [0x02]) [Local2] = DerefOf (Local1 [
                                Local2])
                            Local2++
                        }
                    }
                }

                Return (Local0)
            }

            Method (WGWE, 2, NotSerialized)
            {
                If ((\_SB.WMID.WEI1 == 0x00))
                {
                    \_SB.WMID.WEI1 = Arg0
                    \_SB.WMID.WED1 = Arg1
                }
                Else
                {
                    \_SB.WMID.WEI2 = Arg0
                    \_SB.WMID.WED2 = Arg1
                }

                Notify (\_SB.WMID, 0x80) // Status Change
            }

            Method (HPMC, 2, NotSerialized)
            {
                Local0 = Buffer (0x80){}
                Local0 [0x00] = 0x01
                Local0 [0x01] = 0x00
                If ((Arg0 == 0x03))
                {
                    CreateWordField (Local0, 0x04, SYSD)
                    CreateWordField (Local0, 0x06, SUPP)
                    CreateDWordField (Local0, 0x08, S0AC)
                    CreateDWordField (Local0, 0x0C, S3AC)
                    CreateDWordField (Local0, 0x10, S5AC)
                    CreateDWordField (Local0, 0x14, S0DA)
                    CreateDWordField (Local0, 0x18, S3DA)
                    CreateDWordField (Local0, 0x1C, S5DA)
                    SYSD = 0x96
                    SUPP = 0x05DF
                    S0AC = 0x78
                    S3AC = 0x07B8
                    S5AC = 0x07B8
                    S0DA = 0x00
                    S3DA = 0x0790
                    S5DA = 0x0790
                    Local1 = Package (0x03)
                        {
                            0x00, 
                            0x80, 
                            Buffer (0x80){}
                        }
                    Local1 [0x02] = Local0
                    Return (Local1)
                }

                If ((Arg0 == 0x04))
                {
                    If ((PMCS == 0x01))
                    {
                        If (\_SB.PCI0.LPCB.EC0.ECRG)
                        {
                            \_SB.PCI0.LPCB.EC0.PMCC = 0x01
                            CreateWordField (Local0, 0x02, SYSS)
                            CreateDWordField (Local0, 0x05, S0AD)
                            CreateDWordField (Local0, 0x08, S0PW)
                            CreateDWordField (Local0, 0x0C, S0CT)
                            CreateDWordField (Local0, 0x10, S3AD)
                            CreateDWordField (Local0, 0x13, S3PW)
                            CreateDWordField (Local0, 0x17, S3CT)
                            CreateDWordField (Local0, 0x1B, S5AD)
                            CreateDWordField (Local0, 0x1E, S5PW)
                            CreateDWordField (Local0, 0x22, S5CT)
                            CreateDWordField (Local0, 0x26, S0DD)
                            CreateDWordField (Local0, 0x29, S0DP)
                            CreateDWordField (Local0, 0x2D, S0DC)
                            CreateDWordField (Local0, 0x31, S3DD)
                            CreateDWordField (Local0, 0x34, S3DP)
                            CreateDWordField (Local0, 0x38, S3DC)
                            CreateDWordField (Local0, 0x3C, S5DD)
                            CreateDWordField (Local0, 0x3F, S5DP)
                            CreateDWordField (Local0, 0x43, S5DC)
                            Local1 = \_SB.PCI0.LPCB.EC0.S0FL
                            Local3 = 0x01
                            If (((Local1 & 0x10) == 0x00))
                            {
                                Local3 |= 0x02
                            }

                            SYSS = Local3
                            S0AD = 0x00140000
                            S0AD |= ((Local1 & 0x0F) << 0x03) /* \_SB_.WMID.HPMC.S0AD */
                            Local2 = 0x00140000
                            Local2 |= ((\_SB.PCI0.LPCB.EC0.SXF0 & 0xF0) << 0x03)
                            Local3 = Local2
                            Local4 = \_SB.PCI0.LPCB.EC0.SXF1
                            If ((Local4 & 0x01))
                            {
                                Local3 |= 0x08
                            }

                            If ((Local4 & 0x04))
                            {
                                Local3 |= 0x10
                            }

                            If ((Local4 & 0x40))
                            {
                                Local3 |= 0x20
                            }

                            If (((Local3 & 0x08) == 0x00))
                            {
                                Local3 |= 0x8000
                            }

                            S3AD = Local3
                            Local3 = Local2
                            If ((Local4 & 0x02))
                            {
                                Local3 |= 0x08
                            }

                            If ((Local4 & 0x10))
                            {
                                Local3 |= 0x10
                            }

                            If ((Local4 & 0x80))
                            {
                                Local3 |= 0x20
                            }

                            If (((Local3 & 0x08) == 0x00))
                            {
                                Local3 |= 0x8000
                            }

                            S5AD = Local3
                            S0DD = 0x00
                            Local3 = 0x00148000
                            If ((Local4 & 0x08))
                            {
                                Local3 |= 0x10
                            }

                            S3DD = Local3
                            Local3 = 0x00148000
                            If ((Local4 & 0x20))
                            {
                                Local3 |= 0x10
                            }

                            S5DD = Local3
                            If ((Local1 & 0x20))
                            {
                                S0PW = 0xFFFFFFFF
                                S0CT = 0xFFFFFFFF
                                S3PW = 0xFFFFFFFF
                                S3CT = 0xFFFFFFFF
                                S5PW = 0xFFFFFFFF
                                S5CT = 0xFFFFFFFF
                                S0DP = 0xFFFFFFFF
                                S0DC = 0xFFFFFFFF
                                S3DP = 0xFFFFFFFF
                                S3DC = 0xFFFFFFFF
                                S5DP = 0xFFFFFFFF
                                S5DC = 0xFFFFFFFF
                            }
                            Else
                            {
                                \_SB.PCI0.LPCB.EC0.DIDX = 0x00
                                S0PW = \_SB.PCI0.LPCB.EC0.PMCD
                                \_SB.PCI0.LPCB.EC0.DIDX = 0x01
                                S0CT = \_SB.PCI0.LPCB.EC0.PMCD
                                \_SB.PCI0.LPCB.EC0.DIDX = 0x02
                                Local2 = \_SB.PCI0.LPCB.EC0.PMCD
                                \_SB.PCI0.LPCB.EC0.DIDX = 0x03
                                Local3 = \_SB.PCI0.LPCB.EC0.PMCD
                                \_SB.PCI0.LPCB.EC0.DIDX = 0x06
                                Local4 = \_SB.PCI0.LPCB.EC0.PMCD
                                S3PW = (Local2 + (Local4 * 0x01B8))
                                S3CT = (Local3 + Local4)
                                \_SB.PCI0.LPCB.EC0.DIDX = 0x04
                                Local2 = \_SB.PCI0.LPCB.EC0.PMCD
                                \_SB.PCI0.LPCB.EC0.DIDX = 0x05
                                Local3 = \_SB.PCI0.LPCB.EC0.PMCD
                                \_SB.PCI0.LPCB.EC0.DIDX = 0x07
                                Local4 = \_SB.PCI0.LPCB.EC0.PMCD
                                S5PW = (Local2 + (Local4 * 0x01B8))
                                S5CT = (Local3 + Local4)
                                S0DP = 0x00
                                S0DC = 0x00
                                \_SB.PCI0.LPCB.EC0.DIDX = 0x08
                                Local2 = \_SB.PCI0.LPCB.EC0.PMCD
                                S3DP = (Local2 * 0x01B8)
                                S3DC = Local2
                                \_SB.PCI0.LPCB.EC0.DIDX = 0x09
                                Local2 = \_SB.PCI0.LPCB.EC0.PMCD
                                S5DP = (Local2 * 0x01B8)
                                S5DC = Local2
                            }

                            \_SB.PCI0.LPCB.EC0.PMCC = 0x00
                        }
                        Else
                        {
                            Return (Package (0x02)
                            {
                                0x0D, 
                                0x00
                            })
                        }
                    }

                    Local1 = Package (0x03)
                        {
                            0x00, 
                            0x80, 
                            Buffer (0x80){}
                        }
                    Local1 [0x02] = Local0
                    Return (Local1)
                }

                If ((Arg0 == 0x05))
                {
                    If ((PMCS == 0x01))
                    {
                        If (\_SB.PCI0.LPCB.EC0.ECRG)
                        {
                            Local1 = Package (0x03)
                                {
                                    0x00, 
                                    0x04, 
                                    Buffer (0x04){}
                                }
                            DerefOf (Local1 [0x02]) [0x00] = \_SB.PCI0.LPCB.EC0.PMEP
                            Return (Local1)
                        }
                        Else
                        {
                            Return (Package (0x02)
                            {
                                0x0D, 
                                0x00
                            })
                        }
                    }
                }

                If ((Arg0 == 0x06))
                {
                    If ((PMCS == 0x01))
                    {
                        If (\_SB.PCI0.LPCB.EC0.ECRG)
                        {
                            \_SB.PCI0.LPCB.EC0.PMEP = Arg1
                            WGWE (0x00020000, 0x00)
                            Return (Package (0x02)
                            {
                                0x00, 
                                0x00
                            })
                        }
                        Else
                        {
                            Return (Package (0x02)
                            {
                                0x0D, 
                                0x00
                            })
                        }
                    }
                }

                Return (Package (0x02)
                {
                    0x04, 
                    0x00
                })
            }

            Method (GBTT, 0, NotSerialized)
            {
                Local1 = BCL ()
                Local5 = ((BRCT * 0x04) + 0x0C)
                Local0 = Buffer (Local5){}
                Local0 [0x00] = 0x03
                Local0 [0x01] = PNLF /* \PNLF */
                Local0 [0x02] = 0x00
                Local0 [0x03] = BRCT /* \BRCT */
                Local2 = 0x00
                Local3 = 0x04
                While ((Local2 < BRCT))
                {
                    Local0 [Local3] = DerefOf (Local1 [(Local2 + 0x02)]
                        )
                    Local0 [(Local3 + 0x01)] = 0x00
                    Local2++
                    Local3 += 0x02
                }

                Local0 [Local3] = 0x01
                Local3++
                Local0 [Local3] = BRCT /* \BRCT */
                Local3++
                Local2 = 0x00
                While ((Local2 < (BRCT * 0x02)))
                {
                    Local0 [Local3] = DerefOf (DerefOf (NITS [BCLI]) [
                        Local2])
                    Local2++
                    Local3++
                }

                Local0 [Local3] = 0x02
                Local3++
                Local0 [Local3] = 0x02
                Local3++
                Local2 = BPWG /* \BPWG */
                Local0 [Local3] = (Local2 & 0xFF)
                Local3++
                Local0 [Local3] = ((Local2 >> 0x08) & 0xFF)
                Local3++
                Local2 = BPWO /* \BPWO */
                Local0 [Local3] = (Local2 & 0xFF)
                Local3++
                Local0 [Local3] = ((Local2 >> 0x08) & 0xFF)
                Local3++
                Local2 = Package (0x03){}
                Local2 [0x00] = 0x00
                Local2 [0x01] = Local5
                Local2 [0x02] = Local0
                Return (Local2)
            }

            Method (GBTL, 1, NotSerialized)
            {
                Local0 = 0x00
                Local1 = BCL ()
                If ((Arg0 == 0x00))
                {
                    Local2 = DerefOf (Local1 [(BRID + 0x02)])
                }
                ElseIf ((Arg0 == 0x01))
                {
                    Local2 = BRID /* \BRID */
                }
                ElseIf ((Arg0 == 0x02))
                {
                    Local4 = (BRID << 0x01)
                    Local2 = DerefOf (DerefOf (NITS [BCLI]) [Local4])
                    Local3 = DerefOf (DerefOf (NITS [BCLI]) [(Local4 + 0x01
                        )])
                    Local2 = ((Local3 << 0x08) | Local2)
                }
                ElseIf ((Arg0 == 0x03))
                {
                    Local1 = BRLV /* \BRLV */
                    Local3 = BRID /* \BRID */
                    If ((BCLI == 0x00))
                    {
                        Local2 = BMAP /* \BMAP */
                        Local3 = DerefOf (Local2 [BRID])
                    }

                    Local2 = DerefOf (Local1 [Local3])
                }
                Else
                {
                    Local0 = 0x06
                }

                Local1 = Package (0x03){}
                Local1 [0x00] = Local0
                If ((Local0 == 0x00))
                {
                    Local1 [0x01] = 0x04
                    Local3 = Buffer (0x04){}
                    Local3 [0x00] = (Local2 & 0xFF)
                    Local3 [0x01] = ((Local2 >> 0x08) & 0xFF)
                    Local1 [0x02] = Local3
                }
                Else
                {
                    Local1 [0x01] = 0x00
                }

                Return (Local1)
            }

            Method (SBRT, 2, NotSerialized)
            {
                Local0 = BCL ()
                Local1 = Ones
                If ((Arg0 == 0x00))
                {
                    Local1 = Match (Local0, MEQ, Arg1, MTR, 0x00, 0x02)
                    If ((Local1 != Ones))
                    {
                        Local1 -= 0x02
                    }
                }
                ElseIf ((Arg0 == 0x01))
                {
                    If ((Arg1 < BRCT))
                    {
                        Local1 = Arg1
                    }
                }
                ElseIf ((Arg0 == 0x02))
                {
                    Local2 = DerefOf (NITS [BCLI])
                    Local3 = 0x00
                    While ((Local3 < BRCT))
                    {
                        If ((DerefOf (Local2 [(Local3 * 0x02)]) == Arg1))
                        {
                            Local1 = Local3
                            Local3 = 0xFF
                        }

                        Local3++
                    }
                }
                ElseIf ((Arg0 == 0x03))
                {
                    Local2 = BRLV /* \BRLV */
                    Local3 = BMAP /* \BMAP */
                    Local4 = 0x00
                    While ((Local4 < BRCT))
                    {
                        Local5 = Local4
                        If ((BCLI == 0x00))
                        {
                            Local5 = DerefOf (Local3 [Local4])
                        }

                        If ((DerefOf (Local2 [Local5]) == Arg1))
                        {
                            Local1 = Local4
                            Local4 = 0xFF
                        }

                        Local4++
                    }
                }

                Return (Local1)
            }

            Method (GEID, 0, NotSerialized)
            {
                Local0 = Package (0x03)
                    {
                        0x00, 
                        0x04, 
                        Buffer (0x0400){}
                    }
                Local0 [0x01] = 0x0400
                Local1 = EDID /* \EDID */
                Local2 = 0x00
                While ((Local2 < 0x0100))
                {
                    DerefOf (Local0 [0x02]) [Local2] = DerefOf (Local1 [
                        Local2])
                    Local2++
                }

                Return (Local0)
            }

            Name (NULL, "                                      ")
            Method (WQBC, 1, NotSerialized)
            {
                Local0 = 0x00
                Local1 = 0x00
                Local2 = 0x00
                Local3 = 0x00
                Local4 = 0x00
                Local5 = 0x00
                Local6 = 0x00
                Local7 = 0x00
                IWMP ()
                \_SB.SSMI (0xEA7B, 0x00, 0x01, Arg0, 0x00)
                If ((STAT == 0x80))
                {
                    DerefOf (BISE [Arg0]) [0x04] = 0x00
                }

                If ((FMOD == 0x00))
                {
                    Local3 = DerefOf (DerefOf (BISE [Arg0]) [0x00])
                    If ((\SRCM (Local3, "Virtualization Technology", 0x19) || \SRCM (Local3, "Virtualization Technology for Directed I/O", 0x2A)))
                    {
                        DerefOf (BISE [Arg0]) [0x05] = 0x01
                        DerefOf (BISE [Arg0]) [0x08] = "SELECT * FROM HP_BIOSPassword WHERE Name=\'Setup Password\' AND IsSet=1"
                    }

                    If (\SRCM (Local3, "Manufacturing Programming Mode", 0x1E))
                    {
                        DerefOf (BISE [Arg0]) [0x03] = 0x01
                    }
                }

                ST11 = DerefOf (DerefOf (BISE [Arg0]) [0x01])
                Local6 = SizeOf (ST11)
                Local3 = 0x00
                While ((Local3 != SizeOf (ST01)))
                {
                    ST01 [Local3] = 0x00
                    Local3++
                }

                Local3 = 0x01
                ST01 = DerefOf (DerefOf (BISE [Arg0]) [0x00])
                While ((Local4 != Local6))
                {
                    Local5 = DerefOf (ST11 [Local4])
                    If ((DerefOf (ST11 [Local4]) == 0x2C))
                    {
                        Local1++
                    }

                    If ((DerefOf (ST11 [Local4]) == 0x2A))
                    {
                        ST11 [Local4] = 0x20
                    }

                    Local4++
                }

                Local6 = EVAL /* \EVAL */
                Debug = "Instance = "
                Debug = Arg0
                Debug = "Enum Value from SMI = "
                Debug = Local6
                DerefOf (BISE [Arg0]) [0x0B] = ((Local6 & 
                    0xF0) >> 0x04)
                Local6 = (Local6 & 0x0F)
                Debug = "Setting Value from SMI = "
                Debug = Local6
                If ((Local1 == 0x01))
                {
                    If (\SRCM (ST01, "Internal Network Adapter Boot Mode", 0x22))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = RPEN /* \_SB_.RPEN */
                            DerefOf (BISE [Arg0]) [0x0C] = RPL /* \_SB_.RPL_ */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = PXEN /* \_SB_.PXEN */
                            DerefOf (BISE [Arg0]) [0x0C] = PXE /* \_SB_.PXE_ */
                        }
                    }

                    If (\SRCM (ST01, "Embedded Security Device Availability", 0x25))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = TPMA /* \_SB_.TPMA */
                            DerefOf (BISE [Arg0]) [0x0C] = AVA /* \_SB_.AVA_ */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = TPMH /* \_SB_.TPMH */
                            DerefOf (BISE [Arg0]) [0x0C] = HID /* \_SB_.HID_ */
                        }
                    }

                    If (\SRCM (ST01, "Terminal Emulation Mode", 0x17))
                    {
                        Local3 = 0x00
                        If ((Local6 == 0x01))
                        {
                            DerefOf (BISE [Arg0]) [0x01] = SETV /* \_SB_.SETV */
                            DerefOf (BISE [Arg0]) [0x0C] = V100 /* \_SB_.V100 */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = SETA /* \_SB_.SETA */
                            DerefOf (BISE [Arg0]) [0x0C] = ANSI /* \_SB_.ANSI */
                        }
                    }

                    If (\SRCM (ST01, "At least one symbol required", 0x1C))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = YESN /* \_SB_.YESN */
                            DerefOf (BISE [Arg0]) [0x0C] = YESY /* \_SB_.YESY */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = NYES /* \_SB_.NYES */
                            DerefOf (BISE [Arg0]) [0x0C] = NONO /* \_SB_.NONO */
                        }
                    }

                    If (\SRCM (ST01, "At least one number required", 0x1C))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = YESN /* \_SB_.YESN */
                            DerefOf (BISE [Arg0]) [0x0C] = YESY /* \_SB_.YESY */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = NYES /* \_SB_.NYES */
                            DerefOf (BISE [Arg0]) [0x0C] = NONO /* \_SB_.NONO */
                        }
                    }

                    If (\SRCM (ST01, "At least one upper case character required", 0x2A))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = YESN /* \_SB_.YESN */
                            DerefOf (BISE [Arg0]) [0x0C] = YESY /* \_SB_.YESY */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = NYES /* \_SB_.NYES */
                            DerefOf (BISE [Arg0]) [0x0C] = NONO /* \_SB_.NONO */
                        }
                    }

                    If (\SRCM (ST01, "At least one lower case character required", 0x2A))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = YESN /* \_SB_.YESN */
                            DerefOf (BISE [Arg0]) [0x0C] = YESY /* \_SB_.YESY */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = NYES /* \_SB_.NYES */
                            DerefOf (BISE [Arg0]) [0x0C] = NONO /* \_SB_.NONO */
                        }
                    }

                    If (\SRCM (ST01, "Are spaces allowed in password", 0x1E))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = YESN /* \_SB_.YESN */
                            DerefOf (BISE [Arg0]) [0x0C] = YESY /* \_SB_.YESY */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = NYES /* \_SB_.NYES */
                            DerefOf (BISE [Arg0]) [0x0C] = NONO /* \_SB_.NONO */
                        }
                    }

                    If (\SRCM (ST01, "SATA Device Mode", 0x10))
                    {
                        Local3 = 0x00
                        ST03 = DerefOf (NRDF [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x01] = BF2S /* \_SB_.BF2S */
                        ST03 = DerefOf (SMDE [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                    }

                    If (\SRCM (ST01, "NumLock on at boot", 0x12))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = ONST /* \_SB_.ONST */
                            DerefOf (BISE [Arg0]) [0x0C] = ONON /* \_SB_.ONON */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = OFST /* \_SB_.OFST */
                            DerefOf (BISE [Arg0]) [0x0C] = OFOF /* \_SB_.OFOF */
                        }
                    }

                    If (\SRCM (ST01, "Reset Authentication Credential", 0x1F))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = YESN /* \_SB_.YESN */
                            DerefOf (BISE [Arg0]) [0x0C] = YESY /* \_SB_.YESY */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = NYES /* \_SB_.NYES */
                            DerefOf (BISE [Arg0]) [0x0C] = NONO /* \_SB_.NONO */
                        }
                    }

                    If (\SRCM (ST01, "TPM Reset to Factory Defaults", 0x1D))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = YESN /* \_SB_.YESN */
                            DerefOf (BISE [Arg0]) [0x0C] = YESY /* \_SB_.YESY */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = NYES /* \_SB_.NYES */
                            DerefOf (BISE [Arg0]) [0x0C] = NONO /* \_SB_.NONO */
                        }
                    }

                    If (\SRCM (ST01, "Manufacturing Programming Mode", 0x1E))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = ULST /* \_SB_.ULST */
                            DerefOf (BISE [Arg0]) [0x0C] = UNLK /* \_SB_.UNLK */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = LKST /* \_SB_.LKST */
                            DerefOf (BISE [Arg0]) [0x0C] = LLCK /* \_SB_.LLCK */
                        }
                    }

                    If (\SRCM (ST01, "Express Card Link Speed", 0x17))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = LSG1 /* \_SB_.LSG1 */
                            DerefOf (BISE [Arg0]) [0x0C] = GEN1 /* \_SB_.GEN1 */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = LSG2 /* \_SB_.LSG2 */
                            DerefOf (BISE [Arg0]) [0x0C] = GEN2 /* \_SB_.GEN2 */
                        }
                    }

                    If (\SRCM (ST01, "DriveLock password on restart", 0x1D))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = DPRE /* \_SB_.DPRE */
                            DerefOf (BISE [Arg0]) [0x0C] = ENAD /* \_SB_.ENAD */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = DPRD /* \_SB_.DPRD */
                            DerefOf (BISE [Arg0]) [0x0C] = DISD /* \_SB_.DISD */
                        }
                    }

                    If (\SRCM (ST01, "Restore Defaults", 0x10))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = YESN /* \_SB_.YESN */
                            DerefOf (BISE [Arg0]) [0x0C] = YESY /* \_SB_.YESY */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = NYES /* \_SB_.NYES */
                            DerefOf (BISE [Arg0]) [0x0C] = NONO /* \_SB_.NONO */
                        }
                    }

                    If (\SRCM (ST01, "Reset BIOS security to factory default", 0x26))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = YESN /* \_SB_.YESN */
                            DerefOf (BISE [Arg0]) [0x0C] = YESY /* \_SB_.YESY */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = NYES /* \_SB_.NYES */
                            DerefOf (BISE [Arg0]) [0x0C] = NONO /* \_SB_.NONO */
                        }
                    }

                    If (\SRCM (ST01, "Max SATA Speed", 0x0E))
                    {
                        Local3 = 0x00
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = SSG2 /* \_SB_.SSG2 */
                            DerefOf (BISE [Arg0]) [0x0C] = SGN2 /* \_SB_.SGN2 */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = SSG3 /* \_SB_.SSG3 */
                            DerefOf (BISE [Arg0]) [0x0C] = SGN3 /* \_SB_.SGN3 */
                        }
                    }

                    If (Local3)
                    {
                        If (Local6)
                        {
                            DerefOf (BISE [Arg0]) [0x01] = ST08 /* \_SB_.ST08 */
                            DerefOf (BISE [Arg0]) [0x0C] = ST06 /* \_SB_.ST06 */
                        }
                        Else
                        {
                            DerefOf (BISE [Arg0]) [0x01] = ST09 /* \_SB_.ST09 */
                            DerefOf (BISE [Arg0]) [0x0C] = ST07 /* \_SB_.ST07 */
                        }
                    }
                }
                Else
                {
                    If ((Local1 == 0x02))
                    {
                        If (\SRCM (DerefOf (DerefOf (BISE [Arg0]) [0x0E]), CHGE, 
                            0x05))
                        {
                            Debug = "Policy Value = "
                            Debug = Local6
                            If ((Local6 == 0x01))
                            {
                                DerefOf (BISE [Arg0]) [0x01] = VSTR /* \_SB_.VSTR */
                                DerefOf (BISE [Arg0]) [0x0C] = VIEW /* \_SB_.VIEW */
                                Debug = "Policy = VIEW"
                            }

                            If ((Local6 == 0x02))
                            {
                                DerefOf (BISE [Arg0]) [0x01] = CSTR /* \_SB_.CSTR */
                                DerefOf (BISE [Arg0]) [0x0C] = CHGE /* \_SB_.CHGE */
                                Debug = "Policy = CHANGE"
                            }

                            If ((Local6 == 0x03))
                            {
                                DerefOf (BISE [Arg0]) [0x01] = HSTR /* \_SB_.HSTR */
                                DerefOf (BISE [Arg0]) [0x0C] = HIDE /* \_SB_.HIDE */
                                Debug = "Policy = HIDE"
                            }

                            Return (DerefOf (BISE [Arg0]))
                        }
                    }

                    TM01 = DerefOf (DerefOf (BISE [Arg0]) [0x00])
                    If ((RDSP && \SRCM (TM01, "SATA Device Mode", 0x10)))
                    {
                        ST03 = DerefOf (RDFD [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x01] = BF2S /* \_SB_.BF2S */
                        ST03 = DerefOf (SMDE [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                    }

                    If (\SRCM (TM01, "Virtualization Technology", 0x19))
                    {
                        ST03 = DerefOf (VTVL [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                    }

                    If (\SRCM (TM01, "Set All Security Levels", 0x17))
                    {
                        ST03 = DerefOf (SALL [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                    }

                    If (\SRCM (TM01, "Virtualization Technology for Directed I/O", 0x2A))
                    {
                        ST03 = DerefOf (VTDV [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                    }

                    If (\SRCM (TM01, "Wake on LAN", 0x0B))
                    {
                        Debug = "WOL values  "
                        ST03 = DerefOf (WOLV [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                    }

                    If (\SRCM (TM01, "Parallel port mode", 0x12))
                    {
                        If ((Local6 == 0x04))
                        {
                            Local6 = 0x03
                        }

                        Debug = "Getting parallel port mode "
                        ST03 = DerefOf (PPMD [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                        ST03 = DerefOf (PPMS [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x01] = BF2S /* \_SB_.BF2S */
                    }

                    If (\SRCM (TM01, "Set All Security Levels", 0x17))
                    {
                        Debug = "Set All Value = "
                        Debug = Local6
                        If ((Local6 == 0x00))
                        {
                            DerefOf (BISE [Arg0]) [0x01] = DALL /* \_SB_.DALL */
                        }

                        If ((Local6 == 0x02))
                        {
                            DerefOf (BISE [Arg0]) [0x01] = CALL /* \_SB_.CALL */
                        }

                        If ((Local6 == 0x01))
                        {
                            DerefOf (BISE [Arg0]) [0x01] = VALL /* \_SB_.VALL */
                        }

                        If ((Local6 == 0x03))
                        {
                            DerefOf (BISE [Arg0]) [0x01] = HALL /* \_SB_.HALL */
                        }

                        Return (DerefOf (BISE [Arg0]))
                    }

                    If (\SRCM (TM01, "Startup Menu Delay (Sec.)", 0x18))
                    {
                        If ((Local6 > 0x07))
                        {
                            Local6 >>= 0x05
                        }

                        ST03 = DerefOf (F12D [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                    }

                    If (\SRCM (TM01, "Disable charging port ", 0x16))
                    {
                        If ((Local6 > 0x09))
                        {
                            Local6 >>= 0x05
                        }

                        ST03 = DerefOf (BCPP [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                    }

                    If (\SRCM (TM01, "Multiboot Express Popup Delay(Sec)", 0x22))
                    {
                        If ((Local6 > 0x07))
                        {
                            Local6 >>= 0x05
                        }

                        ST03 = DerefOf (BPPD [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                    }

                    If (\SRCM (TM01, "Embedded Security Activation Policy", 0x23))
                    {
                        Local3 = 0x00
                        If ((Local6 == 0x00))
                        {
                            DerefOf (BISE [Arg0]) [0x01] = F1PS /* \_SB_.F1PS */
                            DerefOf (BISE [Arg0]) [0x0C] = F1PV /* \_SB_.F1PV */
                        }

                        If ((Local6 == 0x01))
                        {
                            DerefOf (BISE [Arg0]) [0x01] = F1F2 /* \_SB_.F1F2 */
                            DerefOf (BISE [Arg0]) [0x0C] = F12V /* \_SB_.F12V */
                        }

                        If ((Local6 == 0x02))
                        {
                            DerefOf (BISE [Arg0]) [0x01] = NOPS /* \_SB_.NOPS */
                            DerefOf (BISE [Arg0]) [0x0C] = NOPR /* \_SB_.NOPR */
                        }
                    }

                    If (\SRCM (TM01, "Language", 0x08))
                    {
                        ST03 = DerefOf (LANG [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                    }

                    If (\SRCM (TM01, "Backlit Keyboard Timeout", 0x18))
                    {
                        ST03 = DerefOf (BLKB [Local6])
                        BF2S = ST03 /* \_SB_.ST03 */
                        DerefOf (BISE [Arg0]) [0x0C] = BF2S /* \_SB_.BF2S */
                    }

                    Local1--
                    Debug = "Comma Count = "
                    Debug = Local1
                    Local4 = 0x00
                    If ((Local6 == 0x00))
                    {
                        ST11 [0x00] = 0x2A
                        Local0 = ST11 /* \_SB_.ST11 */
                    }
                    Else
                    {
                        While ((Local4 != SizeOf (ST11)))
                        {
                            If ((DerefOf (ST11 [Local4]) == 0x2C))
                            {
                                Local7++
                                If ((Local7 == Local6))
                                {
                                    Local4++
                                    ST11 [Local4] = 0x2A
                                }
                            }

                            Local4++
                        }
                    }

                    BF2S = ST11 /* \_SB_.ST11 */
                    DerefOf (BISE [Arg0]) [0x01] = BF2S /* \_SB_.BF2S */
                }

                Local4 = 0x00
                Return (DerefOf (BISE [Arg0]))
            }

            Method (WQBD, 1, NotSerialized)
            {
                Local0 = 0x00
                Local1 = 0x00
                Local2 = 0x00
                Local4 = 0x00
                Local5 = 0x00
                Local6 = 0x00
                Local7 = 0x00
                \_SB.SSMI (0xEA7B, 0x00, 0x02, 0x00, 0x00)
                If ((FMOD == 0x00))
                {
                    Local4 = 0x01
                    While ((Local4 && (Local2 < SizeOf (MPMS))))
                    {
                        Local3 = DerefOf (DerefOf (BSSS [Arg0]) [0x00])
                        If (\SRCM (Local3, DerefOf (MPMS [Local2]), SizeOf (Local3)))
                        {
                            DerefOf (BSSS [Arg0]) [0x03] = 0x01
                            Local4 = 0x00
                        }

                        Local2++
                    }

                    Local4 = 0x00
                }

                If ((Arg0 == 0x00))
                {
                    WTB2 = ASTG /* \ASTG */
                    CreateField (WTB2, 0x00, 0x0100, CAST)
                    BF2S = CAST /* \_SB_.WMID.WQBD.CAST */
                    DerefOf (BSSS [Arg0]) [0x0B] = ((STAT & 
                        0xF0) >> 0x04)
                }

                If ((Arg0 == 0x01))
                {
                    WTB2 = OWNT /* \OWNT */
                    CreateField (WTB2, 0x00, 0x0280, COWT)
                    BF2S = COWT /* \_SB_.WMID.WQBD.COWT */
                    DerefOf (BSSS [Arg0]) [0x0B] = ((STAT & 
                        0xF0) >> 0x04)
                }

                If ((Arg0 == 0x02))
                {
                    WTB2 = LFND /* \LFND */
                    CreateField (WTB2, 0x00, 0x0510, WLFD)
                    BF2S = WLFD /* \_SB_.WMID.WQBD.WLFD */
                    Local6 = EVAL /* \EVAL */
                    DerefOf (BSSS [Arg0]) [0x0B] = Local6
                }

                If ((Arg0 == 0x03))
                {
                    WTB2 = ATIM /* \ATIM */
                    CreateField (WTB2, 0x00, 0x28, WATM)
                    BF2S = WATM /* \_SB_.WMID.WQBD.WATM */
                }

                If ((Arg0 == 0x04))
                {
                    WTB2 = PCID /* \PCID */
                    CreateField (WTB2, 0x00, 0x0200, WPCD)
                    BF2S = WPCD /* \_SB_.WMID.WQBD.WPCD */
                }

                If ((Arg0 == 0x05))
                {
                    WTB2 = CURL /* \CURL */
                    CreateField (WTB2, 0x00, 0x0410, WURL)
                    BF2S = WURL /* \_SB_.WMID.WQBD.WURL */
                }

                If ((Arg0 == 0x06))
                {
                    WTB2 = PCVR /* \PCVR */
                    CreateField (WTB2, 0x00, 0x28, PCIV)
                    BF2S = PCIV /* \_SB_.WMID.WQBD.PCIV */
                }

                If ((Arg0 == 0x07))
                {
                    WTB2 = PROD /* \PROD */
                    CreateField (WTB2, 0x00, 0x0280, CRPD)
                    BF2S = CRPD /* \_SB_.WMID.WQBD.CRPD */
                }

                If ((Arg0 == 0x08))
                {
                    WTB2 = MODL /* \MODL */
                    CreateField (WTB2, 0x00, 0x0280, CMOD)
                    BF2S = CMOD /* \_SB_.WMID.WQBD.CMOD */
                }

                If ((Arg0 == 0x09))
                {
                    WTB2 = PTYP /* \PTYP */
                    CreateField (WTB2, 0x00, 0x0280, CCPU)
                    BF2S = CCPU /* \_SB_.WMID.WQBD.CCPU */
                }

                If ((Arg0 == 0x0A))
                {
                    WTB2 = PFRQ /* \PFRQ */
                    CreateField (WTB2, 0x00, 0x50, CFRQ)
                    BF2S = CFRQ /* \_SB_.WMID.WQBD.CFRQ */
                }

                If ((Arg0 == 0x0B))
                {
                    WTB2 = MEMS /* \_SB_.WMID.WQBD.MEMS */
                    CreateField (WTB2, 0x00, 0x0280, MEMS)
                    BF2S = MEMS /* \_SB_.WMID.WQBD.MEMS */
                }

                If ((Arg0 == 0x0C))
                {
                    WTB2 = DATE /* \DATE */
                    CreateField (WTB2, 0x00, 0x0280, CDAT)
                    BF2S = CDAT /* \_SB_.WMID.WQBD.CDAT */
                }

                If ((Arg0 == 0x0D))
                {
                    WTB2 = FAMI /* \FAMI */
                    CreateField (WTB2, 0x00, 0x0280, CFAM)
                    BF2S = CFAM /* \_SB_.WMID.WQBD.CFAM */
                }

                If ((Arg0 == 0x0E))
                {
                    WTB2 = SERL /* \SERL */
                    CreateField (WTB2, 0x00, 0x0280, CSER)
                    BF2S = CSER /* \_SB_.WMID.WQBD.CSER */
                }

                If ((Arg0 == 0x0F))
                {
                    WTB2 = VREV /* \VREV */
                    CreateField (WTB2, 0x00, 0x0280, CREV)
                    BF2S = CREV /* \_SB_.WMID.WQBD.CREV */
                }

                If ((Arg0 == 0x10))
                {
                    WTB2 = VRE2 /* \VRE2 */
                    CreateField (WTB2, 0x00, 0x0280, CRE2)
                    BF2S = CRE2 /* \_SB_.WMID.WQBD.CRE2 */
                }

                If ((Arg0 == 0x11))
                {
                    WTB2 = KBCD /* \KBCD */
                    CreateField (WTB2, 0x00, 0x0280, CKBC)
                    BF2S = CKBC /* \_SB_.WMID.WQBD.CKBC */
                }

                If ((Arg0 == 0x12))
                {
                    If ((STAT == 0x80))
                    {
                        DerefOf (BSSS [Arg0]) [0x04] = 0x00
                        BF2S = NOIN /* \_SB_.NOIN */
                    }
                    Else
                    {
                        WTB2 = HDDS /* \HDDS */
                        CreateField (WTB2, 0x00, 0xA8, WHDD)
                        BF2S = WHDD /* \_SB_.WMID.WQBD.WHDD */
                    }
                }

                If ((Arg0 == 0x13))
                {
                    If ((STAT == 0x80))
                    {
                        DerefOf (BSSS [Arg0]) [0x04] = 0x00
                        BF2S = NOIN /* \_SB_.NOIN */
                    }
                    Else
                    {
                        WTB2 = HDDM /* \HDDM */
                        CreateField (WTB2, 0x00, 0x0148, WHDM)
                        BF2S = WHDM /* \_SB_.WMID.WQBD.WHDM */
                    }
                }

                If ((Arg0 == 0x14))
                {
                    If ((STAT == 0x80))
                    {
                        DerefOf (BSSS [Arg0]) [0x04] = 0x00
                        BF2S = NOIN /* \_SB_.NOIN */
                    }
                    Else
                    {
                        WTB2 = CDAT /* \_SB_.WMID.WQBD.CDAT */
                        CreateField (WTB2, 0x00, 0x88, WCDT)
                        BF2S = WCDT /* \_SB_.WMID.WQBD.WCDT */
                    }
                }

                If ((Arg0 == 0x15))
                {
                    If ((STAT == 0x80))
                    {
                        DerefOf (BSSS [Arg0]) [0x04] = 0x00
                        BF2S = NOIN /* \_SB_.NOIN */
                    }
                    Else
                    {
                        WTB2 = CSTS /* \CSTS */
                        CreateByteField (WTB2, 0x00, WCST)
                        Local5 = WCST /* \_SB_.WMID.WQBD.WCST */
                        If ((Local5 == 0x00))
                        {
                            Local0 = 0x00
                            WTB4 = DerefOf (DSTS [Local0])
                            BF2S = WTB4 /* \_SB_.WTB4 */
                        }

                        If ((Local5 == 0xFF))
                        {
                            Local0 = 0x01
                            WTB4 = DerefOf (DSTS [Local0])
                            BF2S = WTB4 /* \_SB_.WTB4 */
                        }

                        If ((Local5 == 0xFE))
                        {
                            Local0 = 0x02
                            WTB4 = DerefOf (DSTS [Local0])
                            BF2S = WTB4 /* \_SB_.WTB4 */
                        }

                        If ((Local5 == 0xFD))
                        {
                            Local0 = 0x03
                            WTB4 = DerefOf (DSTS [Local0])
                            BF2S = WTB4 /* \_SB_.WTB4 */
                        }
                    }
                }

                If ((Arg0 == 0x16))
                {
                    If ((STAT == 0x80))
                    {
                        DerefOf (BSSS [Arg0]) [0x04] = 0x00
                        BF2S = NOIN /* \_SB_.NOIN */
                    }
                    Else
                    {
                        WTB2 = CYCL /* \CYCL */
                        CreateByteField (WTB2, 0x00, WCYC)
                        ToBCD (WCYC, Local1)
                        Local2 = 0x01
                        If ((WCYC <= 0x09))
                        {
                            Local2 = 0x01
                        }

                        If ((WCYC >= 0x0A))
                        {
                            Local2 = 0x02
                        }

                        If ((WCYC >= 0x64))
                        {
                            Local2 = 0x03
                        }

                        If ((WCYC >= 0x03E8))
                        {
                            Local2 = 0x04
                        }

                        If ((WCYC >= 0x2710))
                        {
                            Local2 = 0x05
                        }

                        Local3 = \ISTR (Local1, Local2)
                        BF2S = Local3
                    }
                }

                If ((Arg0 == 0x17))
                {
                    WTB2 = SVID /* \SVID */
                    CreateField (WTB2, 0x00, 0x50, CSID)
                    BF2S = CSID /* \_SB_.WMID.WQBD.CSID */
                }

                If ((Arg0 == 0x18))
                {
                    WTB2 = SKUN /* \SKUN */
                    CreateField (WTB2, 0x00, 0x80, CSKU)
                    BF2S = CSKU /* \_SB_.WMID.WQBD.CSKU */
                }

                If ((Arg0 == 0x19))
                {
                    WTB2 = SSID /* \SSID */
                    CreateField (WTB2, 0x00, 0x20, WSID)
                    BF2S = WSID /* \_SB_.WMID.WQBD.WSID */
                }

                If ((Arg0 == 0x1A))
                {
                    WTB2 = PBSN /* \PBSN */
                    CreateField (WTB2, 0x00, 0x90, WPSN)
                    BF2S = WPSN /* \_SB_.WMID.WQBD.WPSN */
                }

                If ((Arg0 == 0x1B))
                {
                    WTB2 = SBSN /* \SBSN */
                    CreateField (WTB2, 0x00, 0x90, WSSN)
                    BF2S = WSSN /* \_SB_.WMID.WQBD.WSSN */
                }

                If ((Arg0 == 0x1C))
                {
                    WTB2 = BTFC /* \BTFC */
                    CreateField (WTB2, 0x00, 0xA0, WBTF)
                    BF2S = WBTF /* \_SB_.WMID.WQBD.WBTF */
                }

                If ((Arg0 == 0x1D))
                {
                    WTB2 = WLFC /* \WLFC */
                    CreateField (WTB2, 0x00, 0xA0, WWLF)
                    BF2S = WWLF /* \_SB_.WMID.WQBD.WWLF */
                }

                If ((Arg0 == 0x1E))
                {
                    WTB2 = WWFC /* \WWFC */
                    CreateField (WTB2, 0x00, 0xA0, WWWF)
                    BF2S = WWWF /* \_SB_.WMID.WQBD.WWWF */
                }

                If ((Arg0 == 0x1F))
                {
                    WTB2 = GPFC /* \GPFC */
                    CreateField (WTB2, 0x00, 0xA0, WGPF)
                    BF2S = WGPF /* \_SB_.WMID.WQBD.WGPF */
                }

                If ((Arg0 == 0x20))
                {
                    WTB2 = UUID /* \UUID */
                    CreateField (WTB2, 0x00, 0x0100, WUUI)
                    BF2S = WUUI /* \_SB_.WMID.WQBD.WUUI */
                }

                If ((Arg0 == 0x21))
                {
                    WTB2 = CFID /* \CFID */
                    CreateField (WTB2, 0x00, 0xD0, WCFI)
                    BF2S = WCFI /* \_SB_.WMID.WQBD.WCFI */
                }

                If ((Arg0 == 0x22))
                {
                    WTB2 = SBCT /* \SBCT */
                    CreateField (WTB2, 0x00, 0x78, WBCT)
                    BF2S = WBCT /* \_SB_.WMID.WQBD.WBCT */
                }

                If ((Arg0 == 0x23))
                {
                    WTB2 = CPRV /* \CPRV */
                    CreateField (WTB2, 0x00, 0x78, WCRV)
                    BF2S = WCRV /* \_SB_.WMID.WQBD.WCRV */
                }

                If ((Arg0 == 0x24))
                {
                    If ((STAT == 0x80))
                    {
                        DerefOf (BSSS [Arg0]) [0x04] = 0x00
                        BF2S = NOIN /* \_SB_.NOIN */
                    }
                    Else
                    {
                        WTB2 = SNMD /* \SNMD */
                        CreateByteField (WTB2, 0x00, WSNM)
                        Local5 = WSNM /* \_SB_.WMID.WQBD.WSNM */
                        WTB4 = DerefOf (DSMD [Local5])
                        BF2S = WTB4 /* \_SB_.WTB4 */
                    }
                }

                If ((Arg0 == 0x25))
                {
                    WTB2 = MMS1 /* \MMS1 */
                    CreateField (WTB2, 0x00, 0x0280, WMS1)
                    BF2S = WMS1 /* \_SB_.WMID.WQBD.WMS1 */
                }

                If ((Arg0 == 0x26))
                {
                    If ((NMMS < 0x02))
                    {
                        DerefOf (BSSS [Arg0]) [0x04] = 0x00
                    }

                    WTB2 = MMS2 /* \MMS2 */
                    CreateField (WTB2, 0x00, 0x0280, WMS2)
                    BF2S = WMS2 /* \_SB_.WMID.WQBD.WMS2 */
                }

                If ((Arg0 == 0x27))
                {
                    If ((NMMS < 0x03))
                    {
                        DerefOf (BSSS [Arg0]) [0x04] = 0x00
                    }

                    WTB2 = MMS3 /* \MMS3 */
                    CreateField (WTB2, 0x00, 0x0280, WMS3)
                    BF2S = WMS3 /* \_SB_.WMID.WQBD.WMS3 */
                }

                If ((Arg0 == 0x28))
                {
                    If ((NMMS < 0x04))
                    {
                        DerefOf (BSSS [Arg0]) [0x04] = 0x00
                    }

                    WTB2 = MMS4 /* \MMS4 */
                    CreateField (WTB2, 0x00, 0x0280, WMS4)
                    BF2S = WMS4 /* \_SB_.WMID.WQBD.WMS4 */
                }

                DerefOf (BSSS [Arg0]) [0x01] = BF2S /* \_SB_.BF2S */
                Return (DerefOf (BSSS [Arg0]))
            }

            Method (WQBE, 1, NotSerialized)
            {
                Local1 = 0x00
                Local2 = 0x00
                Local4 = 0x00
                Local5 = 0x00
                Local6 = 0x00
                Local7 = 0x00
                If ((Arg0 == 0x00))
                {
                    \_SB.SSMI (0xEA7B, 0x00, 0x03, Arg0, 0x00)
                    DerefOf (BSOL [Arg0]) [0x0B] = ((STAT & 
                        0xF0) >> 0x04)
                    STAT &= 0x0F
                    WBOR = BORD /* \BORD */
                    CreateField (WBOR, 0x00, (0x09 * 0x08), CBOS)
                    While ((Local1 != 0x09))
                    {
                        Local4 = DerefOf (WBOR [Local1])
                        If ((Local4 != 0xFF))
                        {
                            Local5 = 0x00
                            While ((Local5 != 0x09))
                            {
                                Local7 = DerefOf (DerefOf (RMBI [Local5]) [0x00])
                                If ((Local4 == Local7))
                                {
                                    BF01 = DerefOf (DerefOf (RMBI [Local5]) [0x01])
                                    BF2S = BF01 /* \_SB_.BF01 */
                                    CRBI [Local6] = BF2S /* \_SB_.BF2S */
                                    Local6++
                                    Local5 = (0x09 - 0x01)
                                }

                                Local5++
                            }
                        }

                        Local1++
                    }

                    Local0 = 0x00
                    Local5 = 0x00
                    Local4 = 0x00
                    Local0 = 0x0D
                    While ((Local5 != 0x09))
                    {
                        BF01 = DerefOf (CRBI [Local5])
                        BF2S = BF01 /* \_SB_.BF01 */
                        DerefOf (BSOL [0x00]) [Local0] = BF2S /* \_SB_.BF2S */
                        Local5++
                        Local0++
                    }

                    Local1 = 0x00
                    Local2 = 0x00
                    While ((Local2 != 0x09))
                    {
                        BF01 = DerefOf (CRBI [Local2])
                        Local5 = 0x00
                        While ((DerefOf (BF01 [Local5]) != 0x00))
                        {
                            Local3 = DerefOf (BF01 [Local5])
                            BVAL [Local1] = Local3
                            Local5++
                            Local1++
                        }

                        BVAL [Local1] = 0x2C
                        Local1++
                        Local2++
                    }

                    Local2 = 0x00
                    While ((Local2 != 0x09))
                    {
                        BVAL [Local1] = 0x20
                        Local1++
                        BVAL [Local1] = 0x2C
                        Local1++
                        Local2++
                    }

                    BB2S = BVAL /* \_SB_.BVAL */
                    DerefOf (BSOL [0x00]) [0x01] = BB2S /* \_SB_.BB2S */
                }

                If ((Arg0 == 0x01))
                {
                    Local4 = IBUF ()
                    \_SB.SSMI (0xEA7B, 0x00, 0x08, Arg0, 0x00)
                    DerefOf (BSOL [Arg0]) [0x0B] = ((STAT & 
                        0xF0) >> 0x04)
                    STAT &= 0x0F
                    SUIP = WUFI /* \WUFI */
                    While ((Local1 != 0x03))
                    {
                        Local4 = DerefOf (SUIP [Local1])
                        If ((Local4 != 0xFF))
                        {
                            Local5 = 0x00
                            While ((Local5 != 0x03))
                            {
                                Local7 = DerefOf (DerefOf (UEBL [Local5]) [0x00])
                                If ((Local4 == Local7))
                                {
                                    BF01 = DerefOf (DerefOf (UEBL [Local5]) [0x01])
                                    BF2S = BF01 /* \_SB_.BF01 */
                                    CUBO [Local6] = BF2S /* \_SB_.BF2S */
                                    Local6++
                                    Local5 = (0x03 - 0x01)
                                }

                                Local5++
                            }
                        }

                        Local1++
                    }

                    Local0 = 0x00
                    Local5 = 0x00
                    Local4 = 0x00
                    Local0 = 0x0D
                    While ((Local5 != 0x03))
                    {
                        BF01 = DerefOf (CUBO [Local5])
                        BF2S = BF01 /* \_SB_.BF01 */
                        DerefOf (BSOL [Arg0]) [Local0] = BF2S /* \_SB_.BF2S */
                        Local5++
                        Local0++
                    }

                    Local1 = 0x00
                    Local2 = 0x00
                    While ((Local2 != 0x03))
                    {
                        BF01 = DerefOf (CUBO [Local2])
                        Local5 = 0x00
                        While ((DerefOf (BF01 [Local5]) != 0x00))
                        {
                            Local3 = DerefOf (BF01 [Local5])
                            BVAL [Local1] = Local3
                            Local5++
                            Local1++
                        }

                        BVAL [Local1] = 0x2C
                        Local1++
                        Local2++
                    }

                    Local2 = 0x00
                    While ((Local2 != 0x09))
                    {
                        BVAL [Local1] = 0x20
                        Local1++
                        BVAL [Local1] = 0x2C
                        Local1++
                        Local2++
                    }

                    BB2S = BVAL /* \_SB_.BVAL */
                    DerefOf (BSOL [Arg0]) [0x01] = BB2S /* \_SB_.BB2S */
                }

                Return (DerefOf (BSOL [Arg0]))
            }

            Method (ISSP, 0, NotSerialized)
            {
                Local0 = 0x00
                \_SB.SSMI (0xEA7B, 0x00, 0x04, 0x00, 0x00)
                If ((APST == 0x01))
                {
                    Local0 = 0x01
                }
                Else
                {
                    Local0 = 0x00
                }

                Return (Local0)
            }

            Method (PLOK, 1, NotSerialized)
            {
                Local1 = 0x00
                Local2 = 0x00
                If ((Arg0 == 0x00))
                {
                    While ((DerefOf (OAPW [Local1]) != 0x00))
                    {
                        Local1++
                    }

                    While ((DerefOf (NAPW [Local2]) != 0x00))
                    {
                        Local2++
                    }

                    If (((Local1 > 0x20) || (Local2 > 0x20)))
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x01)
                    }
                }

                Return (0x00)
            }

            Method (GBID, 0, NotSerialized)
            {
                Local1 = 0x00
                Local4 = 0x00
                Local5 = 0x00
                Local6 = 0x00
                Local7 = 0x64
                Local2 = SizeOf (BOIN)
                Local2--
                While ((Local4 != Local2))
                {
                    Local1 = 0x00
                    While ((Local1 != SizeOf (TEMP)))
                    {
                        TEMP [Local1] = 0x00
                        Local1++
                    }

                    Local1 = 0x00
                    While ((Local1 != 0x14))
                    {
                        TEMP [Local1] = DerefOf (BOIN [Local4])
                        If (((DerefOf (BOIN [Local4]) == 0x2C) || (DerefOf (
                            BOIN [Local4]) == 0x00)))
                        {
                            Local1 = 0x13
                        }

                        Local1++
                        Local4++
                    }

                    If ((DerefOf (BOIN [Local4]) != 0x00))
                    {
                        Local3 = FNID ()
                        If ((Local3 != 0xFF))
                        {
                            BOID [Local6] = Local3
                        }

                        Local6++
                    }
                    Else
                    {
                        Local4 = Local2
                    }
                }

                Return (Local7)
            }

            Method (FNID, 0, NotSerialized)
            {
                Local3 = 0xFF
                If ((\SRCM (TEMP, "Notebook Upgrade Bay", 0x14) || \SRCM (TEMP, " Notebook Upgrade Bay", SizeOf (STG0))))
                {
                    Local3 = 0x01
                }

                If ((\SRCM (TEMP, "Notebook Upgrade Bay (UEFI)", 0x1B) || \SRCM (TEMP, " Notebook Upgrade Bay (UEFI)", SizeOf (STG0))))
                {
                    Local3 = 0x01
                }

                If ((\SRCM (TEMP, "OS Boot Manager", 0x0F) || \SRCM (TEMP, " OS Boot Manager", SizeOf (STG0))))
                {
                    Local3 = 0x02
                }

                If ((\SRCM (TEMP, "Notebook Hard Drive", 0x13) || \SRCM (TEMP, " Notebook Hard Drive ", 0x15)))
                {
                    Local3 = 0x02
                }

                If ((\SRCM (TEMP, "Hard Drive 2", 0x0C) || \SRCM (TEMP, " Hard Drive 2", SizeOf (STG0))))
                {
                    Local3 = 0x0C
                }

                If ((\SRCM (TEMP, "USB Floppy", 0x0A) || \SRCM (TEMP, " USB Floppy", SizeOf (STG0))))
                {
                    Local3 = 0x03
                }

                If ((\SRCM (TEMP, "USB CD-ROM", 0x0A) || \SRCM (TEMP, " USB CD-ROM", SizeOf (STG0))))
                {
                    Local3 = 0x05
                }

                If ((\SRCM (TEMP, "USB Hard Drive", 0x0E) || \SRCM (TEMP, " USB Hard Drive", SizeOf (STG0))))
                {
                    Local3 = 0x06
                }

                If ((\SRCM (TEMP, "Notebook Ethernet", 0x11) || \SRCM (TEMP, " Notebook Ethernet ", SizeOf (STG0))))
                {
                    Local3 = 0x07
                }

                If ((\SRCM (TEMP, "SD Card", 0x07) || \SRCM (TEMP, " SD Card ", 0x09)))
                {
                    Local3 = 0x08
                }

                If ((\SRCM (TEMP, "Dock Upgrade Bay", 0x10) || \SRCM (TEMP, " Dock Upgrade Bay ", 0x12)))
                {
                    Local3 = 0x0A
                }

                If ((\SRCM (TEMP, "eSATA Drive", 0x0B) || \SRCM (TEMP, " eSATA Drive ", 0x0D)))
                {
                    Local3 = 0x0B
                }

                If ((\SRCM (TEMP, "Notebook Ethernet (", 0x13) || \SRCM (TEMP, " Notebook Ethernet (U", 0x15)))
                {
                    Local3 = 0x03
                }

                Return (Local3)
            }

            Method (WQBF, 1, NotSerialized)
            {
                If ((Arg0 == 0x00))
                {
                    If ((ISSP () == 0x01))
                    {
                        DerefOf (BSPV [0x00]) [0x10] = 0x01
                        DerefOf (BSPV [0x00]) [0x11] = SPSF /* \SPSF */
                    }
                    Else
                    {
                        DerefOf (BSPV [0x00]) [0x10] = 0x00
                        DerefOf (BSPV [0x00]) [0x11] = 0xFFFFFFFF
                    }

                    \_SB.SSMI (0xEA7B, 0x00, 0x06, 0x00, 0x00)
                    DerefOf (BSPV [0x00]) [0x0C] = PWDL /* \PWDL */
                }
                Else
                {
                    \_SB.SSMI (0xEA7B, 0x00, 0x07, Arg0, 0x00)
                }

                Return (DerefOf (BSPV [Arg0]))
            }

            Method (WQBG, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA7B, 0x00, 0x06, 0x00, 0x00)
                If ((FMOD == 0x00))
                {
                    Local1 = 0x00
                    Local2 = 0x00
                    Local3 = 0x01
                    While ((Local3 && (Local1 < SizeOf (MPMI))))
                    {
                        Local2 = DerefOf (MPMI [Local1])
                        If ((Arg0 == Local2))
                        {
                            DerefOf (BSIN [Arg0]) [0x03] = 0x01
                            Local3 = 0x00
                        }
                        ElseIf ((Arg0 < Local2))
                        {
                            Local3 = 0x00
                        }

                        Local1++
                    }

                    Local3 = 0x00
                }

                Local4 = 0x00
                If ((Arg0 == 0x00))
                {
                    Local4 = PWDL /* \PWDL */
                }

                If ((Arg0 == 0x01))
                {
                    Local4 = MPMC /* \MPMC */
                }

                DerefOf (BSIN [Arg0]) [0x0E] = Local4
                If ((Local4 <= 0x09))
                {
                    Local2 = 0x01
                }
                Else
                {
                    Local2 = 0x02
                }

                ToBCD (Local4, Local1)
                Local3 = \ISTR (Local1, Local2)
                BF2S = Local3
                DerefOf (BSIN [Arg0]) [0x01] = BF2S /* \_SB_.BF2S */
                Return (DerefOf (BSIN [Arg0]))
            }

            Method (WQBH, 0, NotSerialized)
            {
            }

            Method (WQBI, 0, NotSerialized)
            {
            }

            Method (WQBJ, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA7B, 0x02, Arg0, 0x00, 0x00)
                If ((STAT == 0x00))
                {
                    BF2S = USRN /* \USRN */
                    DerefOf (BUSR [Arg0]) [0x00] = BF2S /* \_SB_.BF2S */
                    DerefOf (BUSR [Arg0]) [0x10] = ROLE /* \ROLE */
                    CreateDWordField (HASH, 0x00, HSH1)
                    If ((HSH1 != 0x00))
                    {
                        DerefOf (BUSR [Arg0]) [0x11] = 0x01
                        If ((Arg0 == 0x00))
                        {
                            DerefOf (BUSR [Arg0]) [0x12] = SPSF /* \SPSF */
                        }
                        Else
                        {
                            DerefOf (BUSR [Arg0]) [0x12] = 0x00
                        }
                    }
                    Else
                    {
                        DerefOf (BUSR [Arg0]) [0x11] = 0x00
                    }
                }
                Else
                {
                    DerefOf (BUSR [Arg0]) [0x00] = NULL /* \_SB_.WMID.NULL */
                    DerefOf (BUSR [0x00]) [0x10] = 0x00
                    DerefOf (BUSR [Arg0]) [0x11] = 0x00
                }

                Return (DerefOf (BUSR [Arg0]))
            }

            Method (USPP, 0, NotSerialized)
            {
                Local0 = 0x00
                \_SB.SSMI (0xEA7B, 0x00, 0x05, 0x00, 0x00)
                If ((SECO == 0x01))
                {
                    Local0 = 0x01
                }
                Else
                {
                    Local0 = 0x00
                }

                Return (Local0)
            }

            Method (ZPBF, 0, NotSerialized)
            {
                Local3 = 0x00
                While ((Local3 != SizeOf (PCBF)))
                {
                    PCBF [Local3] = 0x00
                    Local3++
                }

                Return (0x00)
            }

            Method (PARP, 0, NotSerialized)
            {
                Return (0x00)
            }

            Method (WMBH, 1, NotSerialized)
            {
                Return (0x00)
            }

            Method (WMBA, 3, NotSerialized)
            {
                IWMP ()
                If ((Arg1 == 0x01))
                {
                    Local0 = Arg2
                    Local1 = SizeOf (Local0)
                    Local2 = 0x00
                    Local4 = DerefOf (Local0 [Local2])
                    Local2++
                    Local2++
                    Local5 = 0x00
                    Local6 = 0x00
                    Local3 = 0x00
                    Local3 = IBUF ()
                    While ((Local5 != Local4))
                    {
                        ST01 [Local6] = DerefOf (Local0 [Local2])
                        Local2++
                        Local5++
                        Local6++
                        Local2++
                        Local5++
                    }

                    Local4 = DerefOf (Local0 [Local2])
                    Local2++
                    Local2++
                    Local5 = 0x00
                    Local6 = 0x00
                    PCHG [0x00] = 0x00
                    If ((\SRCM (ST01, "Legacy Boot Order Security Level", 0x20) || \SRCM (ST01, "UEFI Boot Order Security Level", 0x1E)))
                    {
                        Local5 = 0x00
                    }
                    ElseIf ((\SRCM (ST01, "Legacy Boot Order", 0x11) || \SRCM (ST01, "UEFI Boot Order", 0x0F)))
                    {
                        Local2--
                        Local4 += (DerefOf (Local0 [Local2]) * 0x0100)
                        Local2++
                        While ((Local5 != Local4))
                        {
                            BOIN [Local6] = DerefOf (Local0 [Local2])
                            Local2++
                            Local5++
                            Local6++
                            Local2++
                            Local5++
                        }

                        If ((Local5 == Local4))
                        {
                            Local4 = 0x00
                        }
                    }

                    If (\SRCM (ST01, "Setup Password", 0x0E))
                    {
                        While ((Local5 != Local4))
                        {
                            PCBF [Local6] = DerefOf (Local0 [Local2])
                            Local2++
                            Local5++
                            Local6++
                        }

                        NAPW = PCBF /* \_SB_.PCBF */
                        Local4 = DerefOf (Local0 [Local2])
                        Local2++
                        Local2++
                        Local5 = 0x00
                        Local6 = 0x00
                        Local3 = ZPBF ()
                        While ((Local5 != Local4))
                        {
                            PCBF [Local6] = DerefOf (Local0 [Local2])
                            Local2++
                            Local5++
                            Local6++
                        }

                        OAPW = PCBF /* \_SB_.PCBF */
                        \_SB.SSMI (0xEA7B, 0x01, 0x04, 0x0400, 0x00)
                        If ((STAT == 0x00))
                        {
                            Debug = "SUCCESS from SMI !"
                            ETYP [0x00] = 0x00
                            Notify (\_SB.WMID, 0xA0) // Device-Specific
                        }

                        If ((STAT == 0x06))
                        {
                            Debug = "ACCESS_DENIED error from SMI "
                            ETYP [0x00] = 0x01
                            Notify (\_SB.WMID, 0xA0) // Device-Specific
                        }

                        Return (STAT) /* \STAT */
                    }

                    If (\SRCM (ST01, "Notebook hard drive drivelock master password", 0x2D))
                    {
                        STAT = HDDL (Local0, Local2, Local4, 0x00)
                        Return (STAT) /* \STAT */
                    }

                    If (\SRCM (ST01, "Notebook hard drive drivelock user password", 0x2B))
                    {
                        STAT = HDDL (Local0, Local2, Local4, 0x01)
                        Return (STAT) /* \STAT */
                    }

                    If (\SRCM (ST01, "Upgrade bay hard drive drivelock master password", 0x30))
                    {
                        STAT = HDDL (Local0, Local2, Local4, 0x02)
                        Return (STAT) /* \STAT */
                    }

                    If (\SRCM (ST01, "Upgrade bay hard drive drivelock user password", 0x2E))
                    {
                        STAT = HDDL (Local0, Local2, Local4, 0x03)
                        Return (STAT) /* \STAT */
                    }

                    Local5 = 0x00
                    Local6 = 0x00
                    VFSZ [0x00] = Local4
                    While ((Local5 != Local4))
                    {
                        ST02 [Local6] = DerefOf (Local0 [Local2])
                        Local2++
                        Local5++
                        Local6++
                        Local2++
                        Local5++
                    }

                    Local4 = DerefOf (Local0 [Local2])
                    If (((ISSP () == 0x01) && (Local4 == 0x00)))
                    {
                        ETYP [0x00] = 0x01
                        Notify (\_SB.WMID, 0xA0) // Device-Specific
                        Return (0x06)
                    }

                    Local2++
                    Local2++
                    Local5 = 0x00
                    Local6 = 0x00
                    Local3 = ZPBF ()
                    While ((Local5 != Local4))
                    {
                        PCBF [Local6] = DerefOf (Local0 [Local2])
                        Local2++
                        Local5++
                        Local6++
                    }

                    OAPW = PCBF /* \_SB_.PCBF */
                    Local7 = 0x00
                    Local4 = 0x00
                    Local2 = 0x00
                    Local5 = 0xCE
                    While ((Local5 != Local4))
                    {
                        ST14 = DerefOf (DerefOf (BISE [Local4]) [0x00])
                        If (\SRCM (ST01, ST14, SizeOf (ST14)))
                        {
                            Local4 = 0xCE
                            Local4--
                            Local2 = 0x01
                        }

                        Local7++
                        Local4++
                    }

                    Local7--
                    If ((\SRCM (ST01, "Legacy Boot Order Security Level", 0x20) || \SRCM (ST01, "UEFI Boot Order Security Level", 0x1E)))
                    {
                        Local2 = 0x01
                    }
                    Else
                    {
                        If (\SRCM (ST01, "Legacy Boot Order", 0x11))
                        {
                            Local2 = 0x03
                        }

                        If (\SRCM (ST01, "UEFI Boot Order", 0x0F))
                        {
                            Local2 = 0x08
                        }
                    }

                    Debug = ST01 /* \_SB_.ST01 */
                    If ((\SRCM (ST01, "Password Minimum Length", 0x17) || \SRCM (ST01, "Manufacturing Programming Mode Counter", 0x26)))
                    {
                        Local2 = 0x06
                        Debug = ST02 /* \_SB_.ST02 */
                        If ((DerefOf (VFSZ [0x00]) == 0x04))
                        {
                            CreateByteField (ST02, 0x00, HIGB)
                            CreateByteField (ST02, 0x01, LOWB)
                            Local4 = (HIGB - 0x30)
                            Debug = HIGB /* \_SB_.WMID.WMBA.HIGB */
                            Local5 = (LOWB - 0x30)
                            Debug = LOWB /* \_SB_.WMID.WMBA.LOWB */
                            Local4 = (Local5 + (Local4 * 0x0A))
                        }
                        Else
                        {
                            CreateByteField (ST02, 0x00, MINL)
                            Local4 = (MINL - 0x30)
                        }

                        Debug = Local4
                        If (\SRCM (ST01, "Password Minimum Length", 0x17))
                        {
                            If (((Local4 >= 0x04) && (Local4 <= 0x20)))
                            {
                                PWDL = Local4
                                FLAG [0x00] = 0x00
                                Local7 = 0x00
                            }
                            Else
                            {
                                STAT = 0x05
                                Return (STAT) /* \STAT */
                            }
                        }

                        If (\SRCM (ST01, "Manufacturing Programming Mode Counter", 0x26))
                        {
                            If (FMOD)
                            {
                                If (((Local4 >= 0x00) && (Local4 <= 0x0A)))
                                {
                                    MPMC = Local4
                                    FLAG [0x00] = 0x00
                                    Local7 = 0x01
                                    If ((Local4 == 0x0A))
                                    {
                                        \_SB.SSMI (0xEA7B, 0x01, 0x61, 0x0100, 0x00)
                                        FMOD = 0x00
                                    }
                                }
                                Else
                                {
                                    STAT = 0x05
                                    Return (STAT) /* \STAT */
                                }
                            }
                            Else
                            {
                                STAT = 0x01
                                Return (STAT) /* \STAT */
                            }
                        }

                        Local6 = 0x06
                        Local6 <<= 0x08
                    }

                    If ((Local2 == 0x00))
                    {
                        Local7 = 0x00
                        Local4 = 0x00
                        While ((Local4 < 0x29))
                        {
                            ST14 = DerefOf (DerefOf (BSSS [Local4]) [0x00])
                            Debug = ST14 /* \_SB_.ST14 */
                            If (\SRCM (ST01, ST14, SizeOf (ST14)))
                            {
                                Local4 = 0x29
                                Local2 = 0x02
                            }

                            Local7++
                            Local4++
                        }

                        Local7--
                    }

                    If ((Local2 == 0x01))
                    {
                        Debug = "Setting belongs to enumeration class"
                        If (FMOD)
                        {
                            If (\SRCM (ST01, "Manufacturing Programming Mode", 0x1E))
                            {
                                If (\SRCM (ST02, UNLK, 0x06))
                                {
                                    FLAG [0x00] = 0x05
                                }

                                If (\SRCM (ST02, LLCK, 0x04))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                    FMOD = 0x00
                                }
                            }
                        }
                        ElseIf (\SRCM (ST01, "Manufacturing Programming Mode", 0x1E))
                        {
                            If ((\SRCM (ST02, UNLK, 0x06) || \SRCM (ST02, LLCK, 0x04)))
                            {
                                FLAG [0x00] = 0x05
                            }
                        }

                        If (\SRCM (ST02, ONON, 0x02))
                        {
                            Local6 = 0x01
                            FLAG [0x00] = 0x00
                        }

                        If (\SRCM (ST02, OFOF, 0x03))
                        {
                            Local6 = 0x00
                            FLAG [0x00] = 0x00
                        }

                        If (\SRCM (ST02, YESY, 0x03))
                        {
                            Local6 = 0x01
                            FLAG [0x00] = 0x00
                            PCHG [0x00] = 0x01
                        }

                        If (\SRCM (ST02, NONO, 0x02))
                        {
                            Local6 = 0x00
                            FLAG [0x00] = 0x00
                            PCHG [0x00] = 0x01
                        }

                        If (\SRCM (ST02, DFLT, SizeOf (DFLT)))
                        {
                            Local6 = 0x00
                            Debug = "Changing policy setting to VIEW"
                            FLAG [0x00] = 0x00
                            If (\SRCM (ST01, "Set All Security Levels", 0x17))
                            {
                                PCHG [0x00] = 0x00
                            }
                            Else
                            {
                                PCHG [0x00] = 0x01
                            }
                        }

                        If (\SRCM (ST02, VIEW, SizeOf (VIEW)))
                        {
                            Local6 = 0x01
                            Debug = "Changing policy setting to VIEW"
                            FLAG [0x00] = 0x00
                            If (\SRCM (ST01, "Set All Security Levels", 0x17))
                            {
                                PCHG [0x00] = 0x00
                            }
                            Else
                            {
                                PCHG [0x00] = 0x01
                            }
                        }

                        If (\SRCM (ST02, CHGE, SizeOf (CHGE)))
                        {
                            Local6 = 0x02
                            Debug = "Changing policy setting to CHANGE"
                            FLAG [0x00] = 0x00
                            If (\SRCM (ST01, "Set All Security Levels", 0x17))
                            {
                                PCHG [0x00] = 0x00
                            }
                            Else
                            {
                                PCHG [0x00] = 0x01
                            }
                        }

                        If (\SRCM (ST02, HIDE, SizeOf (HIDE)))
                        {
                            Local6 = 0x03
                            FLAG [0x00] = 0x00
                            Debug = "Changing policy setting to HIDE"
                            If (\SRCM (ST01, "Set All Security Levels", 0x17))
                            {
                                PCHG [0x00] = 0x00
                            }
                            Else
                            {
                                PCHG [0x00] = 0x01
                            }
                        }

                        If ((\SRCM (ST01, "Language", 0x08) || \SRCM (ST01, "Restore Defaults", 0x10)))
                        {
                            PCHG [0x00] = 0x00
                        }
                        ElseIf (\SRCM (ST01, "Reset BIOS security to factory default", 0x26))
                        {
                            PCHG [0x00] = 0x00
                        }

                        If ((DerefOf (PCHG [0x00]) == 0x01))
                        {
                            Local1 = 0x01
                            If (FMOD)
                            {
                                If ((\SRCM (ST01, "Reset Authentication Credential", 0x1F) || \SRCM (ST01, "TPM Reset to Factory Defaults", 0x1D)))
                                {
                                    Local1 = 0x00
                                }
                            }

                            Debug = "Setting has a dependency "
                            If ((Local1 && (ISSP () == 0x00)))
                            {
                                Debug = "BIOS Admin and/or PT user present"
                                STAT = 0x8001
                                Return (STAT) /* \STAT */
                            }
                        }

                        If (\SRCM (ST02, ST06, SizeOf (ST06)))
                        {
                            Local6 = 0x01
                            FLAG [0x00] = 0x00
                        }
                        ElseIf (\SRCM (ST02, ST07, SizeOf (ST07)))
                        {
                            Local6 = 0x00
                            FLAG [0x00] = 0x00
                        }
                        Else
                        {
                            If (\SRCM (ST01, "Wake on LAN", 0x0B))
                            {
                                Debug = "WOL values  "
                                If (\SRCM (ST02, "Disable", 0x07))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Boot to Network", 0x0F))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Follow Boot Order", 0x11))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Parallel port mode", 0x12))
                            {
                                If (\SRCM (ST02, "Standard", 0x08))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Bidirectional", 0x0D))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "EPP", 0x03))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "ECP", 0x03))
                                {
                                    Local6 = 0x04
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Startup Menu Delay (Sec.)", 0x18))
                            {
                                If (\SRCM (ST02, "0", 0x01))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "5", 0x01))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "10", 0x02))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "15", 0x02))
                                {
                                    Local6 = 0x03
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "20", 0x02))
                                {
                                    Local6 = 0x04
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "25", 0x02))
                                {
                                    Local6 = 0x05
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "30", 0x02))
                                {
                                    Local6 = 0x06
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "35", 0x02))
                                {
                                    Local6 = 0x07
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Multiboot Express Popup Delay(Sec)", 0x22))
                            {
                                If (\SRCM (ST02, "0", 0x01))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "5", 0x01))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "10", 0x02))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "15", 0x02))
                                {
                                    Local6 = 0x03
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "20", 0x02))
                                {
                                    Local6 = 0x04
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "25", 0x02))
                                {
                                    Local6 = 0x05
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "30", 0x02))
                                {
                                    Local6 = 0x06
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "35", 0x02))
                                {
                                    Local6 = 0x07
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Internal Network Adapter Boot Mode", 0x22))
                            {
                                If (\SRCM (ST02, "PXE", 0x03))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "RPL", 0x03))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Virtualization Technology", 0x19))
                            {
                                If (\SRCM (ST02, "Reset to default", 0x10))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Virtualization Technology for Directed I/O", 0x2A))
                            {
                                If (\SRCM (ST02, "Reset to default", 0x10))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Disable charging port in all sleep/off states below(%):", 0x37))
                            {
                                If (\SRCM (ST02, "0", 0x01))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "10", 0x02))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "20", 0x02))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "30", 0x02))
                                {
                                    Local6 = 0x03
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "40", 0x02))
                                {
                                    Local6 = 0x04
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "50", 0x02))
                                {
                                    Local6 = 0x05
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "60", 0x02))
                                {
                                    Local6 = 0x06
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "70", 0x02))
                                {
                                    Local6 = 0x07
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "80", 0x02))
                                {
                                    Local6 = 0x08
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "90", 0x02))
                                {
                                    Local6 = 0x09
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "100", 0x03))
                                {
                                    Local6 = 0x0A
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "SATA Device Mode", 0x10))
                            {
                                If (\SRCM (ST02, "AHCI", 0x04))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "IDE", 0x03))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }

                                If ((RDSP && \SRCM (ST02, "RAID", 0x04)))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Embedded Security Device Availability", 0x25))
                            {
                                If (\SRCM (ST02, "Available", 0x09))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Hidden", 0x06))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Embedded Security Activation Policy", 0x23))
                            {
                                If (\SRCM (ST02, "F1 to Boot", 0x0A))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Allow user to reject", 0x14))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "No prompts", 0x0A))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Terminal Emulation Mode", 0x17))
                            {
                                If (\SRCM (ST02, "ANSI", 0x04))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "VT100", 0x05))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Language", 0x08))
                            {
                                If (\SRCM (ST02, "English", 0x07))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Francais", 0x08))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Deutsch", 0x07))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Espanol", 0x07))
                                {
                                    Local6 = 0x03
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Italiano", 0x08))
                                {
                                    Local6 = 0x04
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Dansk", 0x05))
                                {
                                    Local6 = 0x05
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Nederlands", 0x0A))
                                {
                                    Local6 = 0x06
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Suomi", 0x05))
                                {
                                    Local6 = 0x07
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Japanese", 0x08))
                                {
                                    Local6 = 0x08
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Norsk", 0x05))
                                {
                                    Local6 = 0x09
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Portugues", 0x09))
                                {
                                    Local6 = 0x0A
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Svenska", 0x07))
                                {
                                    Local6 = 0x0B
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "NumLock on at boot", 0x12))
                            {
                                If (\SRCM (ST02, "On", 0x02))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Off", 0x03))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Backlit Keyboard Timeout", 0x18))
                            {
                                Debug = "Backlit Keyboard Timeout values  "
                                If (\SRCM (ST02, "5 secs.", 0x07))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "15 secs.", 0x08))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "30 secs.", 0x08))
                                {
                                    Local6 = 0x02
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "1 min.", 0x06))
                                {
                                    Local6 = 0x03
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "5 mins.", 0x07))
                                {
                                    Local6 = 0x04
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Never", 0x08))
                                {
                                    Local6 = 0x05
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Express Card Link Speed", 0x17))
                            {
                                If (\SRCM (ST02, "Generation 1", 0x0C))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Generation 2", 0x0C))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "DriveLock password on restart", 0x1D))
                            {
                                If (\SRCM (ST02, "Enabled", 0x07))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "Disabled", 0x08))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }
                            }

                            If (\SRCM (ST01, "Restore Defaults", 0x10))
                            {
                                If (\SRCM (ST02, "Yes", 0x03))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                    \_SB.SSMI (0xEA7C, 0x00, 0x00, 0x00, 0x00)
                                    If ((STAT == 0x00))
                                    {
                                        Debug = "SUCCESS from SMI !"
                                        ETYP [0x00] = 0x00
                                        Notify (\_SB.WMID, 0xA0) // Device-Specific
                                    }

                                    If ((STAT == 0x06))
                                    {
                                        Debug = "ACCESS_DENIED error from SMI "
                                        ETYP [0x00] = 0x01
                                        Notify (\_SB.WMID, 0xA0) // Device-Specific
                                    }
                                }
                            }

                            If (\SRCM (ST01, "Max SATA Speed", 0x0E))
                            {
                                If (\SRCM (ST02, "6.0 Gbps", 0x08))
                                {
                                    Local6 = 0x00
                                    FLAG [0x00] = 0x00
                                }

                                If (\SRCM (ST02, "3.0 Gbps", 0x08))
                                {
                                    Local6 = 0x01
                                    FLAG [0x00] = 0x00
                                }
                            }
                        }

                        Local6 &= 0xFF
                        Local3 = 0x01
                        Local6 |= (Local3 << 0x08)
                    }

                    If ((Local2 == 0x02))
                    {
                        Debug = "Setting belongs to string class"
                        Local4 = 0x00
                        Local5 = 0x02
                        If ((FMOD == 0x00))
                        {
                            While ((Local4 < SizeOf (MPMS)))
                            {
                                If (\SRCM (ST01, DerefOf (MPMS [Local4]), SizeOf (ST01)))
                                {
                                    STAT = 0x01
                                    Return (STAT) /* \STAT */
                                }

                                Local4++
                            }

                            Local4 = 0x00
                        }

                        While ((Local4 < SizeOf (TROS)))
                        {
                            If (\SRCM (ST01, DerefOf (TROS [Local4]), SizeOf (ST01)))
                            {
                                STAT = 0x01
                                Return (STAT) /* \STAT */
                            }

                            Local4++
                        }

                        Local4 = 0x00
                        Local7 = 0x00
                        If (\SRCM (ST01, "Notebook Asset Tag", SizeOf (ST01)))
                        {
                            BF2S = ST02 /* \_SB_.ST02 */
                            Local4 = 0x00
                            Local5 = 0x00
                            Local1 = 0x00
                            Local1 = SizeOf (ST02)
                            While ((Local5 != Local1))
                            {
                                If ((DerefOf (ST02 [Local4]) == 0x00))
                                {
                                    Local5 = SizeOf (ST02)
                                    Local5--
                                }

                                Local4++
                                Local5++
                            }

                            Local4--
                            If ((Local4 > 0x12))
                            {
                                FLAG [0x00] = 0x05
                            }
                            Else
                            {
                                FLAG [0x00] = 0x00
                            }

                            ASTL = Local4
                            WATS = ST02 /* \_SB_.ST02 */
                            ASTG = WATS /* \_SB_.WATS */
                            WTB3 = ASTG /* \ASTG */
                        }

                        If (\SRCM (ST01, "Notebook Ownership Tag", SizeOf (ST01)))
                        {
                            Local1 = 0x00
                            While ((Local1 != 0x50))
                            {
                                WONT [Local1] = DerefOf (ST02 [Local1])
                                Local1++
                            }

                            OWNT = WONT /* \_SB_.WONT */
                            Local7 = 0x01
                            FLAG [0x00] = 0x00
                        }

                        Debug = "Checkpoint 1"
                        If (\SRCM (ST01, "Set Alarm Time", SizeOf (ST01)))
                        {
                            Debug = "Alarm time values"
                            Local1 = 0x00
                            While ((Local1 != 0x05))
                            {
                                TATM [Local1] = DerefOf (ST02 [Local1])
                                Local1++
                            }

                            ATIM = TATM /* \_SB_.TATM */
                            Local7 = 0x03
                            FLAG [0x00] = 0x00
                            Debug = ATIM /* \ATIM */
                        }

                        If (\SRCM (ST01, "PCID", 0x04))
                        {
                            Debug = "PCID values"
                            Local1 = 0x00
                            While ((Local1 != 0x40))
                            {
                                TPCD [Local1] = 0x00
                                Local1++
                            }

                            Local1 = 0x00
                            While ((Local1 != 0x40))
                            {
                                TPCD [Local1] = DerefOf (ST02 [Local1])
                                Local1++
                            }

                            PCID = TPCD /* \_SB_.TPCD */
                            Local7 = 0x04
                            FLAG [0x00] = 0x00
                            Debug = PCID /* \PCID */
                        }

                        If (\SRCM (ST01, "Serial Number", 0x0D))
                        {
                            Debug = "Serial Number"
                            Local1 = 0x00
                            While ((Local1 < SizeOf (TBUF)))
                            {
                                TBUF [Local1] = DerefOf (ST02 [Local1])
                                Local1++
                            }

                            SERL = TBUF /* \_SB_.TBUF */
                            Local7 = 0x06
                            FLAG [0x00] = 0x00
                            Debug = SERL /* \SERL */
                        }

                        If (\SRCM (ST01, "Product Number", 0x0E))
                        {
                            Debug = "Product Number"
                            Local1 = 0x00
                            While ((Local1 < SizeOf (TSKU)))
                            {
                                TSKU [Local1] = DerefOf (ST02 [Local1])
                                Local1++
                            }

                            SKUN = TSKU /* \_SB_.TSKU */
                            Local7 = 0x07
                            FLAG [0x00] = 0x00
                            Debug = SKUN /* \SKUN */
                        }

                        If (\SRCM (ST01, "Notebook Model", 0x0E))
                        {
                            Debug = "Notebook Model"
                            Local1 = 0x00
                            While ((Local1 < SizeOf (TBUF)))
                            {
                                TBUF [Local1] = DerefOf (ST02 [Local1])
                                Local1++
                            }

                            MODL = TBUF /* \_SB_.TBUF */
                            Local7 = 0x08
                            FLAG [0x00] = 0x00
                            Debug = MODL /* \MODL */
                        }

                        If (\SRCM (ST01, "System Board CT", 0x0F))
                        {
                            Debug = "System Board CT"
                            Local1 = 0x00
                            While ((Local1 != SizeOf (TBCT)))
                            {
                                TBCT [Local1] = 0x00
                                Local1++
                            }

                            Local1 = 0x00
                            While ((Local1 < (SizeOf (TBCT) - 0x01)))
                            {
                                TBCT [Local1] = DerefOf (ST02 [Local1])
                                Local1++
                            }

                            SBCT = TBCT /* \_SB_.TBCT */
                            Local7 = 0x09
                            FLAG [0x00] = 0x00
                            Debug = SBCT /* \SBCT */
                        }

                        If (\SRCM (ST01, "Define Custom URL", 0x11))
                        {
                            Debug = "Custom URL value"
                            Local1 = 0x00
                            While ((Local1 != 0x82))
                            {
                                TURL [Local1] = 0x00
                                Local1++
                            }

                            Local1 = 0x00
                            While ((Local1 != 0x82))
                            {
                                TURL [Local1] = DerefOf (ST02 [Local1])
                                Local1++
                            }

                            CURL = TURL /* \_SB_.TURL */
                            Local7 = 0x05
                            FLAG [0x00] = 0x00
                            Debug = CURL /* \CURL */
                        }

                        Local6 = 0x02
                        Local6 <<= 0x08
                    }

                    If ((Local2 == 0x03))
                    {
                        Debug = "Setting belongs to ordered list class"
                        Local1 = 0x00
                        Local2 = 0x00
                        Local3 = 0x00
                        Local4 = 0x00
                        Local5 = 0x00
                        Local6 = 0x00
                        Local7 = 0x00
                        \_SB.SSMI (0xEA7B, 0x00, 0x03, 0x00, 0x00)
                        Local2 = 0x00
                        WSIP = BORD /* \BORD */
                        Local1 = GBID ()
                        DVAL [0x00] = 0x00
                        While ((Local2 < 0x64))
                        {
                            Local5 = 0x00
                            Local6 = 0x00
                            While ((Local6 < 0x09))
                            {
                                If ((DerefOf (BOID [Local2]) == DerefOf (WSIP [Local5])))
                                {
                                    DVAL [0x00] = 0x01
                                    Local6 = (0x09 - 0x01)
                                }

                                Local5++
                                Local6++
                            }

                            Local5--
                            If ((DerefOf (DVAL [0x00]) == 0x01))
                            {
                                Local4 = Local5
                                Local4--
                                While ((Local5 > Local3))
                                {
                                    WSIP [Local5] = DerefOf (WSIP [Local4])
                                    Local5--
                                    Local4--
                                }

                                WSIP [Local3] = DerefOf (BOID [Local2])
                                Local3++
                            }

                            Local2++
                            DVAL [0x00] = 0x00
                        }

                        BORD = WSIP /* \_SB_.WSIP */
                        FLAG [0x00] = 0x00
                        Local7 = 0x00
                        Local6 = 0x03
                        Local6 <<= 0x08
                    }

                    If ((Local2 == 0x08))
                    {
                        Debug = "Setting belongs to uefi ordered list class"
                        Local1 = 0x00
                        Local2 = 0x00
                        Local3 = 0x00
                        Local4 = 0x00
                        Local5 = 0x00
                        Local6 = 0x00
                        Local7 = 0x00
                        \_SB.SSMI (0xEA7B, 0x00, 0x08, 0x00, 0x00)
                        Local2 = 0x00
                        SUIP = WUFI /* \WUFI */
                        Local1 = GBID ()
                        DVAL [0x00] = 0x00
                        While ((Local2 < 0x64))
                        {
                            Local5 = 0x00
                            Local6 = 0x00
                            While ((Local6 < 0x03))
                            {
                                If ((DerefOf (BOID [Local2]) == DerefOf (SUIP [Local5])))
                                {
                                    DVAL [0x00] = 0x01
                                    Local6 = (0x03 - 0x01)
                                }

                                Local5++
                                Local6++
                            }

                            Local5--
                            If ((DerefOf (DVAL [0x00]) == 0x01))
                            {
                                Local4 = Local5
                                Local4--
                                While ((Local5 > Local3))
                                {
                                    SUIP [Local5] = DerefOf (SUIP [Local4])
                                    Local5--
                                    Local4--
                                }

                                SUIP [Local3] = DerefOf (BOID [Local2])
                                Local3++
                            }

                            Local2++
                            DVAL [0x00] = 0x00
                        }

                        WUFI = SUIP /* \_SB_.SUIP */
                        Debug = "UEFI Boot order to SMI ="
                        Debug = WUFI /* \WUFI */
                        FLAG [0x00] = 0x00
                        Local7 = 0x00
                        Local6 = 0x08
                        Local6 <<= 0x08
                    }

                    If ((Local2 == 0x00))
                    {
                        STAT = 0x01
                        Debug = "Setting not found !"
                        Return (STAT) /* \STAT */
                    }

                    If ((DerefOf (FLAG [0x00]) == 0x05))
                    {
                        STAT = 0x05
                        Return (STAT) /* \STAT */
                    }

                    If ((Local2 != 0x00))
                    {
                        Debug = "Issuing SW SMI "
                        \_SB.SSMI (0xEA7B, 0x01, Local7, Local6, 0x00)
                        If ((STAT == 0x00))
                        {
                            Debug = "SUCCESS from SMI !"
                            ETYP [0x00] = 0x00
                            Notify (\_SB.WMID, 0xA0) // Device-Specific
                        }

                        If ((STAT == 0x06))
                        {
                            Debug = "ACCESS_DENIED error from SMI "
                            ETYP [0x00] = 0x01
                            Notify (\_SB.WMID, 0xA0) // Device-Specific
                        }
                    }

                    Return (STAT) /* \STAT */
                }

                If ((Arg1 == 0x02))
                {
                    Debug = "Enter restore defaults "
                    Local0 = Arg2
                    Local1 = SizeOf (Local0)
                    Local2 = 0x00
                    Local4 = DerefOf (Local0 [Local2])
                    Local2++
                    Local2++
                    Local5 = 0x00
                    Local6 = 0x00
                    Local3 = 0x00
                    Local3 = ZPBF ()
                    If ((ISSP () == 0x01))
                    {
                        While ((Local5 != Local4))
                        {
                            PCBF [Local6] = DerefOf (Local0 [Local2])
                            Local2++
                            Local5++
                            Local6++
                        }

                        OAPW = PCBF /* \_SB_.PCBF */
                        Local4 = DerefOf (Local0 [Local2])
                        Local2++
                        Local2++
                        Local5 = 0x00
                        Local6 = 0x00
                        While ((Local5 != Local4))
                        {
                            STG1 [Local6] = DerefOf (Local0 [Local2])
                            Local2++
                            Local5++
                            Local6++
                            Local2++
                            Local5++
                        }
                    }

                    If (\SRCM (STG1, "true", 0x04))
                    {
                        Debug = "Policy defaults true "
                        \_SB.SSMI (0xEA7C, 0x01, 0x00, 0x00, 0x00)
                        If ((STAT == 0x00))
                        {
                            Debug = "SUCCESS from SMI !"
                            ETYP [0x00] = 0x00
                            Notify (\_SB.WMID, 0xA0) // Device-Specific
                        }

                        If ((STAT == 0x06))
                        {
                            Debug = "ACCESS_DENIED error from SMI "
                            ETYP [0x00] = 0x01
                            Notify (\_SB.WMID, 0xA0) // Device-Specific
                        }

                        Return (STAT) /* \STAT */
                    }
                    Else
                    {
                        Debug = "Policy defaults false "
                        \_SB.SSMI (0xEA7C, 0x00, 0x00, 0x00, 0x00)
                        If ((STAT == 0x00))
                        {
                            Debug = "SUCCESS from SMI !"
                            ETYP [0x00] = 0x00
                            Notify (\_SB.WMID, 0xA0) // Device-Specific
                        }

                        If ((STAT == 0x06))
                        {
                            Debug = "ACCESS_DENIED error from SMI "
                            ETYP [0x00] = 0x01
                            Notify (\_SB.WMID, 0xA0) // Device-Specific
                        }

                        Return (STAT) /* \STAT */
                    }
                }
                Else
                {
                    STAT = 0x05
                    Return (STAT) /* \STAT */
                }
            }

            Method (IBUF, 0, NotSerialized)
            {
                Local3 = 0x00
                STAT = 0x05
                While ((Local3 != SizeOf (ST01)))
                {
                    ST01 [Local3] = 0x00
                    Local3++
                }

                Local3 = 0x00
                While ((Local3 != SizeOf (ST02)))
                {
                    ST02 [Local3] = 0x00
                    Local3++
                }

                Local3 = 0x00
                While ((Local3 != SizeOf (ST03)))
                {
                    ST03 [Local3] = 0x00
                    Local3++
                }

                Local3 = 0x00
                While ((Local3 != SizeOf (BOIN)))
                {
                    BOIN [Local3] = 0x00
                    Local3++
                }

                Local3 = 0x00
                While ((Local3 != SizeOf (BOID)))
                {
                    BOID [Local3] = 0xFF
                    Local3++
                }

                Local3 = 0x00
                While ((Local3 != SizeOf (WSPS)))
                {
                    WSPS [Local3] = 0x00
                    WNWP [Local3] = 0x00
                    WPPS [Local3] = 0x00
                    WNPP [Local3] = 0x00
                    Local3++
                }

                Local3 = 0x00
                While ((Local3 != SizeOf (PCBF)))
                {
                    PCBF [Local3] = 0x00
                    Local3++
                }

                Local3 = 0x00
                While ((Local3 != SizeOf (ST11)))
                {
                    ST11 [Local3] = 0x00
                    Local3++
                }

                OAPW = WSPS /* \_SB_.WSPS */
                NAPW = WNWP /* \_SB_.WNWP */
                Local3 = 0x00
                While ((Local3 != SizeOf (BVAL)))
                {
                    BVAL [Local3] = 0x00
                    Local3++
                }

                Local3 = 0x00
                While ((Local3 != SizeOf (BF01)))
                {
                    BF01 [Local3] = 0x00
                    Local3++
                }

                Local3 = 0x00
                While ((Local3 != 0x03))
                {
                    SUIP [Local3] = 0x00
                    Local3++
                }

                Return (0x00)
            }

            Method (WMAC, 3, NotSerialized)
            {
                If ((Arg1 == 0x01))
                {
                    Local0 = Arg2
                    Local1 = SizeOf (Local0)
                    Local2 = 0x00
                    Local4 = DerefOf (Local0 [Local2])
                    Local2++
                    Local2++
                    Local5 = 0x00
                    Local6 = 0x00
                    Local3 = 0x00
                    If ((Local4 > 0x40))
                    {
                        STAT = 0x05
                        Return (STAT) /* \STAT */
                    }

                    Local3 = 0x00
                    While ((Local3 != SizeOf (BUFU)))
                    {
                        BUFU [Local3] = 0x00
                        Local3++
                    }

                    Divide (Local4, 0x02, Local3, Local1)
                    Local3 = 0x00
                    While ((Local5 != Local4))
                    {
                        BUFU [Local6] = DerefOf (Local0 [Local2])
                        Local2++
                        Local5++
                        Local6++
                        Local2++
                        Local5++
                    }

                    Local5 = (Local1 & 0x01)
                    If ((Local5 == 0x00))
                    {
                        Local4 = DerefOf (Local0 [Local2])
                        Local2++
                        Local2++
                    }

                    USRN = BUFU /* \_SB_.BUFU */
                    Local5 = 0x00
                    Local6 = 0x00
                    CreateDWordField (Local0, Local2, WROL)
                    ROLE = WROL /* \_SB_.WMID.WMAC.WROL */
                    Local2 += 0x04
                    CreateDWordField (Local0, Local2, WCMD)
                    CMDV = WCMD /* \_SB_.WMID.WMAC.WCMD */
                    Local2 += 0x04
                    CreateDWordField (Local0, Local2, WKBD)
                    KBDL = WKBD /* \_SB_.WMID.WMAC.WKBD */
                    Local2 += 0x04
                    Local4 = DerefOf (Local0 [Local2])
                    Local2++
                    Local2++
                    Local3 = ZPBF ()
                    OAPW = PCBF /* \_SB_.PCBF */
                    NAPW = PCBF /* \_SB_.PCBF */
                    Local5 = 0x00
                    Local6 = 0x00
                    Local3 = 0x00
                    While ((Local5 != Local4))
                    {
                        PCBF [Local6] = DerefOf (Local0 [Local2])
                        Local2++
                        Local5++
                        Local6++
                    }

                    OAPW = PCBF /* \_SB_.PCBF */
                    Local4 = DerefOf (Local0 [Local2])
                    Local2++
                    Local2++
                    Local5 = 0x00
                    Local6 = 0x00
                    Local3 = ZPBF ()
                    While ((Local5 != Local4))
                    {
                        PCBF [Local6] = DerefOf (Local0 [Local2])
                        Local2++
                        Local5++
                        Local6++
                    }

                    NAPW = PCBF /* \_SB_.PCBF */
                    \_SB.SSMI (0xEA7B, 0x03, CMDV, 0x00, 0x00)
                    If ((STAT == 0x00))
                    {
                        Debug = "SUCCESS from SMI !"
                        ETYP [0x00] = 0x00
                        Notify (\_SB.WMID, 0xA0) // Device-Specific
                    }

                    If ((STAT == 0x06))
                    {
                        Debug = "ACCESS_DENIED error from SMI "
                        ETYP [0x00] = 0x01
                        Notify (\_SB.WMID, 0xA0) // Device-Specific
                    }

                    Return (STAT) /* \STAT */
                }
                Else
                {
                    STAT = 0x05
                    Return (STAT) /* \STAT */
                }
            }

            Method (STLN, 1, NotSerialized)
            {
                Local0 = Arg0
                Local1 = 0x00
                While ((Local1 != SizeOf (Local0)))
                {
                    Local2 = DerefOf (Local0 [Local1])
                    If ((Local2 == 0x00))
                    {
                        Local1 = SizeOf (Local0)
                    }
                    Else
                    {
                        Local1++
                    }
                }

                Return (Local1)
            }

            Method (HDDL, 4, NotSerialized)
            {
                Local0 = Arg0
                Local2 = Arg1
                Local4 = Arg2
                Local3 = Arg3
                Local6 = 0x00
                Local5 = 0x00
                While ((Local5 != Local4))
                {
                    PCBF [Local6] = DerefOf (Local0 [Local2])
                    Local2++
                    Local5++
                    Local6++
                }

                NAPW = PCBF /* \_SB_.PCBF */
                Local4 = DerefOf (Local0 [Local2])
                Local2++
                Local2++
                Local5 = 0x00
                Local6 = 0x00
                Local1 = ZPBF ()
                While ((Local5 != Local4))
                {
                    PCBF [Local6] = DerefOf (Local0 [Local2])
                    Local2++
                    Local5++
                    Local6++
                }

                OAPW = PCBF /* \_SB_.PCBF */
                Debug = OAPW /* \OAPW */
                Debug = NAPW /* \NAPW */
                \_SB.SSMI (0xEA7B, 0x01, Local3, 0x0700, 0x00)
                If ((STAT == 0x00))
                {
                    Debug = "SUCCESS from SMI !"
                    ETYP [0x00] = 0x00
                    Notify (\_SB.WMID, 0xA0) // Device-Specific
                }
                Else
                {
                    Debug = "Error from SMI !"
                }

                If ((STAT == 0x06))
                {
                    Debug = "ACCESS_DENIED error from SMI "
                    ETYP [0x00] = 0x01
                    Notify (\_SB.WMID, 0xA0) // Device-Specific
                }

                Return (STAT) /* \STAT */
            }

            Name (THCT, Buffer (0x06)
            {
                 0x01, 0x01, 0x03, 0x01, 0x01, 0x02               // ......
            })
            Name (PRFI, Buffer (0x06)
            {
                 0x00, 0x08, 0x0C, 0x14, 0x18, 0x1C               // ......
            })
            Name (TSTM, 0x00)
            Name (TSTV, Package (0x06)
            {
                Buffer (0x01)
                {
                     0xFF                                             // .
                }, 

                Buffer (0x01)
                {
                     0xFF                                             // .
                }, 

                Buffer (0x03)
                {
                     0xFF, 0xFF, 0xFF                                 // ...
                }, 

                Buffer (0x01)
                {
                     0xFF                                             // .
                }, 

                Buffer (0x01)
                {
                     0xFF                                             // .
                }, 

                Buffer (0x02)
                {
                     0xFF, 0xFF                                       // ..
                }
            })
            Method (WMAA, 3, Serialized)
            {
                Debug = "WMAA Enter"
                Return (WHCM (Arg1, Arg2))
            }

            Method (WGDD, 0, NotSerialized)
            {
                Debug = "GetDisplayDevices"
                Local1 = VGDD (0x01)
                If ((Local1 == 0xFFFF))
                {
                    Return (Package (0x02)
                    {
                        0x04, 
                        0x00
                    })
                }
                Else
                {
                    Local2 = (Local1 & 0x1F)
                    If ((Local1 & 0xFFE0))
                    {
                        Local2 |= 0x20
                    }

                    Local0 = Package (0x03)
                        {
                            0x00, 
                            0x04, 
                            Buffer (0x04){}
                        }
                    DerefOf (Local0 [0x02]) [0x00] = Local2
                    DerefOf (Local0 [0x02]) [0x01] = 0x01
                    DerefOf (Local0 [0x02]) [0x02] = 0x01
                    Return (Local0)
                }
            }

            Method (WSDD, 1, NotSerialized)
            {
                Debug = "SETDisplayDevices"
                Debug = Arg0
                Local0 = (Arg0 & 0x1F)
                If ((Arg0 & 0x20))
                {
                    Local1 = (WDST & 0xFFE0)
                    If (FindSetRightBit (Local1, Local2))
                    {
                        Local3 = (0x01 << Local2--)
                        Local0 |= Local3
                    }
                }

                Debug = Local0
                Debug = WDPE /* \WDPE */
                If ((VSDD (Local0) == 0xFFFF))
                {
                    Return (Package (0x02)
                    {
                        0x04, 
                        0x00
                    })
                }
                Else
                {
                    Return (Package (0x02)
                    {
                        0x00, 
                        0x00
                    })
                }
            }

            Method (WGHP, 0, NotSerialized)
            {
                Return (Package (0x02)
                {
                    0x04, 
                    0x00
                })
            }

            Method (WITH, 1, NotSerialized)
            {
                Return (Package (0x02)
                {
                    0x04, 
                    0x00
                })
            }

            Method (WALS, 0, NotSerialized)
            {
                Return (Package (0x02)
                {
                    0x04, 
                    0x00
                })
            }

            Method (WSAL, 1, NotSerialized)
            {
                Return (Package (0x02)
                {
                    0x04, 
                    0x00
                })
            }

            Method (WGDS, 0, NotSerialized)
            {
                Local0 = Package (0x03)
                    {
                        0x00, 
                        0x01, 
                        Buffer (0x01)
                        {
                             0x00                                             // .
                        }
                    }
                If (\_SB.DCKD ())
                {
                    Local0 = Package (0x03)
                        {
                            0x00, 
                            0x01, 
                            Buffer (0x01)
                            {
                                 0x01                                             // .
                            }
                        }
                }

                Return (Local0)
            }

            Method (WGWS, 0, NotSerialized)
            {
                Local2 = Package (0x03){}
                Local2 [0x00] = 0x00
                Local2 [0x01] = 0x50
                Local2 [0x02] = WLDA /* \WLDA */
                Return (Local2)
            }

            Method (WSWS, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x1B, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SBBC, 1, NotSerialized)
            {
                Return (Package (0x02)
                {
                    0x04, 
                    0x00
                })
            }

            Method (WGBI, 1, NotSerialized)
            {
                If ((Arg0 < SizeOf (NBTI)))
                {
                    Return (\_SB.PCI0.LPCB.EC0.GBTI (Arg0))
                }
                Else
                {
                    Return (Package (0x02)
                    {
                        0x06, 
                        0x00
                    })
                }
            }

            Method (WGBN, 0, NotSerialized)
            {
                Debug = "Return Bezel function table"
                Local0 = 0x10
                Local0 += 0x02
                Local1 = Buffer (0x0A)
                    {
                        /* 0000 */  0x31, 0x01, 0xAE, 0x01, 0x9E, 0x01, 0xB6, 0x01,  // 1.......
                        /* 0008 */  0xB7, 0x01                                       // ..
                    }
                Concatenate (Local1, Buffer (0x08)
                    {
                         0xFF, 0xFF, 0x9B, 0x21, 0xA9, 0x21, 0x00, 0x00   // ...!.!..
                    }, Local2)
                Local3 = Package (0x03){}
                Local3 [0x00] = 0x00
                Local3 [0x01] = Local0
                Local3 [0x02] = Local2
                Return (Local3)
            }

            Method (GHKS, 0, NotSerialized)
            {
                Local0 = Package (0x03)
                    {
                        0x00, 
                        0x04, 
                        Buffer (0x04){}
                    }
                DerefOf (Local0 [0x02]) [0x00] = \_SB.PCI0.LPCB.EC0.GSHK ()
                Return (Local0)
            }

            Method (SHKS, 1, NotSerialized)
            {
                \_SB.PCI0.LPCB.EC0.SSHK (Arg0)
                Debug = "SHK VALUE"
                Debug = \_SB.PCI0.LPCB.EC0.SHK
                Return (Package (0x02)
                {
                    0x00, 
                    0x00
                })
            }

            Method (FUF4, 1, NotSerialized)
            {
                Local0 = (Arg0 & 0x1F)
                Local1 = (Arg0 & 0xFFE0)
                If (Local1)
                {
                    Local0 |= 0x20
                    FindSetRightBit (Local1, Local2)
                    Local3 = (0x01 << Local2--)
                    Local1 &= ~Local3
                    If (Local1)
                    {
                        Local0 |= 0x10
                    }
                }

                Return (Local0)
            }

            Method (HKFR, 0, NotSerialized)
            {
                Debug = "HotkeyFunctionResponse"
                Local0 = Package (0x03)
                    {
                        0x00, 
                        0x04, 
                        Buffer (0x04){}
                    }
                Local2 = ASMB /* \ASMB */
                Local1 = DerefOf (Local2 [0x00])
                If ((Local1 == 0x0D))
                {
                    DerefOf (Local0 [0x02]) [0x00] = 0x31
                    DerefOf (Local0 [0x02]) [0x01] = 0x01
                }

                If ((Local1 == 0x04))
                {
                    Debug = "VideoGetDisplayDevices enter"
                    VGDD (0x00)
                    DerefOf (Local0 [0x02]) [0x00] = 0xAE
                    DerefOf (Local0 [0x02]) [0x01] = 0x01
                    Local3 = FUF4 (WDGN)
                    Local4 = FUF4 (WDSA)
                    DerefOf (Local0 [0x02]) [0x02] = Local3
                    DerefOf (Local0 [0x02]) [0x03] = Local4
                    Debug = "Next Display devices variable"
                    Debug = WDGN /* \WDGN */
                    Debug = "Current active Display Devices Variable"
                    Debug = WDSA /* \WDSA */
                    Debug = "VideoGetDisplayDevices exit"
                }

                If ((Local1 == 0x05))
                {
                    DerefOf (Local0 [0x02]) [0x00] = 0x9D
                    DerefOf (Local0 [0x02]) [0x01] = 0x01
                }

                If ((Local1 == 0x06))
                {
                    DerefOf (Local0 [0x02]) [0x00] = 0x9E
                    DerefOf (Local0 [0x02]) [0x01] = 0x01
                }

                If (((Local1 == 0x02) || (Local1 == 0x03)))
                {
                    If ((Local1 == 0x02))
                    {
                        Local1 = 0x09
                    }
                    ElseIf ((Local1 == 0x03))
                    {
                        Local1 = 0x0A
                    }

                    \_GPE.VBRE (Local1)
                    DerefOf (Local0 [0x02]) [0x00] = (0xAD + Local1)
                    DerefOf (Local0 [0x02]) [0x01] = 0x01
                    If ((WDPE & 0x40))
                    {
                        Wait (\_SB.BEVT, 0x10)
                    }

                    DerefOf (Local0 [0x02]) [0x02] = BRID /* \BRID */
                    DerefOf (Local0 [0x02]) [0x03] = DerefOf (Local2 [
                        0x03])
                }

                Return (Local0)
            }

            Method (GHKF, 0, NotSerialized)
            {
                Debug = WDPE /* \WDPE */
                Debug = WDSA /* \WDSA */
                Debug = WDST /* \WDST */
                Debug = WDGN /* \WDGN */
                Reset (\_SB.BEVT)
                Reset (\_SB.F4EV)
                \_SB.SSMI (0xEA75, 0x01, 0x0A, 0x574D4953, 0x00)
                Debug = DID1 /* \DID1 */
                Debug = WDSA /* \WDSA */
                Debug = WDST /* \WDST */
                Debug = WDGN /* \WDGN */
                Return (HKFR ())
            }

            Method (SHKF, 1, NotSerialized)
            {
                Reset (\_SB.BEVT)
                Reset (\_SB.F4EV)
                \_SB.SSMI (0xEA75, 0x02, 0x0A, 0x574D4953, 0x00)
                Return (HKFR ())
            }

            Method (WGBV, 0, NotSerialized)
            {
                Local0 = Package (0x03)
                    {
                        0x00, 
                        0x04, 
                        Buffer (0x04){}
                    }
                Local1 = WLBN /* \WLBN */
                WLBN = 0x00
                If ((Local1 == 0x01))
                {
                    DerefOf (Local0 [0x02]) [0x00] = 0x9B
                    DerefOf (Local0 [0x02]) [0x01] = 0x21
                }

                If ((Local1 == 0x02))
                {
                    DerefOf (Local0 [0x02]) [0x00] = 0x9A
                    DerefOf (Local0 [0x02]) [0x01] = 0x21
                }

                If ((Local1 == 0x03))
                {
                    Local2 = \_SB.PCI0.LPCB.EC0.TP
                    DerefOf (Local0 [0x02]) [0x00] = 0xA9
                    DerefOf (Local0 [0x02]) [0x01] = 0x21
                    DerefOf (Local0 [0x02]) [0x02] = Local2
                    DerefOf (Local0 [0x02]) [0x03] = 0x00
                }

                Return (Local0)
            }

            Method (GSAS, 0, NotSerialized)
            {
                Local0 = Package (0x03)
                    {
                        0x00, 
                        0x04, 
                        Buffer (0x04){}
                    }
                Local1 = \_SB.PCI0.LPCB.EC0.GPID ()
                Local1 += 0x01
                DerefOf (Local0 [0x02]) [0x00] = Local1
                Return (Local0)
            }

            Method (GSRV, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x10, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GVPR, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x11, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GBRS, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x12, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SSRV, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x10, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GWPT, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x14, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SWPT, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x14, 0x574D4953, 0x00)
                Local1 = WFDA ()
                HWWB ()
                Return (Local1)
            }

            Method (HWWB, 0, NotSerialized)
            {
                Local0 = BT0P /* \_SB_.BT0P */
                If ((Local0 != 0x1F))
                {
                    Local0 = 0x00
                }

                \_SB.SSMI (0xEA3A, 0x00, Local0, 0x00, 0x00)
                \_GPE.HWWP (0x01)
                WGWE (0x05, 0x00)
            }

            Method (GDBT, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x18, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SDBT, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x18, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GFRT, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x0D, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SDMD, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x1D, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GDMD, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x1D, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SBUS, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x1E, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GBUS, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x1E, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (STMM, 1, NotSerialized)
            {
                Debug = "SetThermalStatus"
                CreateByteField (Arg0, 0x00, IDTA)
                If (((IDTA >= 0x10) && (IDTA <= 0x15)))
                {
                    \_SB.SSMI (0xEA75, 0x02, 0x28, 0x574D4953, 0x00)
                    Return (WFDA ())
                }

                Local0 = Package (0x02)
                    {
                        0x00, 
                        0x00
                    }
                If (((IDTA >= 0x20) && (IDTA <= 0x24)))
                {
                    Local7 = (IDTA - 0x20)
                    Local1 = DerefOf (Arg0 [0x01])
                    Local2 = DerefOf (Arg0 [0x02])
                    If ((Local1 != DerefOf (THCT [Local7])))
                    {
                        Return (Package (0x02)
                        {
                            0x06, 
                            0x00
                        })
                    }

                    If ((Local1 == 0x00))
                    {
                        Return (Local0)
                    }

                    If (\_SB.PCI0.LPCB.EC0.ECRG)
                    {
                        Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
                        If (((Local7 < 0x03) || (Local7 == 0x04)))
                        {
                            \_SB.PCI0.LPCB.EC0.CRZN = (0x01 + Local7)
                            If ((Local2 == 0xFF))
                            {
                                Local2 = 0x00
                            }

                            \_SB.PCI0.LPCB.EC0.TEMP = Local2
                            If ((Local7 == 0x02))
                            {
                                Local2 = DerefOf (Arg0 [0x03])
                                \_SB.PCI0.LPCB.EC0.CRZN = 0x04
                                If ((Local2 == 0xFF))
                                {
                                    Local2 = 0x00
                                }

                                \_SB.PCI0.LPCB.EC0.TEMP = Local2
                            }
                        }
                        Else
                        {
                            If ((Local2 != 0xFF))
                            {
                                Local2 = \_TZ.CTCT (Local2)
                            }

                            \_SB.PCI0.LPCB.EC0.FTGC = Local2
                        }

                        Release (\_SB.PCI0.LPCB.EC0.ECMX)
                    }

                    Local6 = 0x00
                    While ((Local6 < Local1))
                    {
                        DerefOf (TSTV [Local7]) [Local6] = DerefOf (Arg0 [
                            (Local6 + 0x02)])
                        Local6++
                    }

                    TSTM = 0x01
                    Return (Local0)
                }

                If ((IDTA == 0xAA))
                {
                    Local1 = 0x00
                    While ((Local1 < SizeOf (TSTV)))
                    {
                        Local2 = 0x00
                        Local3 = DerefOf (THCT [Local1])
                        While ((Local2 < Local3))
                        {
                            DerefOf (TSTV [Local1]) [Local2] = 0xFF
                            Local2++
                        }

                        Local1++
                    }

                    If (\_SB.PCI0.LPCB.EC0.ECRG)
                    {
                        Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
                        Local1 = 0x01
                        While ((Local1 <= 0x05))
                        {
                            \_SB.PCI0.LPCB.EC0.CRZN = Local1
                            \_SB.PCI0.LPCB.EC0.TEMP = 0x00
                            Local1++
                        }

                        \_SB.PCI0.LPCB.EC0.FTGC = 0xFF
                        Release (\_SB.PCI0.LPCB.EC0.ECMX)
                    }

                    TSTM = 0x00
                    Return (Local0)
                }

                Return (Package (0x02)
                {
                    0x06, 
                    0x00
                })
            }

            Method (GTMS, 1, NotSerialized)
            {
                Debug = "GetThermalStatus"
                Debug = Arg0
                Local0 = Package (0x03)
                    {
                        0x00, 
                        0x80, 
                        Buffer (0x80){}
                    }
                CreateByteField (Arg0, 0x00, IDTA)
                If (((IDTA >= 0x00) && (IDTA <= 0x04)))
                {
                    Local2 = DerefOf (THCT [IDTA])
                    DerefOf (Local0 [0x02]) [0x00] = Local2
                    If ((Local2 == 0x00))
                    {
                        Return (Local0)
                    }

                    If (((IDTA < 0x03) || (IDTA == 0x04)))
                    {
                        If (\_SB.PCI0.LPCB.EC0.ECRG)
                        {
                            Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
                            \_SB.PCI0.LPCB.EC0.CRZN = (0x01 + IDTA)
                            DerefOf (Local0 [0x02]) [0x01] = \_SB.PCI0.LPCB.EC0.DTMP
                            If ((IDTA == 0x02))
                            {
                                \_SB.PCI0.LPCB.EC0.CRZN = 0x04
                                DerefOf (Local0 [0x02]) [0x02] = \_SB.PCI0.LPCB.EC0.DTMP
                            }

                            Release (\_SB.PCI0.LPCB.EC0.ECMX)
                        }

                        If ((IDTA == 0x02))
                        {
                            DerefOf (Local0 [0x02]) [0x03] = PCHT /* \PCHT */
                        }
                    }

                    If ((IDTA == 0x03))
                    {
                        Local1 = \_TZ.GFSD ()
                        DerefOf (Local0 [0x02]) [0x01] = Local1
                    }

                    Return (Local0)
                }

                If ((IDTA == 0x06))
                {
                    If (TRCN)
                    {
                        Local1 = 0x01
                    }
                    Else
                    {
                        Local1 = 0x00
                    }

                    TRCN = 0x00
                    DerefOf (Local0 [0x02]) [0x00] = 0x01
                    DerefOf (Local0 [0x02]) [0x01] = Local1
                    Return (Local0)
                }

                If (((IDTA >= 0x10) && (IDTA <= 0x15)))
                {
                    \_SB.SSMI (0xEA75, 0x01, 0x28, 0x574D4953, 0x00)
                    If ((EBX == 0x00))
                    {
                        Local1 = ASMB /* \ASMB */
                    }
                    Else
                    {
                        Return (Local0)
                    }

                    Local7 = (IDTA - 0x10)
                    Local2 = DerefOf (THCT [Local7])
                    DerefOf (Local0 [0x02]) [0x00] = Local2
                    Local4 = DerefOf (PRFI [Local7])
                    Local3 = 0x00
                    While ((Local3 < Local2))
                    {
                        DerefOf (Local0 [0x02]) [(Local3 + 0x01)] = 
                            DerefOf (Local1 [(Local3 + Local4)])
                        Local3++
                    }

                    Return (Local0)
                }

                If (((IDTA >= 0x20) && (IDTA <= 0x25)))
                {
                    Local7 = (IDTA - 0x20)
                    Local2 = DerefOf (THCT [Local7])
                    DerefOf (Local0 [0x02]) [0x00] = Local2
                    Local3 = 0x00
                    While ((Local3 < Local2))
                    {
                        DerefOf (Local0 [0x02]) [(Local3 + 0x01)] = 
                            DerefOf (DerefOf (TSTV [Local7]) [Local3])
                        Local3++
                    }

                    Return (Local0)
                }

                If ((IDTA == 0xAA))
                {
                    DerefOf (Local0 [0x02]) [0x00] = TSTM /* \_SB_.WMID.TSTM */
                    Return (Local0)
                }

                Return (Package (0x02)
                {
                    0x06, 
                    0x00
                })
            }

            Method (SBTC, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x1F, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GBTC, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x1F, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GPMC, 1, NotSerialized)
            {
                Local0 = Buffer (0x80){}
                Local0 [0x00] = 0x01
                Local0 [0x01] = 0x00
                If ((PMCS == 0x01))
                {
                    If (\_SB.PCI0.LPCB.EC0.ECRG)
                    {
                        CreateWordField (Local0, 0x02, SYS)
                        CreateWordField (Local0, 0x04, P1)
                        CreateWordField (Local0, 0x06, BV1)
                        CreateWordField (Local0, 0x08, BI1)
                        CreateWordField (Local0, 0x0A, P2)
                        CreateWordField (Local0, 0x0C, BV2)
                        CreateWordField (Local0, 0x0E, BI2)
                        CreateWordField (Local0, 0x10, E1)
                        CreateWordField (Local0, 0x12, E2)
                        Local1 = \_SB.PCI0.LPCB.EC0.S0FL
                        Local2 = 0x01
                        If (((Local1 & 0x10) == 0x00))
                        {
                            Local2 |= 0x02
                        }

                        SYS = Local2
                        If ((Arg0 == 0x01))
                        {
                            \_SB.PCI0.LPCB.EC0.CIDX = 0x00
                            P1 = \_SB.PCI0.LPCB.EC0.CPWR
                            BV1 = \_SB.PCI0.LPCB.EC0.CVLT
                            BI1 = \_SB.PCI0.LPCB.EC0.CCUR
                            \_SB.PCI0.LPCB.EC0.CIDX = 0x01
                            P2 = \_SB.PCI0.LPCB.EC0.CPWR
                            BV2 = \_SB.PCI0.LPCB.EC0.CVLT
                            BI2 = \_SB.PCI0.LPCB.EC0.CCUR
                        }
                        Else
                        {
                            Local2 = ASMB /* \ASMB */
                            Local2 [0x10] = 0x00
                            ASMB = Local2
                            \_SB.SSMI (0xEA75, 0x01, 0x1C, 0x574D4953, 0x00)
                            If ((EBX == 0x00))
                            {
                                Local1 = ASMB /* \ASMB */
                                Local2 = 0x00
                                While ((Local2 < 0x0C))
                                {
                                    Local0 [(Local2 + 0x04)] = DerefOf (Local1 [Local2]
                                        )
                                    Local2++
                                }

                                SYS &= ~0x02
                            }
                            ElseIf ((SYS & 0x02))
                            {
                                P1 = 0x011C
                                BV1 = 0x2E18
                                BI1 = 0x0F50
                                P2 = 0x55
                                BV2 = 0x3264
                                BI2 = 0x0432
                            }
                            Else
                            {
                                \_SB.PCI0.LPCB.EC0.CIDX = 0x00
                                P1 = \_SB.PCI0.LPCB.EC0.CPWR
                                BV1 = \_SB.PCI0.LPCB.EC0.CVLT
                                BI1 = \_SB.PCI0.LPCB.EC0.CCUR
                                \_SB.PCI0.LPCB.EC0.CIDX = 0x01
                                P2 = \_SB.PCI0.LPCB.EC0.CPWR
                                BV2 = \_SB.PCI0.LPCB.EC0.CVLT
                                BI2 = \_SB.PCI0.LPCB.EC0.CCUR
                                Local1 = 0x00
                                If (((P1 > 0x0202) || (P1 < 0x80)))
                                {
                                    Local1 = 0x01
                                }

                                If (((P2 > 0x8D) || (P2 < 0x46)))
                                {
                                    Local1 = 0x01
                                }

                                If ((BV1 < 0x36B0))
                                {
                                    If (((BV1 > 0x3390) || (BV1 < 0x2CEC)))
                                    {
                                        Local1 = 0x01
                                    }

                                    If (((BV2 > 0x3390) || (BV2 < 0x2CEC)))
                                    {
                                        Local1 = 0x01
                                    }

                                    If (((BI1 > 0x1068) || (BI1 < 0x06A4)))
                                    {
                                        Local1 = 0x01
                                    }

                                    If (((BI2 > 0x04B0) || (BI2 < 0x0384)))
                                    {
                                        Local1 = 0x01
                                    }
                                }
                                Else
                                {
                                    If (((BV1 > 0x445C) || (BV1 < 0x3C28)))
                                    {
                                        Local1 = 0x01
                                    }

                                    If (((BV2 > 0x445C) || (BV2 < 0x3C28)))
                                    {
                                        Local1 = 0x01
                                    }

                                    If (((BI1 > 0x1068) || (BI1 < 0x06A4)))
                                    {
                                        Local1 = 0x01
                                    }

                                    If (((BI2 > 0x04B0) || (BI2 < 0x0384)))
                                    {
                                        Local1 = 0x01
                                    }
                                }

                                If ((Local1 == 0x01))
                                {
                                    \_SB.PCI0.LPCB.EC0.S0FL = 0x00
                                    P1 = 0x011C
                                    BV1 = 0x2E18
                                    BI1 = 0x0F50
                                    P2 = 0x55
                                    BV2 = 0x3264
                                    BI2 = 0x0432
                                    SYS |= 0x02
                                }
                                Else
                                {
                                    Local2 = ASMB /* \ASMB */
                                    CreateField (Local0, 0x20, 0x60, CDAT)
                                    CreateField (Local2, 0xA0, 0x60, BDAT)
                                    BDAT = CDAT /* \_SB_.WMID.GPMC.CDAT */
                                    Local2 [0x10] = 0x01
                                    ASMB = Local2
                                    \_SB.SSMI (0xEA75, 0x01, 0x1C, 0x574D4953, 0x00)
                                }
                            }
                        }

                        If ((BV2 > 0x3A98))
                        {
                            E1 = 0x03B6
                            E2 = 0x03B6
                        }
                        Else
                        {
                            E1 = 0x0398
                            E2 = 0x0398
                        }
                    }
                    Else
                    {
                        Return (Package (0x02)
                        {
                            0x0D, 
                            0x00
                        })
                    }
                }

                Local1 = Package (0x03)
                    {
                        0x00, 
                        0x80, 
                        Buffer (0x80){}
                    }
                Local1 [0x02] = Local0
                Return (Local1)
            }

            Method (CPMC, 0, NotSerialized)
            {
                If ((PMCS == 0x01))
                {
                    If (\_SB.PCI0.LPCB.EC0.ECRG)
                    {
                        \_SB.PCI0.LPCB.EC0.S0FL = 0x00
                        Return (Package (0x02)
                        {
                            0x00, 
                            0x00
                        })
                    }
                }

                Return (Package (0x02)
                {
                    0x0D, 
                    0x00
                })
            }

            Method (SQBP, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x22, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GQBP, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x22, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GPIN, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x23, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SPIN, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x23, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (WGBC, 0, NotSerialized)
            {
                Return (\_SB.PCI0.LPCB.EC0.GBTC ())
            }

            Method (WSBC, 3, NotSerialized)
            {
                Return (\_SB.PCI0.LPCB.EC0.SBTC (Arg0, Arg1, Arg2))
            }

            Method (GFCC, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x29, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SFCC, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x29, 0x574D4953, 0x00)
                Local1 = WFDA ()
                If (EDX)
                {
                    HWWB ()
                }

                Return (Local1)
            }

            Method (GPES, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x2A, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SPES, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x2A, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GLID, 0, NotSerialized)
            {
                Local0 = Package (0x03)
                    {
                        0x00, 
                        0x04, 
                        Buffer (0x04){}
                    }
                DerefOf (Local0 [0x02]) [0x00] = (\_SB.LID._LID () + 0x01
                    )
                Return (Local0)
            }

            Method (GDES, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x33, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GBLC, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x34, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SBLC, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x34, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GPST, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x36, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SPST, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x36, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GBCT, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x37, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SBCP, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x37, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (GPSH, 0, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x01, 0x38, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Method (SPSH, 1, NotSerialized)
            {
                \_SB.SSMI (0xEA75, 0x02, 0x38, 0x574D4953, 0x00)
                Return (WFDA ())
            }

            Name (_HID, EisaId ("PNP0C14") /* Windows Management Instrumentation Device */)  // _HID: Hardware ID
            Name (_UID, 0x00)  // _UID: Unique ID
            Name (WEI1, 0x00)
            Name (WED1, 0x00)
            Name (WEI2, 0x00)
            Name (WED2, 0x00)
            Name (WEVT, 0x00)
            Name (_WDG, Buffer (0x0118)
            {
                /* 0000 */  0x34, 0xF0, 0xB7, 0x5F, 0x63, 0x2C, 0xE9, 0x45,  // 4.._c,.E
                /* 0008 */  0xBE, 0x91, 0x3D, 0x44, 0xE2, 0xC7, 0x07, 0xE4,  // ..=D....
                /* 0010 */  0x41, 0x41, 0x01, 0x02, 0x79, 0x42, 0xF2, 0x95,  // AA..yB..
                /* 0018 */  0x7B, 0x4D, 0x34, 0x43, 0x93, 0x87, 0xAC, 0xCD,  // {M4C....
                /* 0020 */  0xC6, 0x7E, 0xF6, 0x1C, 0x80, 0x00, 0x01, 0x08,  // .~......
                /* 0028 */  0x18, 0x43, 0x81, 0x2B, 0xE8, 0x4B, 0x07, 0x47,  // .C.+.K.G
                /* 0030 */  0x9D, 0x84, 0xA1, 0x90, 0xA8, 0x59, 0xB5, 0xD0,  // .....Y..
                /* 0038 */  0xA0, 0x00, 0x01, 0x08, 0x21, 0x12, 0x90, 0x05,  // ....!...
                /* 0040 */  0x66, 0xD5, 0xD1, 0x11, 0xB2, 0xF0, 0x00, 0xA0,  // f.......
                /* 0048 */  0xC9, 0x06, 0x29, 0x10, 0x41, 0x42, 0x01, 0x00,  // ..).AB..
                /* 0050 */  0xEB, 0x91, 0x4C, 0x1F, 0x5C, 0xDC, 0x0B, 0x46,  // ..L.\..F
                /* 0058 */  0x95, 0x1D, 0xC7, 0xCB, 0x9B, 0x4B, 0x8D, 0x5E,  // .....K.^
                /* 0060 */  0x42, 0x41, 0x01, 0x02, 0x49, 0x4B, 0x11, 0x2D,  // BA..IK.-
                /* 0068 */  0xFB, 0x2D, 0x30, 0x41, 0xB8, 0xFE, 0x4A, 0x3C,  // .-0A..J<
                /* 0070 */  0x09, 0xE7, 0x51, 0x33, 0x42, 0x43, 0xCE, 0x00,  // ..Q3BC..
                /* 0078 */  0xE3, 0x08, 0x8D, 0x98, 0xF4, 0x68, 0x35, 0x4C,  // .....h5L
                /* 0080 */  0xAF, 0x3E, 0x6A, 0x1B, 0x81, 0x06, 0xF8, 0x3C,  // .>j....<
                /* 0088 */  0x42, 0x44, 0x29, 0x00, 0x46, 0x97, 0xEA, 0x14,  // BD).F...
                /* 0090 */  0x1F, 0xCE, 0x98, 0x40, 0xA0, 0xE0, 0x70, 0x45,  // ...@..pE
                /* 0098 */  0xCB, 0x4D, 0xA7, 0x45, 0x42, 0x45, 0x02, 0x00,  // .M.EBE..
                /* 00A0 */  0x28, 0x20, 0x2F, 0x32, 0x84, 0x0F, 0x01, 0x49,  // ( /2...I
                /* 00A8 */  0x98, 0x8E, 0x01, 0x51, 0x76, 0x04, 0x9E, 0x2D,  // ...Qv..-
                /* 00B0 */  0x42, 0x46, 0x05, 0x00, 0x3D, 0xDE, 0x32, 0x82,  // BF..=.2.
                /* 00B8 */  0x3D, 0x66, 0x27, 0x43, 0xA8, 0xF4, 0xE2, 0x93,  // =f'C....
                /* 00C0 */  0xAD, 0xB9, 0xBF, 0x05, 0x42, 0x47, 0x02, 0x00,  // ....BG..
                /* 00C8 */  0x36, 0x64, 0x1F, 0x8F, 0x42, 0x9F, 0xC8, 0x42,  // 6d..B..B
                /* 00D0 */  0xBA, 0xDC, 0x0E, 0x94, 0x24, 0xF2, 0x0C, 0x9A,  // ....$...
                /* 00D8 */  0x42, 0x48, 0x00, 0x00, 0x35, 0x64, 0x1F, 0x8F,  // BH..5d..
                /* 00E0 */  0x42, 0x9F, 0xC8, 0x42, 0xBA, 0xDC, 0x0E, 0x94,  // B..B....
                /* 00E8 */  0x24, 0xF2, 0x0C, 0x9A, 0x42, 0x49, 0x00, 0x00,  // $...BI..
                /* 00F0 */  0x61, 0xA6, 0x91, 0x73, 0x3A, 0x22, 0xDB, 0x47,  // a..s:".G
                /* 00F8 */  0xA7, 0x7A, 0x7B, 0xE8, 0x4C, 0x60, 0x82, 0x2D,  // .z{.L`.-
                /* 0100 */  0x41, 0x43, 0x01, 0x02, 0xB6, 0x63, 0x4E, 0xDF,  // AC...cN.
                /* 0108 */  0xBC, 0x3B, 0x58, 0x48, 0x97, 0x37, 0xC7, 0x4F,  // .;XH.7.O
                /* 0110 */  0x82, 0xF8, 0x21, 0xF3, 0x42, 0x4A, 0x03, 0x00   // ..!.BJ..
            })
            Name (EVNT, Package (0x03)
            {
                Package (0x05)
                {
                    "BIOS Configuration Change", 
                    "BIOS Settings", 
                    0x04, 
                    0x05, 
                    0x02
                }, 

                Package (0x05)
                {
                    "BIOS Configuration Security", 
                    "An attempt has been made to Access BIOS features unsuccessfully", 
                    0x04, 
                    0x0A, 
                    0x06
                }, 

                Package (0x05)
                {
                    "Unknown Event", 
                    "Unknown event type", 
                    0x00, 
                    0x00, 
                    0x00
                }
            })
            Name (IWPN, 0x01)
            Method (IWMP, 0, Serialized)
            {
                If (IWPN)
                {
                    Local1 = 0x00
                    Local2 = 0x00
                    Local3 = 0x00
                    Local7 = 0x00
                    If (RDSP)
                    {
                        Local1 = 0x01
                    }

                    If (TXTC)
                    {
                        Local2 = 0x01
                    }

                    If (AMTC)
                    {
                        Local3 = 0x01
                    }

                    If (!BKPR)
                    {
                        Local7 = 0x01
                    }

                    Local4 = (Local1 | Local2)
                    Local4 |= Local3
                    Local4 |= Local7
                    Local5 = 0x00
                    While ((Local4 && (Local5 < 0xCE)))
                    {
                        Local6 = DerefOf (DerefOf (BISE [Local5]) [0x00])
                        If (Local1)
                        {
                            If (\SRCM (Local6, "SATA Device Mode", 0x10))
                            {
                                BISE [Local5] = SWRD /* \_SB_.SWRD */
                            }

                            If (\SRCM (Local6, "Ctrl I Prompt", 0x0D))
                            {
                                BISE [Local5] = CTIP /* \_SB_.CTIP */
                                Local1 = 0x00
                            }
                        }

                        If (Local2)
                        {
                            If (\SRCM (Local6, "TXT Technology", 0x0E))
                            {
                                BISE [Local5] = TXTS /* \_SB_.TXTS */
                            }

                            If (\SRCM (Local6, "TXT Technology Security Level", 0x1D))
                            {
                                BISE [Local5] = TXTP /* \_SB_.TXTP */
                                Local2 = 0x00
                            }
                        }

                        If (Local3)
                        {
                            If (\SRCM (Local6, "Terminal Emulation Mode", 0x17))
                            {
                                BISE [Local5] = ATEM /* \_SB_.ATEM */
                            }

                            If (\SRCM (Local6, "Firmware Verbosity", 0x12))
                            {
                                BISE [Local5] = AFWV /* \_SB_.AFWV */
                            }

                            If (\SRCM (Local6, "Firmware Progress Event Support", 0x1F))
                            {
                                BISE [Local5] = APES /* \_SB_.APES */
                            }

                            If (\SRCM (Local6, "Unconfigure AMT on next boot", 0x1C))
                            {
                                BISE [Local5] = AUNB /* \_SB_.AUNB */
                            }

                            If (\SRCM (Local6, "USB Key Provisioning Support", 0x1C))
                            {
                                BISE [Local5] = AUKP /* \_SB_.AUKP */
                            }

                            If (\SRCM (Local6, "AMT Setup Prompt(Ctrl-P)", 0x18))
                            {
                                BISE [Local5] = ASUP /* \_SB_.ASUP */
                            }

                            If (\SRCM (Local6, "Initiate Intel CIRA", 0x13))
                            {
                                BISE [Local5] = AIIC /* \_SB_.AIIC */
                            }

                            If (\SRCM (Local6, "Terminal Emulation Mode Security Level", 0x26))
                            {
                                BISE [Local5] = ATEP /* \_SB_.ATEP */
                            }

                            If (\SRCM (Local6, "Firmware Verbosity Security Level", 0x21))
                            {
                                BISE [Local5] = AFWP /* \_SB_.AFWP */
                            }

                            If (\SRCM (Local6, "Firmware Progress Event Support Security Level", 0x2E))
                            {
                                BISE [Local5] = APEP /* \_SB_.APEP */
                            }

                            If (\SRCM (Local6, "Unconfigure AMT on next boot Security Level", 0x2B))
                            {
                                BISE [Local5] = AUNP /* \_SB_.AUNP */
                            }

                            If (\SRCM (Local6, "USB Key Provisioning Support Security Level", 0x2B))
                            {
                                BISE [Local5] = AUPP /* \_SB_.AUPP */
                            }

                            If (\SRCM (Local6, "AMT Setup Prompt(Ctrl-P) Security Level", 0x27))
                            {
                                BISE [Local5] = ASPP /* \_SB_.ASPP */
                            }

                            If (\SRCM (Local6, "Initiate Intel CIRA Security Level", 0x22))
                            {
                                BISE [Local5] = AIIP /* \_SB_.AIIP */
                                Local3 = 0x00
                            }
                        }

                        If (Local7)
                        {
                            If (\SRCM (Local6, "Backlit Keyboard Timeout", 0x18))
                            {
                                BISE [Local5] = BKTO /* \_SB_.BKTO */
                            }

                            If (\SRCM (Local6, "Backlit Keyboard Timeout Security Level", 0x27))
                            {
                                BISE [Local5] = BKTP /* \_SB_.BKTP */
                                Local7 = 0x00
                            }
                        }

                        Local5++
                    }

                    IWPN = 0x00
                }
            }

            Method (_WED, 1, NotSerialized)  // _Wxx: Wake Event, xx=0x00-0xFF
            {
                If ((Arg0 == 0xA0))
                {
                    If ((DerefOf (ETYP [0x00]) == 0x00))
                    {
                        BF2S = ST01 /* \_SB_.ST01 */
                        DerefOf (EVNT [0x00]) [0x01] = BF2S /* \_SB_.BF2S */
                        Return (DerefOf (EVNT [0x00]))
                    }

                    If ((DerefOf (ETYP [0x00]) == 0x01))
                    {
                        Return (DerefOf (EVNT [0x01]))
                    }
                    Else
                    {
                        Return (DerefOf (EVNT [0x02]))
                    }
                }
                Else
                {
                    Local0 = Buffer (0x08)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
                        }
                    CreateDWordField (Local0, 0x00, EVID)
                    CreateDWordField (Local0, 0x04, EVDA)
                    EVID = WEI1 /* \_SB_.WMID.WEI1 */
                    EVDA = WED1 /* \_SB_.WMID.WED1 */
                    If ((WEI2 != 0x00))
                    {
                        WEI1 = WEI2 /* \_SB_.WMID.WEI2 */
                        WED1 = WED2 /* \_SB_.WMID.WED2 */
                        EVID = WEI1 /* \_SB_.WMID.WEI1 */
                        EVDA = WED1 /* \_SB_.WMID.WED1 */
                        WEI2 = 0x00
                        WED2 = 0x00
                        If ((WEVT == 0x00))
                        {
                            WEVT = 0x01
                            Notify (\_SB.WMID, 0x80) // Status Change
                        }
                    }
                    Else
                    {
                        WEI1 = 0x00
                        WED1 = 0x00
                    }

                    Return (Local0)
                }
            }

            Name (WQAB, Buffer (0x2135)
            {
                /* 0000 */  0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,  // FOMB....
                /* 0008 */  0x25, 0x21, 0x00, 0x00, 0xB0, 0xCB, 0x00, 0x00,  // %!......
                /* 0010 */  0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,  // DS...}.T
                /* 0018 */  0x28, 0x27, 0xA1, 0x00, 0x01, 0x06, 0x18, 0x42,  // ('.....B
                /* 0020 */  0x10, 0x4D, 0x10, 0x92, 0x46, 0x62, 0x02, 0x89,  // .M..Fb..
                /* 0028 */  0x80, 0x90, 0x18, 0x18, 0x14, 0x81, 0x85, 0x00,  // ........
                /* 0030 */  0x49, 0x02, 0x88, 0xC4, 0x41, 0xE1, 0x20, 0xD4,  // I...A. .
                /* 0038 */  0x9F, 0x40, 0x7E, 0x05, 0x20, 0x74, 0x28, 0x40,  // .@~. t(@
                /* 0040 */  0xA6, 0x00, 0x83, 0x02, 0x9C, 0x22, 0x88, 0xA0,  // ....."..
                /* 0048 */  0x57, 0x01, 0x36, 0x05, 0x98, 0x14, 0x60, 0x51,  // W.6...`Q
                /* 0050 */  0x80, 0x76, 0x01, 0x96, 0x05, 0xE8, 0x16, 0x20,  // .v..... 
                /* 0058 */  0x1D, 0x96, 0x88, 0x04, 0x47, 0x89, 0x01, 0x47,  // ....G..G
                /* 0060 */  0xE9, 0xC4, 0x16, 0x6E, 0xD8, 0xE0, 0x85, 0xA2,  // ...n....
                /* 0068 */  0x68, 0x06, 0x51, 0x12, 0x94, 0x8B, 0x20, 0x5D,  // h.Q... ]
                /* 0070 */  0x10, 0x52, 0x2E, 0xC0, 0x37, 0x82, 0x06, 0x10,  // .R..7...
                /* 0078 */  0xA5, 0x77, 0x01, 0xB6, 0x05, 0x98, 0x86, 0x27,  // .w.....'
                /* 0080 */  0xD2, 0x20, 0xE4, 0x60, 0x08, 0x54, 0xCE, 0x80,  // . .`.T..
                /* 0088 */  0x20, 0x69, 0x44, 0x21, 0x1E, 0xA7, 0x44, 0x08,  //  iD!..D.
                /* 0090 */  0x0A, 0x84, 0x90, 0xD4, 0xF1, 0xA0, 0xA0, 0x71,  // .......q
                /* 0098 */  0x88, 0xAD, 0xCE, 0x46, 0x93, 0xA9, 0x74, 0x7E,  // ...F..t~
                /* 00A0 */  0x48, 0x82, 0x70, 0xC6, 0x2A, 0x7E, 0x3A, 0x9A,  // H.p.*~:.
                /* 00A8 */  0xD0, 0xD9, 0x9C, 0x60, 0xE7, 0x18, 0x72, 0x3C,  // ...`..r<
                /* 00B0 */  0x48, 0xF4, 0x20, 0xB8, 0x00, 0x0F, 0x1C, 0x2C,  // H. ....,
                /* 00B8 */  0x34, 0x84, 0x22, 0x6B, 0x80, 0xC1, 0x8C, 0xDD,  // 4."k....
                /* 00C0 */  0x63, 0xB1, 0x0B, 0x4E, 0x0A, 0xEC, 0x61, 0xB3,  // c..N..a.
                /* 00C8 */  0x01, 0x19, 0xA2, 0x24, 0x38, 0xD4, 0x11, 0xC0,  // ...$8...
                /* 00D0 */  0x12, 0x05, 0x98, 0x1F, 0x87, 0x0C, 0x0F, 0x95,  // ........
                /* 00D8 */  0x8C, 0x25, 0x24, 0x1B, 0xAB, 0x87, 0xC2, 0xA5,  // .%$.....
                /* 00E0 */  0x40, 0x68, 0x6C, 0x27, 0xED, 0x19, 0x45, 0x2C,  // @hl'..E,
                /* 00E8 */  0x79, 0x4A, 0x82, 0x49, 0xE0, 0x51, 0x44, 0x36,  // yJ.I.QD6
                /* 00F0 */  0x1A, 0x27, 0x28, 0x1B, 0x1A, 0x25, 0x03, 0x42,  // .'(..%.B
                /* 00F8 */  0x9E, 0x05, 0x58, 0x07, 0x26, 0x04, 0x76, 0x2F,  // ..X.&.v/
                /* 0100 */  0xC0, 0x9A, 0x00, 0x73, 0xB3, 0x90, 0xB1, 0xB9,  // ...s....
                /* 0108 */  0xE8, 0xFF, 0x0F, 0x71, 0xB0, 0x31, 0xDA, 0x9A,  // ...q.1..
                /* 0110 */  0xAE, 0x90, 0xC2, 0xC4, 0x88, 0x12, 0x2C, 0x5E,  // ......,^
                /* 0118 */  0xC5, 0xC3, 0x10, 0xCA, 0x93, 0x42, 0xA8, 0x48,  // .....B.H
                /* 0120 */  0x95, 0xA1, 0x68, 0xB4, 0x51, 0x2A, 0x14, 0xE0,  // ..h.Q*..
                /* 0128 */  0x4C, 0x80, 0x30, 0x5C, 0x1D, 0x03, 0x82, 0x46,  // L.0\...F
                /* 0130 */  0x88, 0x15, 0x29, 0x56, 0xFB, 0x83, 0x20, 0xF1,  // ..)V.. .
                /* 0138 */  0x2D, 0x40, 0x54, 0x01, 0xA2, 0x48, 0xA3, 0x41,  // -@T..H.A
                /* 0140 */  0x9D, 0x03, 0x3C, 0x5C, 0x0F, 0xF5, 0xF0, 0x3D,  // ..<\...=
                /* 0148 */  0xF6, 0x93, 0x0C, 0x72, 0x90, 0x67, 0xF1, 0xA8,  // ...r.g..
                /* 0150 */  0x70, 0x9C, 0x06, 0x49, 0xE0, 0x0B, 0x80, 0x4F,  // p..I...O
                /* 0158 */  0x08, 0x1E, 0x38, 0xDE, 0x35, 0xA0, 0x66, 0x7C,  // ..8.5.f|
                /* 0160 */  0xBC, 0x4C, 0x10, 0x1C, 0x6A, 0x88, 0x1E, 0x68,  // .L..j..h
                /* 0168 */  0xB8, 0x13, 0x38, 0x44, 0x06, 0xE8, 0x49, 0x3D,  // ..8D..I=
                /* 0170 */  0x52, 0x60, 0x07, 0x77, 0x32, 0xEF, 0x01, 0xAF,  // R`.w2...
                /* 0178 */  0x0A, 0xCD, 0x5E, 0x12, 0x08, 0xC1, 0xF1, 0xF8,  // ..^.....
                /* 0180 */  0x7E, 0xC0, 0x26, 0x9C, 0xC0, 0xF2, 0x07, 0x81,  // ~.&.....
                /* 0188 */  0x1A, 0x99, 0xA1, 0x3D, 0xCA, 0xD3, 0x8A, 0x19,  // ...=....
                /* 0190 */  0xF2, 0x31, 0xC1, 0x04, 0x16, 0x0B, 0x21, 0x05,  // .1....!.
                /* 0198 */  0x10, 0x1A, 0x0F, 0xF8, 0x6F, 0x00, 0x8F, 0x17,  // ....o...
                /* 01A0 */  0xBE, 0x12, 0xC4, 0xF6, 0x80, 0x12, 0x0C, 0x0B,  // ........
                /* 01A8 */  0x21, 0x23, 0xAB, 0xF0, 0x78, 0xE8, 0x28, 0x7C,  // !#..x.(|
                /* 01B0 */  0x95, 0x38, 0x9C, 0xD3, 0x8A, 0x67, 0x82, 0xE1,  // .8...g..
                /* 01B8 */  0x20, 0xF4, 0x05, 0x90, 0x00, 0x51, 0xE7, 0x0C,  //  ....Q..
                /* 01C0 */  0xD4, 0x61, 0xC1, 0xE7, 0x04, 0x76, 0x33, 0x38,  // .a...v38
                /* 01C8 */  0x83, 0x47, 0x00, 0x8F, 0xE4, 0x84, 0xFC, 0x2B,  // .G.....+
                /* 01D0 */  0xF1, 0xC0, 0xE0, 0x03, 0xE2, 0xEF, 0x1F, 0xA7,  // ........
                /* 01D8 */  0xEC, 0x11, 0x9C, 0xA9, 0x01, 0x7D, 0x1C, 0xF0,  // .....}..
                /* 01E0 */  0xFF, 0x7F, 0x28, 0x7C, 0x88, 0x1E, 0xDF, 0x29,  // ..(|...)
                /* 01E8 */  0x1F, 0xAF, 0x4F, 0x17, 0x96, 0x35, 0x4E, 0xE8,  // ..O..5N.
                /* 01F0 */  0x77, 0x08, 0x9F, 0x38, 0x7C, 0x64, 0x71, 0x44,  // w..8|dqD
                /* 01F8 */  0x08, 0x39, 0x39, 0x05, 0xA0, 0x81, 0x4F, 0xF7,  // .99...O.
                /* 0200 */  0xEC, 0x22, 0x9C, 0xAE, 0x27, 0xE5, 0x40, 0xC3,  // ."..'.@.
                /* 0208 */  0xA0, 0xE3, 0x04, 0xC7, 0x79, 0x00, 0x1C, 0xE3,  // ....y...
                /* 0210 */  0x84, 0x7F, 0x2E, 0x80, 0x3F, 0x40, 0x7E, 0xCA,  // ....?@~.
                /* 0218 */  0x78, 0xC5, 0x48, 0xE0, 0x98, 0x23, 0x44, 0x9F,  // x.H..#D.
                /* 0220 */  0x6B, 0x3C, 0x42, 0x2C, 0xFC, 0x53, 0x45, 0xE1,  // k<B,.SE.
                /* 0228 */  0x03, 0x21, 0x63, 0x04, 0x17, 0xA0, 0xC7, 0x08,  // .!c.....
                /* 0230 */  0x7C, 0x03, 0x8E, 0x11, 0x7D, 0x94, 0xE0, 0xEA,  // |...}...
                /* 0238 */  0x0F, 0x1A, 0x74, 0x80, 0xB8, 0xFF, 0xFF, 0x00,  // ..t.....
                /* 0240 */  0xE1, 0x83, 0x7A, 0x80, 0xC0, 0x37, 0xFA, 0xD1,  // ..z..7..
                /* 0248 */  0x03, 0x3D, 0x2E, 0x8B, 0x3E, 0x0F, 0xC8, 0xF8,  // .=..>...
                /* 0250 */  0x89, 0x46, 0xF3, 0xE2, 0xA7, 0x03, 0x7E, 0xF8,  // .F....~.
                /* 0258 */  0x00, 0x0F, 0xA8, 0x87, 0x84, 0x03, 0xC5, 0x4C,  // .......L
                /* 0260 */  0x9B, 0x83, 0x3E, 0xBB, 0x1C, 0x3A, 0x76, 0xB8,  // ..>..:v.
                /* 0268 */  0xE0, 0x3F, 0x81, 0x80, 0x4B, 0xDE, 0x21, 0x0C,  // .?..K.!.
                /* 0270 */  0x14, 0x23, 0xC6, 0x9F, 0x83, 0x7C, 0x0A, 0x03,  // .#...|..
                /* 0278 */  0xFF, 0xFF, 0xFF, 0x14, 0x06, 0xFE, 0xE1, 0xF0,  // ........
                /* 0280 */  0x20, 0x4F, 0x07, 0x9F, 0xB6, 0xA8, 0x74, 0x18,  //  O....t.
                /* 0288 */  0xD4, 0x81, 0x0B, 0xB0, 0x32, 0x89, 0x08, 0xCF,  // ....2...
                /* 0290 */  0x12, 0xB5, 0x41, 0xE8, 0xD4, 0xF0, 0x36, 0xF1,  // ..A...6.
                /* 0298 */  0xB6, 0xE5, 0x5B, 0x40, 0x9C, 0xD3, 0xEC, 0xED,  // ..[@....
                /* 02A0 */  0xC0, 0x45, 0x30, 0x22, 0xD4, 0x0C, 0x45, 0x4E,  // .E0"..EN
                /* 02A8 */  0x5A, 0x11, 0x63, 0x44, 0x79, 0xDC, 0x32, 0xCA,  // Z.cDy.2.
                /* 02B0 */  0xDB, 0xD6, 0x0B, 0x40, 0xBC, 0x13, 0x7B, 0xDE,  // ...@..{.
                /* 02B8 */  0x32, 0x46, 0xF0, 0xC8, 0x0F, 0x5C, 0x2C, 0xC6,  // 2F...\,.
                /* 02C0 */  0xEA, 0xF5, 0x5F, 0xF3, 0x81, 0x0B, 0x70, 0xF6,  // .._...p.
                /* 02C8 */  0xFF, 0x3F, 0x70, 0x01, 0x1C, 0x0A, 0x7A, 0x18,  // .?p...z.
                /* 02D0 */  0x42, 0x0F, 0xC3, 0x53, 0x39, 0x97, 0x87, 0xC8,  // B..S9...
                /* 02D8 */  0x53, 0x89, 0x18, 0x35, 0x4C, 0xD4, 0x67, 0x28,  // S..5L.g(
                /* 02E0 */  0xDF, 0x2D, 0x7C, 0x20, 0x02, 0xDF, 0x99, 0x0B,  // .-| ....
                /* 02E8 */  0xF8, 0xFD, 0xFF, 0x0F, 0x44, 0x70, 0x8E, 0x29,  // ....Dp.)
                /* 02F0 */  0xB8, 0x33, 0x0D, 0x78, 0x7C, 0xCE, 0x40, 0x20,  // .3.x|.@ 
                /* 02F8 */  0xA7, 0xE2, 0x43, 0x0D, 0x60, 0x41, 0xF4, 0x13,  // ..C.`A..
                /* 0300 */  0xC2, 0x27, 0x1A, 0x2A, 0x13, 0x06, 0x75, 0xA8,  // .'.*..u.
                /* 0308 */  0x01, 0xAC, 0x5C, 0x61, 0x9E, 0x46, 0xCF, 0xF9,  // ..\a.F..
                /* 0310 */  0x59, 0xC6, 0xA7, 0x1A, 0x1F, 0x4A, 0x8D, 0x63,  // Y....J.c
                /* 0318 */  0x88, 0x97, 0x99, 0x87, 0x1A, 0x1F, 0x0B, 0x5E,  // .......^
                /* 0320 */  0x49, 0x7D, 0xA8, 0x31, 0x54, 0x9C, 0x87, 0x1A,  // I}.1T...
                /* 0328 */  0x0F, 0x37, 0x50, 0xD4, 0x37, 0x9B, 0x67, 0x1B,  // .7P.7.g.
                /* 0330 */  0xA3, 0xC7, 0xF7, 0x0D, 0xD5, 0x10, 0x0F, 0x35,  // .......5
                /* 0338 */  0x4C, 0xF2, 0x4A, 0x35, 0x16, 0x1F, 0x6A, 0xC0,  // L.J5..j.
                /* 0340 */  0xF1, 0xFF, 0x3F, 0xD4, 0x00, 0xFC, 0xFF, 0xFF,  // ..?.....
                /* 0348 */  0x1F, 0x6A, 0x00, 0x47, 0x47, 0x03, 0x38, 0x47,  // .j.GG.8G
                /* 0350 */  0x46, 0xDC, 0xD1, 0x00, 0x5C, 0x87, 0x52, 0xE0,  // F...\.R.
                /* 0358 */  0x70, 0x34, 0x00, 0x1E, 0x47, 0x21, 0x30, 0x5F,  // p4..G!0_
                /* 0360 */  0x68, 0x7C, 0x14, 0x02, 0x16, 0xFF, 0xFF, 0xA3,  // h|......
                /* 0368 */  0x10, 0xF8, 0x65, 0x9F, 0x83, 0x50, 0x42, 0x8F,  // ..e..PB.
                /* 0370 */  0x42, 0x80, 0xA0, 0xDB, 0xCF, 0x53, 0xC4, 0xB3,  // B....S..
                /* 0378 */  0x8F, 0x2F, 0x3F, 0x0F, 0x04, 0x11, 0x5E, 0xF3,  // ./?...^.
                /* 0380 */  0x7D, 0x0A, 0xF2, 0x21, 0xDF, 0x47, 0x21, 0x06,  // }..!.G!.
                /* 0388 */  0x63, 0x28, 0x5F, 0x83, 0x7C, 0x14, 0x62, 0x50,  // c(_.|.bP
                /* 0390 */  0xAF, 0x41, 0xBE, 0xEF, 0x1B, 0xE4, 0xF1, 0x22,  // .A....."
                /* 0398 */  0x48, 0xEC, 0x67, 0x02, 0x1F, 0x85, 0x98, 0xE8,  // H.g.....
                /* 03A0 */  0xA3, 0x10, 0xA0, 0xF0, 0xFF, 0x7F, 0x14, 0x02,  // ........
                /* 03A8 */  0xF8, 0xFF, 0xFF, 0x3F, 0x0A, 0x01, 0xCE, 0x02,  // ...?....
                /* 03B0 */  0x1C, 0x0D, 0x40, 0x37, 0xAD, 0x47, 0x21, 0xF0,  // ..@7.G!.
                /* 03B8 */  0xDE, 0x59, 0x4E, 0xFB, 0x04, 0x7C, 0x16, 0x02,  // .YN..|..
                /* 03C0 */  0xCC, 0xFE, 0xFF, 0xCF, 0x42, 0xC0, 0xEC, 0x28,  // ....B..(
                /* 03C8 */  0x74, 0x14, 0x67, 0xF9, 0x2A, 0xF4, 0x04, 0xF0,  // t.g.*...
                /* 03D0 */  0x02, 0x10, 0x23, 0xCC, 0x3B, 0xD0, 0x4B, 0x26,  // ..#.;.K&
                /* 03D8 */  0xBB, 0x8B, 0x1B, 0xE7, 0xC9, 0xE5, 0x2C, 0x9E,  // ......,.
                /* 03E0 */  0xC4, 0x7D, 0x09, 0xF2, 0x81, 0xE2, 0x59, 0xC8,  // .}....Y.
                /* 03E8 */  0x50, 0xA7, 0x1B, 0xF4, 0x8D, 0xDC, 0x03, 0x8B,  // P.......
                /* 03F0 */  0x19, 0x3F, 0xC4, 0xF3, 0x90, 0x21, 0x9E, 0x85,  // .?...!..
                /* 03F8 */  0x00, 0x76, 0xFD, 0xFF, 0xCF, 0x42, 0x00, 0xFF,  // .v...B..
                /* 0400 */  0xFF, 0xFF, 0x47, 0x03, 0xF8, 0x2F, 0x00, 0x9F,  // ..G../..
                /* 0408 */  0x85, 0x80, 0xE7, 0x09, 0xE0, 0x41, 0xDB, 0x67,  // .....A.g
                /* 0410 */  0x21, 0x80, 0x33, 0x87, 0xCB, 0xF3, 0x7F, 0x05,  // !.3.....
                /* 0418 */  0x3A, 0x96, 0xF7, 0x08, 0xCF, 0xFA, 0x24, 0x5F,  // :.....$_
                /* 0420 */  0x2F, 0x3D, 0xD3, 0x87, 0x82, 0x67, 0x21, 0x86,  // /=...g!.
                /* 0428 */  0x75, 0x18, 0x3E, 0x0B, 0x31, 0x88, 0x17, 0x4D,  // u.>.1..M
                /* 0430 */  0x43, 0xBC, 0x70, 0xFA, 0x30, 0xE0, 0xFF, 0x3F,  // C.p.0..?
                /* 0438 */  0x5E, 0xE0, 0x57, 0x4E, 0x03, 0x05, 0x09, 0xF4,  // ^.WN....
                /* 0440 */  0x2C, 0x04, 0x30, 0xFE, 0xFF, 0x7F, 0x16, 0x02,  // ,.0.....
                /* 0448 */  0xC8, 0xB8, 0x46, 0x9D, 0x85, 0x80, 0xE5, 0x6D,  // ..F....m
                /* 0450 */  0xE5, 0x19, 0xDB, 0xA7, 0x95, 0x04, 0xFF, 0xFF,  // ........
                /* 0458 */  0x67, 0x21, 0xC0, 0x41, 0x2E, 0x23, 0x07, 0x21,  // g!.A.#.!
                /* 0460 */  0x4C, 0xC4, 0x87, 0x83, 0x8F, 0x99, 0x80, 0x9E,  // L.......
                /* 0468 */  0x29, 0xBE, 0xB8, 0x1B, 0xE3, 0x09, 0xE0, 0x45,  // )......E
                /* 0470 */  0xE2, 0x31, 0x93, 0x1D, 0x35, 0x0D, 0xF3, 0x2C,  // .1..5..,
                /* 0478 */  0x64, 0xBC, 0xB3, 0x78, 0x0D, 0x78, 0x82, 0xF7,  // d..x.x..
                /* 0480 */  0xE4, 0x9F, 0x85, 0x18, 0xD8, 0x61, 0x05, 0x7B,  // .....a.{
                /* 0488 */  0x14, 0x32, 0xA8, 0xC1, 0x63, 0x87, 0x08, 0x13,  // .2..c...
                /* 0490 */  0xE8, 0x59, 0x88, 0xC5, 0x7D, 0xAE, 0xE8, 0x3C,  // .Y..}..<
                /* 0498 */  0xE1, 0xB3, 0x10, 0xF0, 0xFE, 0xFF, 0x9F, 0x25,  // .......%
                /* 04A0 */  0xE0, 0x5E, 0x0D, 0x9E, 0x85, 0x00, 0x13, 0x87,  // .^......
                /* 04A8 */  0x0D, 0x9F, 0x35, 0xC0, 0x33, 0x7C, 0x8F, 0xEA,  // ..5.3|..
                /* 04B0 */  0x1C, 0x1E, 0x8F, 0x81, 0x7F, 0x56, 0x1D, 0xE7,  // .....V..
                /* 04B8 */  0x04, 0x96, 0x7B, 0xD1, 0xB2, 0x71, 0xA0, 0xA1,  // ..{..q..
                /* 04C0 */  0x23, 0xB2, 0x3A, 0x20, 0x8D, 0x0D, 0x73, 0x29,  // #.: ..s)
                /* 04C8 */  0x89, 0x7C, 0x72, 0x6C, 0xD4, 0x56, 0x04, 0xA7,  // .|rl.V..
                /* 04D0 */  0x33, 0x93, 0x4F, 0x00, 0xD6, 0x42, 0x21, 0x05,  // 3.O..B!.
                /* 04D8 */  0x34, 0x1A, 0x8B, 0xE1, 0x9D, 0xF9, 0xE8, 0x44,  // 4......D
                /* 04E0 */  0x41, 0x0C, 0xE8, 0xE3, 0x90, 0x6D, 0x1C, 0x0A,  // A....m..
                /* 04E8 */  0x50, 0x7B, 0xD1, 0x14, 0xC8, 0x39, 0x07, 0xA3,  // P{...9..
                /* 04F0 */  0x7F, 0x76, 0x74, 0x36, 0xBE, 0x13, 0x70, 0x0D,  // .vt6..p.
                /* 04F8 */  0x10, 0x3A, 0x25, 0x18, 0xDA, 0x6A, 0x04, 0xFC,  // .:%..j..
                /* 0500 */  0xFF, 0x67, 0x89, 0x01, 0x33, 0xFE, 0x53, 0x8C,  // .g..3.S.
                /* 0508 */  0x09, 0x7C, 0x8E, 0xC1, 0x1F, 0x0C, 0xF0, 0x03,  // .|......
                /* 0510 */  0x7F, 0x31, 0xA8, 0xFA, 0x5E, 0xA0, 0xFB, 0x82,  // .1..^...
                /* 0518 */  0xD5, 0xDD, 0x64, 0x20, 0xCC, 0xC8, 0x04, 0xF5,  // ..d ....
                /* 0520 */  0x9D, 0x0E, 0x40, 0x01, 0xE4, 0x0B, 0x81, 0xCF,  // ..@.....
                /* 0528 */  0x51, 0x0F, 0x05, 0x6C, 0x22, 0x21, 0xC2, 0x44,  // Q..l"!.D
                /* 0530 */  0x33, 0x3A, 0x62, 0xC2, 0xA8, 0xE8, 0x13, 0xA6,  // 3:b.....
                /* 0538 */  0x20, 0x9E, 0xB0, 0x63, 0x4D, 0x18, 0x3D, 0x13,  //  ..cM.=.
                /* 0540 */  0x5F, 0x74, 0xD8, 0x88, 0x31, 0x21, 0xAE, 0x1E,  // _t..1!..
                /* 0548 */  0xD0, 0x26, 0x18, 0xD4, 0x97, 0x22, 0x58, 0x43,  // .&..."XC
                /* 0550 */  0xE6, 0x63, 0xF1, 0x05, 0x02, 0x37, 0x65, 0x30,  // .c...7e0
                /* 0558 */  0xCE, 0x89, 0x5D, 0x13, 0x7C, 0xD9, 0xC1, 0xCD,  // ..].|...
                /* 0560 */  0x19, 0x8C, 0xF0, 0x98, 0xBB, 0x18, 0xBF, 0x3A,  // .......:
                /* 0568 */  0x79, 0x74, 0xFC, 0xA0, 0xE0, 0x1B, 0x0E, 0xC3,  // yt......
                /* 0570 */  0x7E, 0x32, 0xF3, 0x8C, 0xDE, 0xCB, 0x7C, 0x8D,  // ~2....|.
                /* 0578 */  0xC3, 0xC0, 0x7A, 0xBC, 0x1C, 0xD6, 0x68, 0x61,  // ..z...ha
                /* 0580 */  0x0F, 0xED, 0x3D, 0xC4, 0xFF, 0xFF, 0x43, 0x8C,  // ..=...C.
                /* 0588 */  0xCF, 0x13, 0xC6, 0x08, 0xEB, 0xDB, 0x0B, 0x38,  // .......8
                /* 0590 */  0xEE, 0x59, 0xF0, 0xEF, 0x1A, 0xE0, 0xB9, 0x84,  // .Y......
                /* 0598 */  0xF8, 0xAE, 0x01, 0x30, 0xF0, 0xFF, 0x7F, 0xD7,  // ...0....
                /* 05A0 */  0x00, 0x4E, 0xD7, 0x04, 0xDF, 0x35, 0x80, 0xF7,  // .N...5..
                /* 05A8 */  0xD0, 0x7D, 0xD7, 0x00, 0xAE, 0xD9, 0xEF, 0x1A,  // .}......
                /* 05B0 */  0xA8, 0x63, 0x80, 0x15, 0xDE, 0x35, 0xA0, 0x5D,  // .c...5.]
                /* 05B8 */  0xD9, 0xDE, 0xD7, 0x9E, 0xB0, 0xAC, 0xE9, 0xB2,  // ........
                /* 05C0 */  0x81, 0x52, 0x73, 0xD9, 0x00, 0x14, 0xFC, 0xFF,  // .Rs.....
                /* 05C8 */  0x2F, 0x1B, 0x80, 0x01, 0x29, 0x13, 0x46, 0x85,  // /...).F.
                /* 05D0 */  0x9F, 0x30, 0x05, 0xF1, 0x84, 0x1D, 0xEC, 0xB2,  // .0......
                /* 05D8 */  0x01, 0x8A, 0x18, 0x97, 0x0D, 0xD0, 0x8F, 0xED,  // ........
                /* 05E0 */  0x65, 0x03, 0x18, 0xDC, 0x13, 0xF8, 0x6D, 0x03,  // e.....m.
                /* 05E8 */  0x78, 0x43, 0xFA, 0xB6, 0x01, 0xD6, 0xFF, 0xFF,  // xC......
                /* 05F0 */  0x6D, 0x03, 0xAC, 0xF9, 0x6F, 0x1B, 0x28, 0x0E,  // m...o.(.
                /* 05F8 */  0xAB, 0xBC, 0x6D, 0x40, 0x3C, 0xC9, 0x33, 0x02,  // ..m@<.3.
                /* 0600 */  0xAB, 0xBA, 0x6E, 0xA0, 0xF4, 0x5C, 0x37, 0x00,  // ..n..\7.
                /* 0608 */  0x12, 0x88, 0x99, 0x30, 0x2A, 0xFE, 0x84, 0x29,  // ...0*..)
                /* 0610 */  0x88, 0x27, 0xEC, 0x68, 0xD7, 0x0D, 0x50, 0x04,  // .'.h..P.
                /* 0618 */  0xB9, 0x6E, 0x80, 0x7E, 0x5E, 0x09, 0xFE, 0xFF,  // .n.~^...
                /* 0620 */  0xAF, 0x1B, 0xC0, 0xE0, 0xA2, 0x80, 0xB9, 0x6F,  // .......o
                /* 0628 */  0x00, 0x6F, 0x58, 0x7E, 0xDF, 0x00, 0x7C, 0xDC,  // .oX~..|.
                /* 0630 */  0xC4, 0x31, 0xF7, 0x0D, 0xC0, 0xCC, 0xFF, 0xFF,  // .1......
                /* 0638 */  0xBE, 0x01, 0xB0, 0xE7, 0xA2, 0x80, 0xBB, 0x6F,  // .......o
                /* 0640 */  0x00, 0xEF, 0x8B, 0xB4, 0xEF, 0x1B, 0x60, 0xFE,  // ......`.
                /* 0648 */  0xFF, 0xDF, 0x37, 0xC0, 0x28, 0x6D, 0xFD, 0x1E,  // ..7.(m..
                /* 0650 */  0x1C, 0x3D, 0x21, 0x78, 0x7C, 0xB8, 0xFB, 0xA5,  // .=!x|...
                /* 0658 */  0xC7, 0xE7, 0xBB, 0x39, 0x38, 0x06, 0x79, 0x8C,  // ...98.y.
                /* 0660 */  0x87, 0x76, 0xC0, 0xAF, 0xEF, 0x9E, 0x98, 0xEF,  // .v......
                /* 0668 */  0xE6, 0xC0, 0xFF, 0x4C, 0x70, 0x3C, 0x18, 0x68,  // ...Lp<.h
                /* 0670 */  0x1C, 0x62, 0xAB, 0x97, 0x06, 0x72, 0x34, 0x38,  // .b...r48
                /* 0678 */  0x3F, 0xDC, 0x19, 0x81, 0x61, 0x15, 0x7F, 0xF2,  // ?...a...
                /* 0680 */  0x47, 0x38, 0xC7, 0xD0, 0xD9, 0xE1, 0x20, 0xB1,  // G8.... .
                /* 0688 */  0x83, 0xE0, 0xC1, 0x56, 0x6D, 0x02, 0x85, 0x86,  // ...Vm...
                /* 0690 */  0x50, 0x14, 0x18, 0x14, 0x8B, 0x0F, 0x18, 0xF8,  // P.......
                /* 0698 */  0x61, 0xB3, 0xB3, 0x00, 0x93, 0x04, 0x87, 0x3A,  // a......:
                /* 06A0 */  0x02, 0xF8, 0x3E, 0xD1, 0xFC, 0x38, 0x74, 0x37,  // ..>..8t7
                /* 06A8 */  0x38, 0x54, 0x8F, 0xE5, 0xA1, 0x80, 0x9E, 0x01,  // 8T......
                /* 06B0 */  0x71, 0xC7, 0x0C, 0x32, 0x69, 0xCF, 0x28, 0xE2,  // q..2i.(.
                /* 06B8 */  0x53, 0xC2, 0x29, 0x85, 0x49, 0xE0, 0xF3, 0x03,  // S.).I...
                /* 06C0 */  0x43, 0xE3, 0x04, 0xAF, 0x0D, 0xA1, 0xF9, 0xFF,  // C.......
                /* 06C8 */  0xFF, 0xA4, 0xC0, 0x3C, 0xDF, 0x31, 0x04, 0x6C,  // ...<.1.l
                /* 06D0 */  0x02, 0xBB, 0xBF, 0x64, 0xC8, 0xDA, 0xC0, 0x75,  // ...d...u
                /* 06D8 */  0x4B, 0x32, 0x44, 0x6F, 0x38, 0xB2, 0x85, 0xA2,  // K2Do8...
                /* 06E0 */  0xE9, 0x44, 0x79, 0xDF, 0x88, 0x62, 0x67, 0x08,  // .Dy..bg.
                /* 06E8 */  0xC2, 0x88, 0x12, 0x2C, 0xC8, 0xA3, 0x42, 0xAC,  // ...,..B.
                /* 06F0 */  0x28, 0x2F, 0x05, 0x46, 0x88, 0x18, 0xE2, 0x95,  // (/.F....
                /* 06F8 */  0x23, 0xD0, 0x09, 0x87, 0x0F, 0xF2, 0xD8, 0x14,  // #.......
                /* 0700 */  0xA7, 0xFD, 0x41, 0x90, 0x58, 0x4F, 0x02, 0x8D,  // ..A.XO..
                /* 0708 */  0xC5, 0x91, 0x46, 0x83, 0x3A, 0x07, 0x78, 0xB8,  // ..F.:.x.
                /* 0710 */  0x3E, 0xC4, 0x78, 0xF8, 0x0F, 0x21, 0x06, 0x39,  // >.x..!.9
                /* 0718 */  0xC8, 0x73, 0x7B, 0x54, 0x38, 0x4E, 0x5F, 0x25,  // .s{T8N_%
                /* 0720 */  0x4C, 0xF0, 0x02, 0xE0, 0x83, 0x0A, 0x1C, 0xD7,  // L.......
                /* 0728 */  0x80, 0x9A, 0xF1, 0x33, 0x06, 0x58, 0x8E, 0xE3,  // ...3.X..
                /* 0730 */  0x3E, 0xA9, 0xC0, 0x1D, 0x8F, 0xEF, 0x07, 0x6C,  // >......l
                /* 0738 */  0xC2, 0x09, 0x2C, 0x7F, 0x10, 0xA8, 0xE3, 0x0C,  // ..,.....
                /* 0740 */  0x9F, 0xE7, 0x0B, 0x8B, 0x21, 0x1F, 0x13, 0x4C,  // ....!..L
                /* 0748 */  0x60, 0xB1, 0x27, 0x1B, 0x3A, 0x1E, 0xF0, 0xDF,  // `.'.:...
                /* 0750 */  0x63, 0x1E, 0x2F, 0x7C, 0x32, 0xF1, 0x7C, 0x4D,  // c./|2.|M
                /* 0758 */  0x30, 0x22, 0x84, 0x9C, 0x8C, 0x07, 0x7D, 0x87,  // 0"....}.
                /* 0760 */  0xC0, 0x5C, 0x6F, 0xD8, 0xB9, 0x85, 0x8B, 0x3A,  // .\o....:
                /* 0768 */  0x68, 0xA0, 0x4E, 0x0B, 0x3E, 0x28, 0xB0, 0x9B,  // h.N.>(..
                /* 0770 */  0x11, 0xE6, 0xB8, 0xCE, 0xCF, 0x2A, 0x60, 0xF8,  // .....*`.
                /* 0778 */  0xFF, 0x9F, 0x55, 0x60, 0x8F, 0x10, 0xFE, 0xED,  // ..U`....
                /* 0780 */  0xC1, 0xF3, 0xF2, 0x95, 0xE1, 0xD5, 0x21, 0x81,  // ......!.
                /* 0788 */  0x43, 0x8E, 0x10, 0x3D, 0x2E, 0x8F, 0x10, 0x73,  // C..=...s
                /* 0790 */  0x3E, 0xC2, 0x0C, 0x11, 0x5C, 0x67, 0x01, 0x70,  // >...\g.p
                /* 0798 */  0x0C, 0x11, 0xF8, 0x1C, 0x70, 0xC0, 0x71, 0x69,  // ....p.qi
                /* 07A0 */  0xE2, 0x03, 0xF5, 0x01, 0x07, 0x70, 0x70, 0x4D,  // .....ppM
                /* 07A8 */  0xC3, 0x1D, 0x70, 0xC0, 0x71, 0x16, 0x60, 0xFF,  // ..p.q.`.
                /* 07B0 */  0xFF, 0xC3, 0x0D, 0x2C, 0x49, 0x26, 0x0E, 0x23,  // ...,I&.#
                /* 07B8 */  0x18, 0x11, 0x30, 0x28, 0x02, 0x02, 0xA4, 0xB3,  // ..0(....
                /* 07C0 */  0x80, 0x0F, 0x29, 0x00, 0x1F, 0xAE, 0x0C, 0x0F,  // ..).....
                /* 07C8 */  0x29, 0xD8, 0x93, 0x86, 0x07, 0x8E, 0x1B, 0x85,  // ).......
                /* 07D0 */  0x07, 0x8D, 0x0B, 0x30, 0x68, 0x7A, 0xE2, 0x80,  // ...0hz..
                /* 07D8 */  0x7F, 0x4C, 0xF0, 0x19, 0x05, 0x1C, 0xE3, 0x06,  // .L......
                /* 07E0 */  0xDF, 0x2A, 0x0C, 0xFC, 0xFF, 0x3F, 0x30, 0xCC,  // .*...?0.
                /* 07E8 */  0xE1, 0xC2, 0x63, 0x39, 0x8A, 0xA0, 0x07, 0x1E,  // ..c9....
                /* 07F0 */  0xD4, 0xF7, 0x8C, 0x33, 0xF7, 0x24, 0x8F, 0xD1,  // ...3.$..
                /* 07F8 */  0x51, 0x0F, 0x27, 0xF4, 0xE4, 0x85, 0x3B, 0x57,  // Q.'...;W
                /* 0800 */  0xF9, 0x0A, 0x71, 0x14, 0x18, 0xB8, 0x77, 0x29,  // ..q...w)
                /* 0808 */  0x8F, 0xCF, 0x17, 0x2B, 0xC3, 0x63, 0x46, 0xFB,  // ...+.cF.
                /* 0810 */  0x1E, 0x72, 0xD6, 0x11, 0x02, 0xE2, 0x2F, 0x75,  // .r..../u
                /* 0818 */  0x6C, 0xC0, 0x60, 0x39, 0x18, 0x00, 0x87, 0x01,  // l.`9....
                /* 0820 */  0xE3, 0x13, 0x0D, 0x58, 0x67, 0x1B, 0x3C, 0xF4,  // ...Xg.<.
                /* 0828 */  0x69, 0x31, 0xC4, 0xE3, 0x0B, 0xFB, 0x56, 0x61,  // i1....Va
                /* 0830 */  0x82, 0xEA, 0x41, 0x75, 0x12, 0xF4, 0xD0, 0xC0,  // ..Au....
                /* 0838 */  0x01, 0xE8, 0xA1, 0xC1, 0x3F, 0xB9, 0x90, 0xFB,  // ....?...
                /* 0840 */  0x2B, 0x1D, 0x82, 0xB5, 0xE2, 0x69, 0xDE, 0x47,  // +....i.G
                /* 0848 */  0x1E, 0xF3, 0xDC, 0xA2, 0xBC, 0x0D, 0x3C, 0x07,  // ......<.
                /* 0850 */  0xF0, 0xD3, 0x82, 0x87, 0xE3, 0x63, 0x81, 0xC7,  // .....c..
                /* 0858 */  0xE9, 0x4B, 0x58, 0x82, 0xF7, 0x1A, 0x9F, 0x6C,  // .KX....l
                /* 0860 */  0x1E, 0x5C, 0x58, 0xB2, 0x21, 0xA0, 0x06, 0xEB,  // .\X.!...
                /* 0868 */  0x21, 0x60, 0xA6, 0x9A, 0xC0, 0x49, 0x46, 0x80,  // !`...IF.
                /* 0870 */  0xCA, 0x00, 0xA1, 0x1B, 0xCB, 0xE9, 0x3E, 0x8B,  // ......>.
                /* 0878 */  0x84, 0x38, 0xCD, 0x47, 0x99, 0xC7, 0x02, 0x8F,  // .8.G....
                /* 0880 */  0xF5, 0xC1, 0xC0, 0xFF, 0x7F, 0xCD, 0x23, 0xD4,  // ......#.
                /* 0888 */  0x7D, 0xCD, 0x33, 0x7B, 0x3A, 0xC0, 0xAC, 0x22,  // }.3{:.."
                /* 0890 */  0xDC, 0x7B, 0xCE, 0x1B, 0x86, 0xD1, 0x9E, 0x2D,  // .{.....-
                /* 0898 */  0x7C, 0xCD, 0x78, 0xD6, 0x34, 0x42, 0x38, 0x76,  // |.x.4B8v
                /* 08A0 */  0x83, 0xF3, 0x48, 0x8C, 0xF0, 0x82, 0xC0, 0x4E,  // ..H....N
                /* 08A8 */  0x0C, 0x0F, 0x30, 0xC6, 0x39, 0x79, 0xC3, 0xFA,  // ..0.9y..
                /* 08B0 */  0xC2, 0xCB, 0x40, 0x83, 0x19, 0xDB, 0x97, 0x01,  // ..@.....
                /* 08B8 */  0x36, 0x2A, 0xDF, 0x88, 0xC0, 0x97, 0xFC, 0x62,  // 6*.....b
                /* 08C0 */  0x00, 0x65, 0x16, 0xBE, 0x9E, 0xF8, 0xA0, 0xC4,  // .e......
                /* 08C8 */  0x2E, 0x06, 0x2C, 0xE5, 0xC5, 0x00, 0x54, 0x37,  // ..,...T7
                /* 08D0 */  0x0C, 0x5F, 0x0C, 0xE0, 0x5F, 0x89, 0x5E, 0x0C,  // ._.._.^.
                /* 08D8 */  0xC0, 0x70, 0x71, 0xF2, 0x3D, 0xC0, 0x1E, 0xEE,  // .pq.=...
                /* 08E0 */  0xA3, 0x74, 0x9C, 0xBE, 0xFD, 0xBD, 0x19, 0xF8,  // .t......
                /* 08E8 */  0x6C, 0xC0, 0x60, 0x3C, 0xC3, 0x30, 0xC6, 0x08,  // l.`<.0..
                /* 08F0 */  0xE3, 0x51, 0x86, 0x31, 0xC1, 0xDC, 0xB7, 0x03,  // .Q.1....
                /* 08F8 */  0xE8, 0x39, 0x87, 0x81, 0x4A, 0x78, 0x3B, 0x80,  // .9..Jx;.
                /* 0900 */  0x72, 0x0E, 0xE8, 0xF2, 0x68, 0x42, 0x4F, 0x01,  // r...hBO.
                /* 0908 */  0x4F, 0x07, 0x3E, 0x29, 0x1A, 0xA2, 0xAF, 0xB1,  // O.>)....
                /* 0910 */  0x0A, 0x26, 0x50, 0xC4, 0x07, 0x0D, 0x3E, 0xB5,  // .&P...>.
                /* 0918 */  0x28, 0x3E, 0x15, 0x78, 0x2D, 0xCF, 0x4E, 0xE1,  // (>.x-.N.
                /* 0920 */  0xE2, 0x9C, 0x89, 0xA7, 0x6A, 0x38, 0x03, 0xBD,  // ....j8..
                /* 0928 */  0xE6, 0x86, 0x63, 0xFF, 0x7F, 0x38, 0xFC, 0xA9,  // ..c..8..
                /* 0930 */  0xE0, 0x35, 0x80, 0x1D, 0x24, 0x3D, 0x2D, 0x23,  // .5..$=-#
                /* 0938 */  0xC2, 0x38, 0xA4, 0x3C, 0x32, 0xF8, 0xB6, 0x18,  // .8.<2...
                /* 0940 */  0xC7, 0x90, 0x0F, 0x91, 0xBE, 0x13, 0x18, 0xF2,  // ........
                /* 0948 */  0x21, 0xEF, 0x79, 0xC7, 0xC0, 0xAF, 0x08, 0x71,  // !.y....q
                /* 0950 */  0x9E, 0xB2, 0x7C, 0x67, 0xF0, 0x65, 0x01, 0x7C,  // ..|g.e.|
                /* 0958 */  0x91, 0x2E, 0x0B, 0x68, 0x68, 0x9F, 0x64, 0x7C,  // ...hh.d|
                /* 0960 */  0x41, 0x30, 0xEC, 0x89, 0xB3, 0x00, 0x77, 0x05,  // A0....w.
                /* 0968 */  0x50, 0x81, 0xFA, 0xAE, 0x00, 0xFF, 0x42, 0xF0,  // P.....B.
                /* 0970 */  0xAE, 0x00, 0x86, 0x79, 0xF9, 0x56, 0xC0, 0x35,  // ...y.V.5
                /* 0978 */  0x1D, 0x4A, 0xD0, 0x67, 0x12, 0x5F, 0x17, 0x70,  // .J.g._.p
                /* 0980 */  0x53, 0x64, 0xA9, 0x8E, 0x0A, 0xD0, 0x53, 0x4C,  // Sd....SL
                /* 0988 */  0x02, 0x75, 0x47, 0xF7, 0x51, 0x01, 0xC6, 0x4D,  // .uG.Q..M
                /* 0990 */  0xD9, 0x07, 0x54, 0x76, 0x5A, 0x60, 0x67, 0x21,  // ..TvZ`g!
                /* 0998 */  0x76, 0x1D, 0xC1, 0x5D, 0x49, 0x18, 0xCA, 0xB3,  // v..]I...
                /* 09A0 */  0x81, 0x2F, 0x59, 0xFC, 0x70, 0x00, 0x03, 0xDC,  // ./Y.p...
                /* 09A8 */  0xB3, 0x38, 0xC4, 0x08, 0xB1, 0xD9, 0x81, 0xEB,  // .8......
                /* 09B0 */  0x75, 0xD2, 0x70, 0x2F, 0x44, 0xEC, 0xFF, 0x7F,  // u.p/D...
                /* 09B8 */  0x32, 0x00, 0xE3, 0x51, 0x1B, 0x1C, 0x27, 0x9D,  // 2..Q..'.
                /* 09C0 */  0xF0, 0x91, 0x9E, 0x59, 0xF8, 0x49, 0x19, 0x30,  // ...Y.I.0
                /* 09C8 */  0x71, 0xF2, 0x03, 0xE3, 0xC9, 0x1A, 0xC6, 0x00,  // q.......
                /* 09D0 */  0xB8, 0xBC, 0x57, 0x95, 0x81, 0xFC, 0x43, 0x90,  // ..W...C.
                /* 09D8 */  0x20, 0x18, 0xD4, 0x29, 0x19, 0x38, 0x1C, 0xC5,  //  ..).8..
                /* 09E0 */  0x70, 0xA7, 0x64, 0x78, 0x50, 0xF8, 0xC3, 0x00,  // p.dxP...
                /* 09E8 */  0xE6, 0x46, 0xE8, 0x7B, 0x82, 0xA1, 0xDE, 0x93,  // .F.{....
                /* 09F0 */  0x0E, 0xE3, 0x91, 0xD0, 0x04, 0x3E, 0x2D, 0xC3,  // .....>-.
                /* 09F8 */  0xFA, 0xFF, 0x9F, 0x96, 0xF9, 0x39, 0x21, 0xFE,  // .....9!.
                /* 0A00 */  0x53, 0xCE, 0xFB, 0xC5, 0x83, 0xB2, 0x31, 0xA2,  // S.....1.
                /* 0A08 */  0xBC, 0x2A, 0xFB, 0x9C, 0x69, 0x14, 0x76, 0x4B,  // .*..i.vK
                /* 0A10 */  0x7E, 0x73, 0x78, 0x55, 0xF6, 0x69, 0xF9, 0xDC,  // ~sxU.i..
                /* 0A18 */  0x22, 0xBD, 0x2F, 0x7B, 0xE4, 0x31, 0xE3, 0xC4,  // "./{.1..
                /* 0A20 */  0x0A, 0x12, 0xE8, 0x7D, 0x23, 0x4A, 0xD8, 0x18,  // ...}#J..
                /* 0A28 */  0xE1, 0x02, 0x3D, 0x2D, 0xB3, 0x63, 0xBB, 0x87,  // ..=-.c..
                /* 0A30 */  0xEC, 0xB3, 0x02, 0xEE, 0xEC, 0x00, 0x77, 0x7A,  // ......wz
                /* 0A38 */  0xFC, 0xF4, 0x00, 0x38, 0x01, 0x7A, 0x7A, 0x00,  // ...8.zz.
                /* 0A40 */  0xDB, 0x79, 0x03, 0xEE, 0x81, 0x00, 0x71, 0xFC,  // .y....q.
                /* 0A48 */  0x47, 0x05, 0xBF, 0xB2, 0x50, 0x38, 0x7E, 0x6C,  // G...P8~l
                /* 0A50 */  0xE7, 0xC7, 0x12, 0xDC, 0xE1, 0xC0, 0x47, 0x06,  // ......G.
                /* 0A58 */  0x1F, 0x20, 0x71, 0x43, 0xF1, 0xA1, 0x02, 0x79,  // . qC...y
                /* 0A60 */  0x16, 0x00, 0xC5, 0xE8, 0xD9, 0x08, 0xD8, 0x0D,  // ........
                /* 0A68 */  0xE6, 0xA5, 0x25, 0xCA, 0xFF, 0xFF, 0xBD, 0x81,  // ..%.....
                /* 0A70 */  0x9D, 0x52, 0x70, 0x07, 0x01, 0xF0, 0x1D, 0x03,  // .Rp.....
                /* 0A78 */  0xC0, 0x3B, 0x18, 0x2E, 0x6B, 0xCC, 0x28, 0x21,  // .;..k.(!
                /* 0A80 */  0x30, 0x1A, 0x33, 0xEE, 0x10, 0xC2, 0x4F, 0x04,  // 0.3...O.
                /* 0A88 */  0xB8, 0x31, 0x7B, 0xDC, 0x1E, 0x33, 0xEE, 0x38,  // .1{..3.8
                /* 0A90 */  0xCB, 0x47, 0xF5, 0x94, 0x11, 0xCA, 0x07, 0x0E,  // .G......
                /* 0A98 */  0x76, 0xCE, 0x78, 0x23, 0xE0, 0x43, 0x07, 0x1E,  // v.x#.C..
                /* 0AA0 */  0x07, 0x18, 0xDC, 0x91, 0x02, 0x8C, 0x97, 0x03,  // ........
                /* 0AA8 */  0x36, 0x76, 0x70, 0x07, 0x21, 0xA7, 0x40, 0x96,  // 6vp.!.@.
                /* 0AB0 */  0x0E, 0xA3, 0xB1, 0xE3, 0x64, 0x03, 0xE9, 0x18,  // ....d...
                /* 0AB8 */  0xE3, 0x43, 0xAE, 0xC7, 0x8E, 0x1B, 0xAC, 0xC7,  // .C......
                /* 0AC0 */  0x8E, 0x3B, 0xBE, 0x60, 0xFF, 0xFF, 0xC7, 0x17,  // .;.`....
                /* 0AC8 */  0x30, 0x8C, 0x81, 0x8B, 0x1F, 0x06, 0xFA, 0xE6,  // 0.......
                /* 0AD0 */  0xE7, 0xD1, 0x19, 0xDC, 0xC3, 0xF6, 0x09, 0x26,  // .......&
                /* 0AD8 */  0xC6, 0x1B, 0x4C, 0x88, 0x47, 0x96, 0x97, 0x96,  // ..L.G...
                /* 0AE0 */  0x08, 0x0F, 0x2D, 0xBE, 0xB9, 0xBC, 0xB4, 0xF8,  // ..-.....
                /* 0AE8 */  0x16, 0x63, 0x94, 0x10, 0x11, 0x0E, 0x26, 0xCE,  // .c....&.
                /* 0AF0 */  0x13, 0x8C, 0x11, 0x0E, 0x3C, 0x8A, 0x21, 0x22,  // ....<.!"
                /* 0AF8 */  0x9C, 0x40, 0x88, 0x93, 0x3E, 0xD9, 0x20, 0xE1,  // .@..>. .
                /* 0B00 */  0x63, 0x84, 0x8D, 0x16, 0xE5, 0x09, 0x86, 0x8D,  // c.......
                /* 0B08 */  0x85, 0x9F, 0x57, 0x3C, 0x78, 0x7E, 0x5A, 0xF3,  // ..W<x~Z.
                /* 0B10 */  0x5D, 0xD0, 0x93, 0x39, 0xC7, 0x87, 0x2C, 0x4F,  // ]..9..,O
                /* 0B18 */  0xED, 0x71, 0xD2, 0x87, 0x59, 0xDC, 0xA0, 0x1E,  // .q..Y...
                /* 0B20 */  0x1C, 0xD9, 0x5D, 0xC7, 0xC7, 0x6B, 0xEC, 0x29,  // ..]..k.)
                /* 0B28 */  0xC8, 0x43, 0xE0, 0x27, 0x02, 0x5F, 0x10, 0x3D,  // .C.'._.=
                /* 0B30 */  0x59, 0xDF, 0xF5, 0xD8, 0xBD, 0xCC, 0x18, 0xD5,  // Y.......
                /* 0B38 */  0x4F, 0x01, 0x75, 0x4C, 0x39, 0x83, 0x57, 0x08,  // O.uL9.W.
                /* 0B40 */  0x76, 0xCF, 0xF3, 0x21, 0xDB, 0x77, 0x49, 0x36,  // v..!.wI6
                /* 0B48 */  0x0A, 0xDC, 0x21, 0xC1, 0x67, 0x24, 0x7E, 0xAA,  // ..!.g$~.
                /* 0B50 */  0xF0, 0x30, 0x3C, 0x0A, 0x18, 0x33, 0x78, 0x47,  // .0<..3xG
                /* 0B58 */  0x38, 0xB4, 0x10, 0x07, 0xFC, 0xBE, 0xCB, 0x86,  // 8.......
                /* 0B60 */  0x1A, 0xE3, 0xF4, 0x7C, 0xFE, 0x60, 0x83, 0x80,  // ...|.`..
                /* 0B68 */  0x0F, 0x75, 0xA8, 0x1E, 0xE6, 0x51, 0xBD, 0x14,  // .u...Q..
                /* 0B70 */  0x32, 0x9C, 0xB3, 0x83, 0x3B, 0x08, 0xEC, 0xF1,  // 2...;...
                /* 0B78 */  0xC3, 0x83, 0xE0, 0x37, 0x4B, 0x3E, 0x08, 0x76,  // ...7K>.v
                /* 0B80 */  0xBE, 0x79, 0x83, 0x33, 0xC8, 0xFF, 0xFF, 0x18,  // .y.3....
                /* 0B88 */  0x60, 0x9F, 0xA9, 0x7C, 0x34, 0x41, 0x1C, 0x01,  // `..|4A..
                /* 0B90 */  0xD1, 0xE7, 0x0F, 0x8F, 0xE1, 0x4D, 0x8E, 0x0F,  // .....M..
                /* 0B98 */  0x07, 0x7B, 0xF4, 0xC0, 0x9D, 0x44, 0xE0, 0x1E,  // .{...D..
                /* 0BA0 */  0xBB, 0x0E, 0xDA, 0xD7, 0x38, 0x5F, 0xB4, 0x60,  // ....8_.`
                /* 0BA8 */  0xDC, 0xF7, 0x9E, 0x45, 0xC0, 0x8F, 0xF1, 0xD8,  // ...E....
                /* 0BB0 */  0x02, 0x8E, 0x43, 0x09, 0xB8, 0x83, 0x1D, 0xD7,  // ..C.....
                /* 0BB8 */  0x38, 0x84, 0xA2, 0xC0, 0xE8, 0x50, 0x82, 0x8B,  // 8....P..
                /* 0BC0 */  0x01, 0x24, 0x18, 0xC7, 0x38, 0xA3, 0xA1, 0x2F,  // .$..8../
                /* 0BC8 */  0x91, 0x3E, 0xA4, 0xC1, 0x19, 0x34, 0xEC, 0x79,  // .>...4.y
                /* 0BD0 */  0x3E, 0xA1, 0x70, 0x7B, 0x02, 0x14, 0x9D, 0x50,  // >.p{...P
                /* 0BD8 */  0x40, 0x86, 0xFB, 0x0C, 0x82, 0x3D, 0x21, 0xF0,  // @....=!.
                /* 0BE0 */  0x33, 0x08, 0xFB, 0xFF, 0x1F, 0x1C, 0x3D, 0xEE,  // 3.....=.
                /* 0BE8 */  0xF7, 0x46, 0x9F, 0x1A, 0xD9, 0xDC, 0x1F, 0x02,  // .F......
                /* 0BF0 */  0x4E, 0xE0, 0xDC, 0xD9, 0xA9, 0x19, 0x77, 0x66,  // N.....wf
                /* 0BF8 */  0xC0, 0x9E, 0x3F, 0x3C, 0x04, 0x7E, 0x2E, 0xF0,  // ..?<.~..
                /* 0C00 */  0xF0, 0x3D, 0x04, 0xFC, 0xE0, 0x1F, 0x98, 0x0D,  // .=......
                /* 0C08 */  0x0E, 0xC6, 0x53, 0x84, 0xAF, 0x1D, 0x1C, 0x9C,  // ..S.....
                /* 0C10 */  0x9F, 0x06, 0x0C, 0xCE, 0x5F, 0xA1, 0x3E, 0xCF,  // ...._.>.
                /* 0C18 */  0x33, 0x70, 0xEC, 0xA9, 0xD7, 0xF7, 0x0E, 0xCF,  // 3p......
                /* 0C20 */  0xD7, 0x87, 0x0A, 0xFC, 0x4D, 0xCF, 0x87, 0x0A,  // ....M...
                /* 0C28 */  0x70, 0x1C, 0x1E, 0xF8, 0x61, 0x85, 0x0D, 0xE1,  // p...a...
                /* 0C30 */  0x51, 0x00, 0x7F, 0x6A, 0xF1, 0xF1, 0x2F, 0xCE,  // Q..j../.
                /* 0C38 */  0x53, 0x04, 0xBB, 0x8D, 0x60, 0x0F, 0x17, 0x80,  // S...`...
                /* 0C40 */  0xA3, 0x68, 0x67, 0x31, 0x54, 0x98, 0xB3, 0x18,  // .hg1T...
                /* 0C48 */  0xF9, 0xFF, 0x9F, 0xA3, 0x50, 0x67, 0x31, 0x7A,  // ....Pg1z
                /* 0C50 */  0xB8, 0x00, 0x5C, 0x08, 0x3E, 0x1E, 0x80, 0xE6,  // ..\.>...
                /* 0C58 */  0x20, 0xF0, 0xB8, 0xE0, 0x0B, 0xC1, 0x91, 0x1C,  //  .......
                /* 0C60 */  0xC8, 0xD3, 0x01, 0xE0, 0x53, 0x1E, 0x09, 0x3D,  // ....S..=
                /* 0C68 */  0x1F, 0x59, 0x10, 0x0C, 0xEA, 0x7C, 0xE0, 0x13,  // .Y...|..
                /* 0C70 */  0x8A, 0x8F, 0x1D, 0xFC, 0x6C, 0xE0, 0x1B, 0xB9,  // ....l...
                /* 0C78 */  0x87, 0xCA, 0x4F, 0xCD, 0x3E, 0x69, 0xF3, 0xE0,  // ..O.>i..
                /* 0C80 */  0x3F, 0x69, 0xD9, 0x80, 0x51, 0xA0, 0x61, 0xA0,  // ?i..Q.a.
                /* 0C88 */  0x46, 0xE4, 0x23, 0xD2, 0xFF, 0xFF, 0xB9, 0x0D,  // F.#.....
                /* 0C90 */  0x1B, 0x60, 0x68, 0xF4, 0x1C, 0x0E, 0xE3, 0x80,  // .`h.....
                /* 0C98 */  0xEB, 0x73, 0x38, 0x76, 0x40, 0x3E, 0x87, 0xC3,  // .s8v@>..
                /* 0CA0 */  0x3F, 0x47, 0xC3, 0x1F, 0x1B, 0x3B, 0xDD, 0xF3,  // ?G...;..
                /* 0CA8 */  0x81, 0xC1, 0xBA, 0x7E, 0x63, 0x06, 0x06, 0xB6,  // ...~c...
                /* 0CB0 */  0x6F, 0x91, 0x07, 0x06, 0x1C, 0x51, 0xCF, 0xC6,  // o....Q..
                /* 0CB8 */  0x57, 0x08, 0x0F, 0x0C, 0x6C, 0x80, 0x1E, 0x18,  // W...l...
                /* 0CC0 */  0xF0, 0x89, 0x05, 0x21, 0x27, 0x03, 0x43, 0x9D,  // ...!'.C.
                /* 0CC8 */  0x32, 0x8C, 0x1C, 0xF3, 0x89, 0xC3, 0xC3, 0xF0,  // 2.......
                /* 0CD0 */  0xA1, 0x22, 0xEA, 0x33, 0xC0, 0x23, 0x1E, 0x1B,  // .".3.#..
                /* 0CD8 */  0x1B, 0xFB, 0xFF, 0x8F, 0x0D, 0x2C, 0xC7, 0x16,  // .....,..
                /* 0CE0 */  0x8F, 0x0D, 0xFC, 0x47, 0x78, 0xFC, 0xD8, 0xE0,  // ...Gx...
                /* 0CE8 */  0x8C, 0xE5, 0xD1, 0xC4, 0x97, 0x99, 0x23, 0x3B,  // ......#;
                /* 0CF0 */  0x8D, 0x33, 0x7B, 0x0D, 0xF1, 0xD1, 0xEE, 0xF1,  // .3{.....
                /* 0CF8 */  0xDB, 0x63, 0x03, 0x97, 0x85, 0xB1, 0x01, 0xA5,  // .c......
                /* 0D00 */  0x90, 0x63, 0x43, 0x1F, 0x52, 0x7C, 0x0A, 0xB0,  // .cC.R|..
                /* 0D08 */  0x71, 0x54, 0x32, 0x0F, 0x1F, 0xAF, 0x7C, 0x62,  // qT2...|b
                /* 0D10 */  0x38, 0xBA, 0x20, 0x6F, 0xE8, 0xBE, 0x5C, 0xF8,  // 8. o..\.
                /* 0D18 */  0x48, 0x63, 0x30, 0x5F, 0x5A, 0x7C, 0x06, 0xE5,  // Hc0_Z|..
                /* 0D20 */  0x43, 0x04, 0x97, 0x86, 0x21, 0x02, 0xA5, 0x50,  // C...!..P
                /* 0D28 */  0x43, 0x44, 0x8F, 0xE7, 0xFF, 0xFF, 0x08, 0xE6,  // CD......
                /* 0D30 */  0x21, 0xB2, 0xA1, 0x81, 0xF7, 0x1B, 0xA3, 0xA1,  // !.......
                /* 0D38 */  0x01, 0xA1, 0x70, 0x43, 0x43, 0x1F, 0xD6, 0x7C,  // ..pCC..|
                /* 0D40 */  0x08, 0x60, 0x10, 0xBE, 0x0D, 0xB0, 0xAB, 0x80,  // .`......
                /* 0D48 */  0xAF, 0x42, 0x1E, 0xE0, 0x93, 0x28, 0x1B, 0x1E,  // .B...(..
                /* 0D50 */  0xF8, 0x06, 0xE5, 0xE1, 0x01, 0x9F, 0xF0, 0xC0,  // ........
                /* 0D58 */  0x5E, 0x85, 0x87, 0x47, 0xCF, 0x4A, 0x1E, 0x1E,  // ^..G.J..
                /* 0D60 */  0x3C, 0x90, 0xC7, 0x08, 0x76, 0x0E, 0xF1, 0xE0,  // <...v...
                /* 0D68 */  0xC0, 0x61, 0x62, 0x70, 0xA0, 0x38, 0xFA, 0xE3,  // .abp.8..
                /* 0D70 */  0x86, 0xC0, 0x2E, 0xB3, 0x9E, 0x38, 0xBF, 0xB2,  // .....8..
                /* 0D78 */  0x78, 0x50, 0xF8, 0xFF, 0xFF, 0x11, 0x00, 0xD6,  // xP......
                /* 0D80 */  0x71, 0x06, 0x7C, 0xC1, 0x0E, 0x07, 0xE8, 0x63,  // q.|....c
                /* 0D88 */  0x22, 0x1B, 0xC3, 0x43, 0xC4, 0x83, 0xAB, 0x07,  // "..C....
                /* 0D90 */  0xE2, 0x6B, 0xC7, 0x6B, 0x31, 0xEE, 0x68, 0x00,  // .k.k1.h.
                /* 0D98 */  0x2E, 0x15, 0x47, 0x03, 0xA0, 0x74, 0xB0, 0x05,  // ..G..t..
                /* 0DA0 */  0xC7, 0x3D, 0xCD, 0x47, 0x3B, 0xCC, 0x1C, 0x3D,  // .=.G;..=
                /* 0DA8 */  0x80, 0xE7, 0x37, 0x8F, 0x96, 0x9F, 0xDF, 0x00,  // ..7.....
                /* 0DB0 */  0x47, 0x41, 0x0F, 0xB6, 0x74, 0xE0, 0x8E, 0x06,  // GA..t...
                /* 0DB8 */  0x83, 0x3A, 0xBF, 0x61, 0xFE, 0xFF, 0xE7, 0x37,  // .:.a...7
                /* 0DC0 */  0x30, 0x44, 0x00, 0xD7, 0x99, 0xC6, 0xE7, 0x17,  // 0D......
                /* 0DC8 */  0x38, 0x43, 0x3D, 0x68, 0x5F, 0x13, 0x3C, 0x6B,  // 8C=h_.<k
                /* 0DD0 */  0xDF, 0xB8, 0xD8, 0x39, 0x01, 0x5C, 0x03, 0xF2,  // ...9.\..
                /* 0DD8 */  0x49, 0x07, 0x38, 0x02, 0x9F, 0xC4, 0x03, 0xFE,  // I.8.....
                /* 0DE0 */  0xA1, 0x81, 0x79, 0x58, 0x1E, 0x1A, 0xF0, 0x39,  // ..yX...9
                /* 0DE8 */  0x1A, 0xE0, 0x4E, 0x14, 0xE0, 0xB9, 0x8D, 0xE0,  // ..N.....
                /* 0DF0 */  0x0E, 0x14, 0xC0, 0xE2, 0xFF, 0x7F, 0xA0, 0x00,  // ........
                /* 0DF8 */  0x56, 0x47, 0x7C, 0x8F, 0x8B, 0x43, 0xE3, 0x10,  // VG|..C..
                /* 0E00 */  0x1F, 0xD2, 0xCE, 0xD9, 0xE7, 0xAF, 0x33, 0xC5,  // ......3.
                /* 0E08 */  0x9D, 0x45, 0xC0, 0x70, 0xA2, 0x47, 0xBC, 0xD3,  // .E.p.G..
                /* 0E10 */  0x0C, 0xE4, 0x07, 0x86, 0x84, 0xC0, 0xA0, 0x4E,  // .......N
                /* 0E18 */  0x40, 0x1E, 0x8A, 0x0F, 0x06, 0x1C, 0xD8, 0x47,  // @......G
                /* 0E20 */  0x04, 0x76, 0x2E, 0x60, 0x07, 0x28, 0xC3, 0xF1,  // .v.`.(..
                /* 0E28 */  0xB3, 0x80, 0x4F, 0x09, 0x0F, 0x35, 0xC7, 0xF1,  // ..O..5..
                /* 0E30 */  0xB8, 0xE9, 0xBB, 0x99, 0x21, 0xD9, 0xD5, 0xE0,  // ....!...
                /* 0E38 */  0xF9, 0x07, 0x7B, 0xDA, 0x85, 0x73, 0xC4, 0x05,  // ..{..s..
                /* 0E40 */  0x17, 0x81, 0xCF, 0x3A, 0x1E, 0x05, 0x3F, 0x3D,  // ...:..?=
                /* 0E48 */  0x78, 0x8E, 0x6F, 0x0C, 0x3E, 0x3D, 0x30, 0xF7,  // x.o.>=0.
                /* 0E50 */  0x02, 0xCC, 0x1D, 0xBA, 0x85, 0x70, 0x4C, 0xAF,  // .....pL.
                /* 0E58 */  0x0F, 0x31, 0x8E, 0xFA, 0xB1, 0xA1, 0x2D, 0x01,  // .1....-.
                /* 0E60 */  0xDA, 0x50, 0x74, 0x07, 0x78, 0x19, 0x88, 0x12,  // .Pt.x...
                /* 0E68 */  0xE2, 0x08, 0x22, 0xB5, 0x86, 0xA2, 0x99, 0x47,  // .."....G
                /* 0E70 */  0x8A, 0x12, 0x30, 0x9E, 0x61, 0x1A, 0x9B, 0x8C,  // ..0.a...
                /* 0E78 */  0x20, 0x63, 0x84, 0x8E, 0x13, 0x2C, 0x4A, 0xB4,  //  c...,J.
                /* 0E80 */  0x57, 0x80, 0xF6, 0x47, 0xCB, 0x56, 0xAC, 0xB1,  // W..G.V..
                /* 0E88 */  0x38, 0xD2, 0xC9, 0x12, 0x3D, 0x6C, 0x1F, 0xB3,  // 8...=l..
                /* 0E90 */  0xF1, 0xA7, 0x55, 0xCC, 0xFF, 0x9F, 0xE0, 0x55,  // ..U....U
                /* 0E98 */  0xC5, 0x07, 0x05, 0x1F, 0x00, 0xF0, 0x2E, 0x01,  // ........
                /* 0EA0 */  0x75, 0x75, 0xF4, 0xB8, 0x7D, 0xDE, 0x00, 0xFF,  // uu..}...
                /* 0EA8 */  0xF5, 0x02, 0x4B, 0x50, 0xFE, 0x20, 0x50, 0x23,  // ..KP. P#
                /* 0EB0 */  0x33, 0xB4, 0xC7, 0xF9, 0x36, 0x63, 0xC8, 0x27,  // 3...6c.'
                /* 0EB8 */  0x27, 0x13, 0x58, 0xEC, 0x09, 0x15, 0x68, 0x0C,  // '.X...h.
                /* 0EC0 */  0xFE, 0x69, 0xC3, 0xD7, 0x76, 0xCF, 0xD7, 0xE7,  // .i..v...
                /* 0EC8 */  0x38, 0x80, 0x0F, 0xFF, 0xFF, 0x73, 0x1C, 0x60,  // 8....s.`
                /* 0ED0 */  0x68, 0x38, 0xB8, 0xA3, 0x0F, 0xDC, 0x2B, 0x09,  // h8....+.
                /* 0ED8 */  0x3F, 0xFC, 0x00, 0xCE, 0x80, 0x1E, 0x7E, 0xC0,  // ?.....~.
                /* 0EE0 */  0x3E, 0x54, 0xDC, 0x10, 0x78, 0x84, 0x15, 0xD1,  // >T..x...
                /* 0EE8 */  0xC3, 0x80, 0x45, 0xC3, 0xA0, 0xCE, 0x6B, 0xD8,  // ..E...k.
                /* 0EF0 */  0xFF, 0xFF, 0x79, 0x0D, 0xB6, 0x38, 0x70, 0x1D,  // ..y..8p.
                /* 0EF8 */  0x54, 0x7D, 0x36, 0x86, 0x33, 0xA8, 0xD3, 0xEE,  // T}6.3...
                /* 0F00 */  0xFD, 0xAE, 0x40, 0x2E, 0x22, 0x1E, 0xF4, 0xF9,  // ..@."...
                /* 0F08 */  0x3C, 0x3B, 0xB0, 0x03, 0x1B, 0xF0, 0x1F, 0x1B,  // <;......
                /* 0F10 */  0x9C, 0x1B, 0xC0, 0x53, 0x74, 0x84, 0x63, 0x03,  // ...St.c.
                /* 0F18 */  0xFB, 0x89, 0x0D, 0x38, 0x9D, 0xED, 0xE0, 0x5C,  // ...8...\
                /* 0F20 */  0xA1, 0xD8, 0x6D, 0x1F, 0x37, 0x34, 0xB0, 0xD9,  // ..m.74..
                /* 0F28 */  0x18, 0x1A, 0xC8, 0xFE, 0xFF, 0x87, 0x4F, 0xE0,  // ......O.
                /* 0F30 */  0x75, 0xE8, 0xE2, 0x97, 0x8A, 0xE7, 0x2F, 0x7E,  // u...../~
                /* 0F38 */  0xB8, 0x03, 0x9C, 0x4B, 0x3B, 0xD9, 0xA1, 0xC4,  // ...K;...
                /* 0F40 */  0x1C, 0xEE, 0x00, 0x29, 0xFF, 0xFF, 0xC3, 0x1D,  // ...)....
                /* 0F48 */  0xB8, 0xEE, 0x72, 0xEF, 0x0C, 0x2F, 0x0D, 0x9E,  // ..r../..
                /* 0F50 */  0xD3, 0xBB, 0x9D, 0x31, 0x5E, 0xEA, 0x8C, 0x10,  // ...1^...
                /* 0F58 */  0x85, 0xDD, 0x06, 0xA2, 0xD9, 0xDB, 0xE1, 0x8E,  // ........
                /* 0F60 */  0x9C, 0xF0, 0x38, 0x66, 0xA4, 0x27, 0xBD, 0x60,  // ..8f.'.`
                /* 0F68 */  0x91, 0x22, 0x1E, 0x4E, 0x94, 0x10, 0xC1, 0x5E,  // .".N...^
                /* 0F70 */  0x27, 0x9E, 0xF2, 0x1E, 0xEE, 0x98, 0x90, 0xC3,  // '.......
                /* 0F78 */  0x1D, 0xD0, 0x71, 0x7D, 0xB8, 0x03, 0x2A, 0x27,  // ..q}..*'
                /* 0F80 */  0x2A, 0xFC, 0xE1, 0x0E, 0x30, 0xFB, 0xFF, 0x3F,  // *...0..?
                /* 0F88 */  0xDC, 0x01, 0x8C, 0x3A, 0xA3, 0xE1, 0x0E, 0x77,  // ...:...w
                /* 0F90 */  0x60, 0x3B, 0xFD, 0x00, 0xE7, 0xFF, 0xFF, 0xE9,  // `;......
                /* 0F98 */  0x07, 0x78, 0x8F, 0x15, 0xC6, 0x18, 0x78, 0xB4,  // .x....x.
                /* 0FA0 */  0x25, 0x51, 0x20, 0x87, 0x81, 0x41, 0x11, 0x38,  // %Q ..A.8
                /* 0FA8 */  0xC8, 0xA1, 0x8E, 0x06, 0x3B, 0xBD, 0x40, 0x99,  // ....;.@.
                /* 0FB0 */  0xCB, 0x81, 0x9E, 0xC2, 0x33, 0x82, 0x0F, 0x60,  // ....3..`
                /* 0FB8 */  0x60, 0x3F, 0xD5, 0x01, 0x87, 0x53, 0x03, 0x3E,  // `?...S.>
                /* 0FC0 */  0xD0, 0x09, 0x05, 0x3D, 0x0A, 0x9F, 0x4D, 0xC0,  // ...=..M.
                /* 0FC8 */  0x7B, 0xA4, 0x03, 0x36, 0xFF, 0xFF, 0xB3, 0x09,  // {..6....
                /* 0FD0 */  0x7B, 0x35, 0xFA, 0x6C, 0x82, 0x63, 0x31, 0xEA,  // {5.l.c1.
                /* 0FD8 */  0x1B, 0xC4, 0x21, 0xBE, 0x74, 0xF8, 0xDC, 0xF8,  // ..!.t...
                /* 0FE0 */  0x4E, 0xE3, 0x4B, 0x00, 0xE6, 0xFA, 0x61, 0x82,  // N.K...a.
                /* 0FE8 */  0x31, 0x21, 0xF4, 0xC9, 0xF2, 0xA9, 0x0E, 0x38,  // 1!.....8
                /* 0FF0 */  0x1D, 0x4E, 0xE0, 0x8D, 0x1E, 0x77, 0x5A, 0xF0,  // .N...wZ.
                /* 0FF8 */  0x70, 0x38, 0xB8, 0x67, 0xF3, 0x2C, 0xF1, 0x44,  // p8.g.,.D
                /* 1000 */  0xE4, 0x71, 0xF8, 0x74, 0x02, 0xBC, 0x0E, 0x18,  // .q.t....
                /* 1008 */  0x98, 0x19, 0x84, 0x7F, 0x08, 0x61, 0xA7, 0x4F,  // .....a.O
                /* 1010 */  0x1F, 0x99, 0x3C, 0xF7, 0x77, 0x23, 0x9F, 0x4E,  // ..<.w#.N
                /* 1018 */  0x00, 0x5F, 0xFF, 0xFF, 0xA3, 0x1E, 0xB0, 0x90,  // ._......
                /* 1020 */  0xA8, 0xE1, 0x9C, 0x87, 0x11, 0x05, 0x83, 0x3A,  // .......:
                /* 1028 */  0xEA, 0x01, 0xD6, 0x2E, 0x7A, 0x36, 0x86, 0xA0,  // ....z6..
                /* 1030 */  0x8B, 0xC0, 0x19, 0x84, 0x78, 0xBC, 0x7B, 0xC5,  // ....x.{.
                /* 1038 */  0x8B, 0xE4, 0x3B, 0x40, 0x9C, 0x47, 0x3D, 0x83,  // ..;@.G=.
                /* 1040 */  0xBD, 0x7D, 0x3C, 0x48, 0x44, 0x89, 0xF3, 0xA8,  // .}<HD...
                /* 1048 */  0xE7, 0xD1, 0x87, 0xF2, 0xE4, 0x43, 0x9D, 0x7E,  // .....C.~
                /* 1050 */  0xAC, 0xB0, 0x81, 0x9E, 0xF8, 0x5E, 0xF4, 0x42,  // .....^.B
                /* 1058 */  0x1A, 0xE1, 0x51, 0x8F, 0x09, 0x7A, 0x79, 0xE8,  // ..Q..zy.
                /* 1060 */  0x70, 0xE5, 0xA3, 0x1E, 0x60, 0xE5, 0xFF, 0x7F,  // p...`...
                /* 1068 */  0xD4, 0x03, 0xF8, 0xFF, 0xFF, 0x3F, 0xEA, 0x81,  // .....?..
                /* 1070 */  0xF9, 0xF4, 0x04, 0xF8, 0x3F, 0xD6, 0xE0, 0x8E,  // ....?...
                /* 1078 */  0x8A, 0x60, 0x3B, 0x3F, 0x01, 0x2E, 0xFE, 0xFF,  // .`;?....
                /* 1080 */  0xE7, 0x27, 0x30, 0x0D, 0xDD, 0xE7, 0x27, 0x30,  // .'0...'0
                /* 1088 */  0x8F, 0x16, 0xE6, 0x01, 0x01, 0x71, 0x56, 0x44,  // .....qVD
                /* 1090 */  0x85, 0x7F, 0xC8, 0x18, 0x0E, 0x15, 0x1C, 0x48,  // .......H
                /* 1098 */  0xBF, 0x28, 0x1F, 0x01, 0x81, 0xCB, 0x51, 0x11,  // .(....Q.
                /* 10A0 */  0x38, 0x9C, 0x59, 0xF0, 0x42, 0x4E, 0x1D, 0xE8,  // 8.Y.BN..
                /* 10A8 */  0xF1, 0x18, 0xF4, 0x95, 0xC3, 0x57, 0x02, 0x7E,  // .....W.~
                /* 10B0 */  0xE4, 0x60, 0xA1, 0x8F, 0x1C, 0xA0, 0x3A, 0x2C,  // .`....:,
                /* 10B8 */  0x82, 0xEF, 0xC8, 0x01, 0x8E, 0xEB, 0x55, 0x60,  // ......U`
                /* 10C0 */  0xFE, 0xFF, 0x07, 0x66, 0xB7, 0x83, 0xD7, 0x4F,  // ...f...O
                /* 10C8 */  0x4F, 0xE2, 0x31, 0xEA, 0x38, 0x43, 0x14, 0x8E,  // O.1.8C..
                /* 10D0 */  0x49, 0x0E, 0x06, 0x91, 0xDE, 0xC1, 0xD8, 0x00,  // I.......
                /* 10D8 */  0x5F, 0x5E, 0x7C, 0xA8, 0xF2, 0x31, 0x10, 0x18,  // _^|..1..
                /* 10E0 */  0x42, 0x9C, 0x0D, 0x3F, 0x5D, 0x18, 0xF3, 0x74,  // B..?]..t
                /* 10E8 */  0xF8, 0x31, 0x10, 0xB0, 0x2E, 0xF5, 0x0C, 0x88,  // .1......
                /* 10F0 */  0x12, 0x77, 0x0C, 0x04, 0x52, 0xFF, 0xFF, 0x63,  // .w..R..c
                /* 10F8 */  0x20, 0x70, 0xBD, 0x04, 0x7A, 0xCC, 0x67, 0xFC,  //  p..z.g.
                /* 1100 */  0xE6, 0xF7, 0xE4, 0x17, 0xA5, 0xB6, 0xEB, 0x9F,  // ........
                /* 1108 */  0xEE, 0x06, 0xC6, 0x7A, 0x08, 0x78, 0x02, 0xF4,  // ...z.x..
                /* 1110 */  0xFD, 0xCF, 0xC7, 0x8A, 0x28, 0x01, 0xA3, 0xC4,  // ....(...
                /* 1118 */  0x7A, 0x11, 0x34, 0x66, 0x8C, 0x60, 0xEF, 0x80,  // z.4f.`..
                /* 1120 */  0x31, 0x1F, 0x09, 0x3D, 0xC2, 0x68, 0xC1, 0x0D,  // 1..=.h..
                /* 1128 */  0xF4, 0x18, 0xC8, 0x84, 0x1D, 0x03, 0x01, 0x12,  // ........
                /* 1130 */  0xFD, 0xFF, 0x8F, 0x81, 0x00, 0x23, 0x4F, 0x50,  // .....#OP
                /* 1138 */  0xC0, 0xF6, 0xFF, 0x7F, 0x82, 0x02, 0x0C, 0x1D,  // ........
                /* 1140 */  0x05, 0xC1, 0x7C, 0x86, 0x02, 0xAC, 0x1D, 0x05,  // ..|.....
                /* 1148 */  0xC1, 0x3E, 0x5A, 0x98, 0xA3, 0xE0, 0x31, 0x5F,  // .>Z...1_
                /* 1150 */  0x1E, 0x06, 0xA2, 0xC1, 0x24, 0xFC, 0xFF, 0x8F,  // ....$...
                /* 1158 */  0x82, 0xD8, 0x50, 0x40, 0x3A, 0x77, 0x38, 0xD4,  // ..P@:w8.
                /* 1160 */  0xE9, 0x05, 0x7D, 0x50, 0xF0, 0xB0, 0x9F, 0x0A,  // ..}P....
                /* 1168 */  0x3C, 0x89, 0x53, 0xF5, 0xB5, 0xE0, 0x28, 0x9E,  // <.S...(.
                /* 1170 */  0x00, 0x7C, 0x18, 0x04, 0xFE, 0x43, 0x83, 0x35,  // .|...C.5
                /* 1178 */  0x89, 0xE2, 0x87, 0x06, 0xEA, 0xB3, 0x07, 0xF8,  // ........
                /* 1180 */  0x86, 0x06, 0x8E, 0xA8, 0x67, 0x1C, 0xF4, 0x89,  // ....g...
                /* 1188 */  0xC8, 0x67, 0x83, 0x98, 0x6F, 0x1E, 0x11, 0x9E,  // .g..o...
                /* 1190 */  0x3C, 0x7C, 0x7D, 0x60, 0x27, 0x4F, 0x9F, 0x9A,  // <|}`'O..
                /* 1198 */  0x02, 0x45, 0x79, 0xDF, 0xE0, 0x71, 0x4E, 0x39,  // .Ey..qN9
                /* 11A0 */  0xA0, 0x3A, 0xFC, 0x82, 0xE3, 0xC0, 0x0B, 0xE3,  // .:......
                /* 11A8 */  0xFF, 0x7F, 0xE0, 0x65, 0xC7, 0x29, 0x1F, 0x4B,  // ...e.).K
                /* 11B0 */  0xC0, 0x77, 0x26, 0x85, 0x73, 0x73, 0xF1, 0x1D,  // .w&.ss..
                /* 11B8 */  0x8F, 0x9D, 0x06, 0xC0, 0xA6, 0xE3, 0x34, 0x00,  // ......4.
                /* 11C0 */  0x94, 0x62, 0x0D, 0x0C, 0x7D, 0x54, 0x31, 0x6A,  // .b..}T1j
                /* 11C8 */  0xEF, 0x93, 0xD0, 0xC4, 0xD8, 0x75, 0xE4, 0x25,  // .....u.%
                /* 11D0 */  0xC5, 0xD7, 0x93, 0x67, 0x2D, 0xF0, 0xF9, 0x18,  // ...g-...
                /* 11D8 */  0x1B, 0x50, 0x3A, 0x81, 0xF1, 0xA3, 0x27, 0x98,  // .P:...'.
                /* 11E0 */  0x60, 0x0E, 0xE6, 0x55, 0xDC, 0x83, 0x7C, 0x12,  // `..U..|.
                /* 11E8 */  0x62, 0xA7, 0x1C, 0xF0, 0xFE, 0xFF, 0x0F, 0x9E,  // b.......
                /* 11F0 */  0x80, 0x3D, 0x11, 0xA7, 0x4E, 0x54, 0xEC, 0x37,  // .=..NT.7
                /* 11F8 */  0x97, 0x0F, 0x9E, 0x80, 0xBC, 0x3B, 0x83, 0x11,  // .....;..
                /* 1200 */  0xCE, 0x3F, 0xC4, 0x03, 0x44, 0x88, 0x67, 0x4E,  // .?..D.gN
                /* 1208 */  0x83, 0xC4, 0x09, 0xF2, 0x32, 0xF0, 0xE0, 0xE9,  // ....2...
                /* 1210 */  0x7B, 0x67, 0x9C, 0x67, 0xCF, 0x28, 0x6F, 0x9E,  // {g.g.(o.
                /* 1218 */  0x46, 0x38, 0xFA, 0x78, 0x06, 0x7A, 0xE7, 0x0C,  // F8.x.z..
                /* 1220 */  0xF1, 0xD6, 0xF9, 0x0C, 0xFA, 0xEA, 0x69, 0xB4,  // ......i.
                /* 1228 */  0x58, 0xC1, 0x8F, 0xF1, 0xC1, 0x93, 0x45, 0x3E,  // X.....E>
                /* 1230 */  0x23, 0xD1, 0x83, 0x27, 0xEC, 0xFF, 0xFF, 0xC1,  // #..'....
                /* 1238 */  0x13, 0xE0, 0xFF, 0xFF, 0xFF, 0xE0, 0x09, 0x18,  // ........
                /* 1240 */  0x3B, 0x83, 0x01, 0xC7, 0x13, 0x1B, 0x38, 0xCE,  // ;.....8.
                /* 1248 */  0x60, 0xC0, 0xE5, 0xE8, 0x0F, 0x9E, 0x93, 0x26,  // `......&
                /* 1250 */  0x8C, 0x23, 0x13, 0xF8, 0xFF, 0xFF, 0x47, 0x26,  // .#....G&
                /* 1258 */  0xC0, 0xD5, 0x58, 0x61, 0x8C, 0x81, 0x27, 0x7B,  // ..Xa..'{
                /* 1260 */  0x1A, 0xD0, 0xE3, 0x80, 0x45, 0x1D, 0x98, 0x04,  // ....E...
                /* 1268 */  0xC3, 0x59, 0x7C, 0x58, 0xF0, 0x11, 0x81, 0x1F,  // .Y|X....
                /* 1270 */  0x16, 0x3C, 0x82, 0x8A, 0xC7, 0x49, 0x8F, 0x45,  // .<...I.E
                /* 1278 */  0x3E, 0x77, 0xB2, 0x43, 0x82, 0x0F, 0x21, 0x1E,  // >w.C..!.
                /* 1280 */  0xA4, 0x0F, 0xB3, 0xE0, 0x39, 0x58, 0xC1, 0xBB,  // ....9X..
                /* 1288 */  0x2E, 0xC1, 0x39, 0x15, 0x00, 0x66, 0xFE, 0xFF,  // ..9..f..
                /* 1290 */  0x04, 0xB5, 0xAB, 0x38, 0x5D, 0xB0, 0x00, 0x07,  // ...8]...
                /* 1298 */  0x30, 0xD9, 0x38, 0x86, 0x50, 0x0E, 0x1F, 0x5D,  // 0.8.P..]
                /* 12A0 */  0x3D, 0x4D, 0x76, 0x24, 0x83, 0x19, 0x0B, 0x52,  // =Mv$...R
                /* 12A8 */  0x27, 0x01, 0x0F, 0xC0, 0x81, 0x60, 0xA4, 0x9D,  // '....`..
                /* 12B0 */  0x44, 0xA3, 0x31, 0x9C, 0xD5, 0xC2, 0x08, 0xCE,  // D.1.....
                /* 12B8 */  0x20, 0x3E, 0x8E, 0x38, 0xD7, 0x91, 0x0A, 0xBD,  //  >.8....
                /* 12C0 */  0x1B, 0x1D, 0xA7, 0x50, 0x41, 0xEE, 0x25, 0x74,  // ...PA.%t
                /* 12C8 */  0xDE, 0xBE, 0x1B, 0xF0, 0x77, 0x9A, 0xC7, 0x62,  // ....w..b
                /* 12D0 */  0x60, 0xDF, 0x4E, 0xC0, 0x31, 0x17, 0xAB, 0x01,  // `.N.1...
                /* 12D8 */  0x45, 0x0D, 0xC0, 0x68, 0x98, 0x53, 0xC0, 0x53,  // E..h.S.S
                /* 12E0 */  0x09, 0xB8, 0x82, 0xCD, 0x0D, 0x7D, 0x61, 0xB1,  // .....}a.
                /* 12E8 */  0xD6, 0xA9, 0xE8, 0xF8, 0xF4, 0x3E, 0x70, 0x70,  // .....>pp
                /* 12F0 */  0xC0, 0x63, 0xF6, 0x1E, 0x1C, 0x2C, 0x34, 0x0F,  // .c...,4.
                /* 12F8 */  0x0E, 0x6C, 0xD9, 0x06, 0x87, 0x56, 0x72, 0x17,  // .l...Vr.
                /* 1300 */  0x21, 0x87, 0x0F, 0xFC, 0xEC, 0x60, 0xFC, 0xFF,  // !....`..
                /* 1308 */  0x67, 0x07, 0x46, 0x40, 0xCF, 0x0E, 0x16, 0x92,  // g.F@....
                /* 1310 */  0x67, 0x07, 0x36, 0x7D, 0x67, 0x11, 0x50, 0x00,  // g.6}g.P.
                /* 1318 */  0xF9, 0xDE, 0xE1, 0x73, 0xCB, 0xB3, 0x07, 0x1B,  // ...s....
                /* 1320 */  0xC3, 0xA3, 0x8B, 0xD1, 0x8C, 0xCE, 0x35, 0xDD,  // ......5.
                /* 1328 */  0x26, 0x50, 0x2A, 0x6E, 0x13, 0x14, 0xC4, 0x37,  // &P*n...7
                /* 1330 */  0x00, 0x27, 0xA4, 0xD1, 0x3D, 0x0D, 0x37, 0x13,  // .'..=.7.
                /* 1338 */  0xE3, 0x3F, 0x62, 0xF8, 0x88, 0x70, 0x48, 0x67,  // .?b..pHg
                /* 1340 */  0x6B, 0x82, 0x79, 0x20, 0xF5, 0x7E, 0xF4, 0x65,  // k.y .~.e
                /* 1348 */  0x0F, 0x3F, 0xFB, 0x90, 0x0F, 0x2E, 0x9E, 0x86,  // .?......
                /* 1350 */  0xAF, 0x37, 0xE4, 0xDE, 0x41, 0xA7, 0xED, 0x33,  // .7..A..3
                /* 1358 */  0x03, 0xE6, 0x30, 0xED, 0xEB, 0x54, 0x02, 0xCB,  // ..0..T..
                /* 1360 */  0xBA, 0x4A, 0x50, 0x0F, 0x17, 0x10, 0x7A, 0xA1,  // .JP...z.
                /* 1368 */  0xF1, 0xBD, 0x30, 0xC1, 0xC3, 0x99, 0x6F, 0x67,  // ..0...og
                /* 1370 */  0xEF, 0x25, 0xEC, 0x70, 0x98, 0xE0, 0xDD, 0x30,  // .%.p...0
                /* 1378 */  0xC1, 0xBC, 0x83, 0x40, 0x8D, 0xCA, 0x83, 0xC0,  // ...@....
                /* 1380 */  0x1C, 0xBF, 0x4C, 0x30, 0xDF, 0x18, 0x50, 0xC9,  // ..L0..P.
                /* 1388 */  0x2E, 0x5A, 0xF4, 0x0C, 0xF3, 0x0E, 0xE3, 0x4B,  // .Z.....K
                /* 1390 */  0x82, 0xAF, 0x1F, 0x3E, 0xB7, 0x78, 0x01, 0xAF,  // ...>.x..
                /* 1398 */  0x5B, 0x30, 0x08, 0x9E, 0x81, 0x5E, 0x5D, 0x0C,  // [0...^].
                /* 13A0 */  0x15, 0x27, 0xF0, 0xAB, 0xC0, 0x1B, 0x4D, 0x88,  // .'....M.
                /* 13A8 */  0x60, 0x86, 0x3D, 0xFC, 0x90, 0x6F, 0x31, 0x3E,  // `.=..o1>
                /* 13B0 */  0x5F, 0xFA, 0x06, 0x10, 0xEB, 0x75, 0xC4, 0xFF,  // _....u..
                /* 13B8 */  0xFF, 0x91, 0xF2, 0x63, 0xCB, 0x01, 0x45, 0x7A,  // ...c..Ez
                /* 13C0 */  0xEB, 0xF3, 0x04, 0x7C, 0x96, 0xF1, 0x71, 0xF0,  // ...|..q.
                /* 13C8 */  0xA4, 0x7C, 0xAF, 0x34, 0xFA, 0x2B, 0x84, 0x0F,  // .|.4.+..
                /* 13D0 */  0x3F, 0x46, 0xF6, 0x39, 0x87, 0x1D, 0x0C, 0xD9,  // ?F.9....
                /* 13D8 */  0xA0, 0x38, 0xE2, 0x03, 0xC3, 0x4B, 0x8D, 0xA7,  // .8...K..
                /* 13E0 */  0xC2, 0xCE, 0x5D, 0x30, 0x0E, 0x0E, 0xEC, 0x58,  // ..]0...X
                /* 13E8 */  0x84, 0x39, 0xEA, 0x81, 0xEB, 0x64, 0xE3, 0x93,  // .9...d..
                /* 13F0 */  0x03, 0x98, 0xE1, 0x31, 0x87, 0x6B, 0x9F, 0x37,  // ...1.k.7
                /* 13F8 */  0x7C, 0x33, 0xF0, 0xB8, 0xF8, 0x91, 0xC3, 0xC7,  // |3......
                /* 1400 */  0x3B, 0x86, 0x7D, 0x9A, 0x3E, 0x1A, 0xBD, 0xBC,  // ;.}.>...
                /* 1408 */  0xF9, 0xF4, 0x82, 0x81, 0xF5, 0xA5, 0x81, 0xC3,  // ........
                /* 1410 */  0x1A, 0x2D, 0xEC, 0x63, 0xC0, 0x99, 0xFB, 0x42,  // .-.c...B
                /* 1418 */  0x84, 0x3B, 0x75, 0x82, 0x05, 0x10, 0x7F, 0x2B,  // .;u....+
                /* 1420 */  0x79, 0xE4, 0xF0, 0x04, 0x0C, 0xC8, 0x72, 0xAF,  // y.....r.
                /* 1428 */  0x4B, 0x07, 0x22, 0x7E, 0xCA, 0xB3, 0xBA, 0x03,  // K."~....
                /* 1430 */  0x11, 0x02, 0xE3, 0x71, 0xF4, 0xF1, 0xC3, 0xB3,  // ...q....
                /* 1438 */  0xF1, 0x51, 0xC0, 0xC7, 0x28, 0xCF, 0xFC, 0x8C,  // .Q..(...
                /* 1440 */  0x22, 0xBD, 0x32, 0x58, 0xCB, 0x89, 0x08, 0xA5,  // ".2X....
                /* 1448 */  0x02, 0x46, 0x81, 0x69, 0x74, 0xE7, 0xE0, 0x11,  // .F.it...
                /* 1450 */  0x61, 0x04, 0x67, 0x10, 0x8F, 0xD6, 0x37, 0x17,  // a.g...7.
                /* 1458 */  0x18, 0xFF, 0xFF, 0x9B, 0x0B, 0xF0, 0x3A, 0x13,  // ......:.
                /* 1460 */  0x01, 0x97, 0xEB, 0xA5, 0x67, 0x87, 0xBB, 0x2C,  // ....g..,
                /* 1468 */  0xB2, 0x69, 0x1B, 0xF7, 0x15, 0xD5, 0xA7, 0x63,  // .i.....c
                /* 1470 */  0x4F, 0xFC, 0xB4, 0x61, 0x9C, 0x8C, 0x00, 0x1F,  // O..a....
                /* 1478 */  0x77, 0x1D, 0xC0, 0xC9, 0xFF, 0xFF, 0xAE, 0x03,  // w.......
                /* 1480 */  0xF0, 0xFF, 0xFF, 0x7F, 0xD7, 0xE1, 0xF7, 0x07,  // ........
                /* 1488 */  0xDF, 0x75, 0x80, 0x6B, 0xA4, 0x55, 0x51, 0x11,  // .u.k.UQ.
                /* 1490 */  0xBF, 0x05, 0x85, 0x80, 0x41, 0x8D, 0xCE, 0xD7,  // ....A...
                /* 1498 */  0x0A, 0xFC, 0xB1, 0x84, 0x81, 0xB3, 0xF3, 0x8A,  // ........
                /* 14A0 */  0xE1, 0xF8, 0xC0, 0x3D, 0xBE, 0xD7, 0x95, 0xD3,  // ...=....
                /* 14A8 */  0x7A, 0x36, 0xF0, 0x8D, 0xC5, 0x90, 0xEC, 0x82,  // z6......
                /* 14B0 */  0x8A, 0xBB, 0x5F, 0xF8, 0x46, 0xED, 0xA9, 0xBE,  // .._.F...
                /* 14B8 */  0x28, 0xBC, 0x27, 0xF8, 0x8E, 0xC0, 0xA0, 0x60,  // (.'....`
                /* 14C0 */  0xDC, 0x51, 0x31, 0x07, 0x54, 0x38, 0x04, 0x67,  // .Q1.T8.g
                /* 14C8 */  0x7C, 0x14, 0x98, 0x41, 0xFA, 0x90, 0xF2, 0x7A,  // |..A...z
                /* 14D0 */  0xE0, 0xC1, 0x32, 0xF7, 0xC7, 0x0D, 0x5D, 0x22,  // ..2...]"
                /* 14D8 */  0x1E, 0x36, 0x9E, 0x0C, 0x9A, 0x43, 0xD1, 0x99,  // .6...C..
                /* 14E0 */  0xE0, 0x14, 0xDA, 0x1A, 0x96, 0x70, 0xDE, 0x37,  // .....p.7
                /* 14E8 */  0x42, 0x44, 0x09, 0xF6, 0xC2, 0xF1, 0xC6, 0xF0,  // BD......
                /* 14F0 */  0x34, 0x1B, 0x25, 0x5E, 0xA4, 0x80, 0xD1, 0xA2,  // 4.%^....
                /* 14F8 */  0x04, 0xEB, 0x0D, 0x42, 0xA0, 0x91, 0x42, 0x04,  // ...B..B.
                /* 1500 */  0x0C, 0x51, 0x1C, 0x96, 0xE0, 0xA2, 0xB7, 0x7F,  // .Q......
                /* 1508 */  0x8D, 0x67, 0x6F, 0x02, 0x1D, 0x65, 0x1C, 0xE9,  // .go..e..
                /* 1510 */  0xB8, 0x83, 0x1E, 0xB6, 0x6F, 0xAC, 0xFC, 0x7C,  // ....o..|
                /* 1518 */  0xEF, 0x71, 0xF9, 0x02, 0x8A, 0x21, 0x78, 0xCD,  // .q...!x.
                /* 1520 */  0xF0, 0x17, 0xC0, 0x07, 0x00, 0xBC, 0x6B, 0x40,  // ......k@
                /* 1528 */  0xCD, 0xFC, 0xB1, 0x00, 0xD6, 0xFF, 0xFF, 0x46,  // .......F
                /* 1530 */  0x0F, 0xBE, 0xEB, 0x35, 0x5E, 0xFE, 0x20, 0x50,  // ...5^. P
                /* 1538 */  0x97, 0x19, 0x7E, 0xF6, 0xF0, 0xCD, 0xD5, 0xF7,  // ..~.....
                /* 1540 */  0x80, 0xC3, 0x62, 0xB7, 0x6E, 0x3E, 0x1E, 0xF0,  // ..b.n>..
                /* 1548 */  0x0F, 0xFD, 0xA5, 0xD7, 0x87, 0x0A, 0xCF, 0xD7,  // ........
                /* 1550 */  0x57, 0x5F, 0xDF, 0xBE, 0xC1, 0x7B, 0x39, 0x06,  // W_...{9.
                /* 1558 */  0xEC, 0x09, 0xBE, 0x81, 0x83, 0x7C, 0xBC, 0xD8,  // .....|..
                /* 1560 */  0xFF, 0xFF, 0x78, 0xE1, 0x8C, 0x83, 0x2B, 0x27,  // ..x...+'
                /* 1568 */  0xA1, 0xC7, 0x02, 0x6B, 0x85, 0x41, 0xDD, 0xC2,  // ...k.A..
                /* 1570 */  0xC1, 0xA5, 0x09, 0x5C, 0x57, 0x65, 0x1F, 0x6A,  // ...\We.j
                /* 1578 */  0x7C, 0x08, 0xC6, 0x9F, 0x2F, 0x70, 0x01, 0x86,  // |.../p..
                /* 1580 */  0x4C, 0x4F, 0x65, 0x30, 0xAE, 0x29, 0x3E, 0x95,  // LOe0.)>.
                /* 1588 */  0x61, 0xEE, 0x0E, 0x1E, 0x90, 0x8F, 0x18, 0xC0,  // a.......
                /* 1590 */  0x67, 0x15, 0x1E, 0x18, 0xEE, 0xB4, 0xE0, 0x9B,  // g.......
                /* 1598 */  0x92, 0x41, 0xCF, 0x31, 0xA8, 0x8F, 0x3C, 0x27,  // .A.1..<'
                /* 15A0 */  0xEF, 0x7B, 0xC2, 0xE3, 0x84, 0xA3, 0x9E, 0x83,  // .{......
                /* 15A8 */  0xE8, 0xD8, 0xC0, 0x71, 0xDC, 0x00, 0xC7, 0xE1,  // ...q....
                /* 15B0 */  0x06, 0x77, 0xCE, 0x63, 0xE3, 0xC2, 0xC0, 0x3D,  // .w.c...=
                /* 15B8 */  0x17, 0x78, 0x18, 0xBE, 0xE9, 0x78, 0x44, 0x98,  // .x...xD.
                /* 15C0 */  0xF1, 0x3F, 0xEA, 0x19, 0x21, 0x20, 0xFE, 0x62,  // .?..! .b
                /* 15C8 */  0xC4, 0x06, 0x0C, 0xA6, 0xFF, 0xFF, 0x80, 0xF9,  // ........
                /* 15D0 */  0xAD, 0xCD, 0xD7, 0x37, 0xDC, 0x80, 0x7D, 0x75,  // ...7..}u
                /* 15D8 */  0xF0, 0x05, 0xC3, 0x27, 0x30, 0xA3, 0xBF, 0xC0,  // ...'0...
                /* 15E0 */  0x3C, 0x89, 0xF9, 0xD8, 0x40, 0x2E, 0x70, 0x74,  // <...@.pt
                /* 15E8 */  0xC0, 0xE0, 0x00, 0xF4, 0x80, 0xE1, 0x1F, 0x2E,  // ........
                /* 15F0 */  0xDE, 0xE5, 0xC0, 0x70, 0x15, 0xF4, 0x71, 0xC1,  // ...p..q.
                /* 15F8 */  0xC7, 0x1E, 0x2B, 0xBA, 0xCB, 0xA1, 0x6F, 0x72,  // ..+...or
                /* 1600 */  0x86, 0x89, 0x63, 0x88, 0x37, 0x30, 0x76, 0x97,  // ..c.70v.
                /* 1608 */  0x20, 0x87, 0x39, 0xA8, 0x77, 0x09, 0xCF, 0x81,  //  .9.w...
                /* 1610 */  0x9F, 0x2D, 0x7C, 0x82, 0xF3, 0xCD, 0x27, 0xC4,  // .-|...'.
                /* 1618 */  0xA9, 0x3E, 0x5A, 0xBD, 0x07, 0xF8, 0xE8, 0xF1,  // .>Z.....
                /* 1620 */  0xDE, 0xE5, 0xB3, 0x13, 0xBB, 0x08, 0xF8, 0xC8,  // ........
                /* 1628 */  0x65, 0x1C, 0x4F, 0xD3, 0x57, 0x40, 0x0F, 0xD9,  // e.O.W@..
                /* 1630 */  0x60, 0xAF, 0x1A, 0x3E, 0x81, 0xF9, 0xE8, 0x86,  // `..>....
                /* 1638 */  0x3B, 0x46, 0x79, 0x26, 0x9E, 0xBE, 0xEF, 0x20,  // ;Fy&... 
                /* 1640 */  0xEC, 0x48, 0x72, 0xD4, 0xA1, 0xAE, 0xE9, 0x11,  // .Hr.....
                /* 1648 */  0xE5, 0x84, 0x0E, 0xC4, 0xB7, 0x36, 0x70, 0x46,  // .....6pF
                /* 1650 */  0xBB, 0x7F, 0xA0, 0xB7, 0xE9, 0x91, 0x61, 0x8E,  // ......a.
                /* 1658 */  0x06, 0xB0, 0x2E, 0x21, 0x60, 0xF9, 0xFF, 0xDF,  // ...!`...
                /* 1660 */  0x0C, 0xD8, 0x1D, 0xC3, 0x97, 0x10, 0xE0, 0x13,  // ........
                /* 1668 */  0xF4, 0x12, 0x81, 0xBE, 0x66, 0x78, 0x74, 0x8F,  // ....fxt.
                /* 1670 */  0x00, 0x98, 0x2B, 0x06, 0x3B, 0x16, 0xF8, 0xB0,  // ..+.;...
                /* 1678 */  0xE1, 0x6B, 0x00, 0xBB, 0x17, 0x38, 0xCC, 0x3D,  // .k...8.=
                /* 1680 */  0x02, 0x54, 0xA0, 0x1E, 0x1E, 0x7C, 0xB5, 0xF7,  // .T...|..
                /* 1688 */  0x08, 0x50, 0x9C, 0x2C, 0x7D, 0x68, 0xF0, 0x40,  // .P.,}h.@
                /* 1690 */  0xAD, 0xEA, 0x8C, 0x09, 0xE5, 0x88, 0xC9, 0xA1,  // ........
                /* 1698 */  0xA2, 0xB1, 0x5B, 0x01, 0xBB, 0x5D, 0xFA, 0x26,  // ..[..].&
                /* 16A0 */  0x01, 0x37, 0xCF, 0x2C, 0x50, 0x49, 0x6E, 0x12,  // .7.,PIn.
                /* 16A8 */  0xD0, 0x61, 0xBA, 0xBC, 0xCC, 0xD0, 0xF9, 0x1F,  // .a......
                /* 16B0 */  0xB8, 0x6F, 0x75, 0x1E, 0xA1, 0x0F, 0x11, 0x0C,  // .ou.....
                /* 16B8 */  0xE5, 0x3D, 0xCF, 0xA7, 0x30, 0x7E, 0x86, 0xF0,  // .=..0~..
                /* 16C0 */  0x01, 0x93, 0x9D, 0x29, 0xF8, 0x59, 0x13, 0x77,  // ...).Y.w
                /* 16C8 */  0x07, 0x30, 0xCA, 0x9B, 0xA7, 0x27, 0xC0, 0xCE,  // .0...'..
                /* 16D0 */  0x9F, 0x46, 0x7E, 0x37, 0x78, 0x17, 0xF0, 0xF4,  // .F~7x...
                /* 16D8 */  0x7D, 0x2F, 0xE2, 0x87, 0x04, 0xF6, 0xFF, 0x3F,  // }/.....?
                /* 16E0 */  0x51, 0x80, 0x29, 0xD8, 0x9D, 0x0E, 0x0A, 0xF4,  // Q.).....
                /* 16E8 */  0x09, 0x79, 0x44, 0x46, 0xF5, 0x11, 0x81, 0x5F,  // .yDF..._
                /* 16F0 */  0x92, 0xC0, 0x78, 0x24, 0xF1, 0x81, 0x02, 0x08,  // ..x$....
                /* 16F8 */  0xDD, 0x0B, 0x50, 0xA7, 0x0F, 0x7E, 0x78, 0xF6,  // ..P..~x.
                /* 1700 */  0x05, 0xD5, 0x98, 0xEF, 0x56, 0x8F, 0x70, 0x9E,  // ....V.p.
                /* 1708 */  0x1C, 0xE6, 0x72, 0xC0, 0xE2, 0x5C, 0x93, 0x40,  // ..r..\.@
                /* 1710 */  0x75, 0xDC, 0xE5, 0xA3, 0x83, 0x7B, 0x6D, 0xC5,  // u....{m.
                /* 1718 */  0x0F, 0xEE, 0x9D, 0xE5, 0x9D, 0xCF, 0x50, 0x1E,  // ......P.
                /* 1720 */  0x24, 0xF8, 0xAE, 0xAD, 0xE0, 0xB8, 0xAA, 0xC1,  // $.......
                /* 1728 */  0x38, 0xB6, 0xF0, 0x4B, 0x1E, 0xBC, 0xFF, 0xFF,  // 8..K....
                /* 1730 */  0x25, 0x0F, 0xB0, 0x30, 0x2C, 0x2E, 0xF8, 0xEF,  // %..0,...
                /* 1738 */  0x61, 0x20, 0x2A, 0x11, 0x06, 0x45, 0x60, 0x79,  // a *..E`y
                /* 1740 */  0xF7, 0x56, 0x0A, 0x7F, 0xC8, 0x60, 0xBC, 0x29,  // .V...`.)
                /* 1748 */  0xF0, 0x49, 0x63, 0x47, 0x0D, 0xD8, 0x19, 0x2A,  // .IcG...*
                /* 1750 */  0xEE, 0xA6, 0x08, 0xD6, 0xA9, 0x62, 0x86, 0xC0,  // .....b..
                /* 1758 */  0x83, 0x3D, 0x00, 0x7C, 0xBE, 0xF2, 0x19, 0x40,  // .=.|...@
                /* 1760 */  0x51, 0x60, 0xC8, 0xFF, 0x1F, 0x86, 0x1D, 0xDA,  // Q`......
                /* 1768 */  0xE1, 0xDC, 0x86, 0x01, 0x07, 0x23, 0xC6, 0x5D,  // .....#.]
                /* 1770 */  0x0A, 0xE1, 0x4E, 0xF9, 0x1D, 0x25, 0xF6, 0x73,  // ..N..%.s
                /* 1778 */  0x39, 0x9B, 0x2E, 0xEE, 0x6A, 0xEE, 0xD3, 0x09,  // 9...j...
                /* 1780 */  0xBB, 0x20, 0xC3, 0x38, 0x0B, 0x3C, 0x02, 0xBC,  // . .8.<..
                /* 1788 */  0x9A, 0xF3, 0x0B, 0xF2, 0x0B, 0xF1, 0x0B, 0xC1,  // ........
                /* 1790 */  0x1B, 0xB2, 0x6F, 0x4A, 0xCF, 0x06, 0x2F, 0x3B,  // ..oJ../;
                /* 1798 */  0x31, 0xDE, 0x8D, 0x7D, 0x4A, 0xF6, 0x79, 0xE7,  // 1..}J.y.
                /* 17A0 */  0x05, 0xD9, 0x18, 0x47, 0x13, 0x31, 0xCA, 0xB9,  // ...G.1..
                /* 17A8 */  0x3D, 0x0C, 0xBC, 0x26, 0x1B, 0xE5, 0xFD, 0xE4,  // =..&....
                /* 17B0 */  0x85, 0x20, 0x62, 0x34, 0x43, 0x04, 0x8D, 0x11,  // . b4C...
                /* 17B8 */  0xE8, 0x7D, 0xD9, 0x78, 0x2F, 0xC8, 0x4C, 0xE0,  // .}.x/.L.
                /* 17C0 */  0x5B, 0x41, 0x07, 0x17, 0x5F, 0x90, 0x01, 0x43,  // [A.._..C
                /* 17C8 */  0xFF, 0xFF, 0x0B, 0x32, 0xB0, 0x3F, 0x19, 0x01,  // ...2.?..
                /* 17D0 */  0x3E, 0x4F, 0x1C, 0xB8, 0x4B, 0x35, 0xF8, 0x4E,  // >O..K5.N
                /* 17D8 */  0x36, 0xC0, 0xFA, 0xFF, 0x7F, 0xB2, 0x01, 0xFB,  // 6.......
                /* 17E0 */  0xD0, 0x7D, 0xB2, 0x01, 0xF7, 0x68, 0xE1, 0x1D,  // .}...h..
                /* 17E8 */  0x4D, 0x10, 0x27, 0x1B, 0x0A, 0xE4, 0xE0, 0xEB,  // M.'.....
                /* 17F0 */  0xA2, 0x70, 0x3C, 0xF4, 0x49, 0x84, 0x1E, 0x9D,  // .p<.I...
                /* 17F8 */  0x7C, 0x94, 0xC4, 0x9D, 0x19, 0x3C, 0x91, 0x77,  // |....<.w
                /* 1800 */  0x16, 0x8F, 0xE2, 0x65, 0xD0, 0xF7, 0x82, 0x13,  // ...e....
                /* 1808 */  0x79, 0x7D, 0xB0, 0x9C, 0x63, 0x24, 0xA8, 0x46,  // y}..c$.F
                /* 1810 */  0xE2, 0xE3, 0x03, 0xFC, 0xEB, 0x8B, 0x8F, 0x91,  // ........
                /* 1818 */  0xF0, 0xF9, 0xFC, 0xC3, 0xF2, 0x60, 0x0C, 0xE9,  // .....`..
                /* 1820 */  0x53, 0x24, 0x07, 0x79, 0x76, 0x79, 0x0C, 0xE1,  // S$.yvy..
                /* 1828 */  0x17, 0x48, 0xB8, 0xA7, 0x99, 0x03, 0xC0, 0xC8,  // .H......
                /* 1830 */  0xBA, 0x3C, 0xA2, 0xCF, 0x8E, 0x1C, 0x23, 0xAE,  // .<....#.
                /* 1838 */  0x2F, 0x8A, 0xBE, 0x02, 0xFB, 0x20, 0x70, 0x3E,  // /.... p>
                /* 1840 */  0xCF, 0x89, 0xE0, 0xFA, 0xFF, 0x9F, 0x13, 0x31,  // .......1
                /* 1848 */  0xA3, 0xE6, 0x47, 0x1B, 0x3E, 0x7E, 0x0E, 0xFE,  // ..G.>~..
                /* 1850 */  0x56, 0xF0, 0x40, 0xE9, 0x63, 0x51, 0x88, 0x47,  // V.@.cQ.G
                /* 1858 */  0x24, 0x7E, 0x4E, 0x04, 0x97, 0x89, 0x73, 0x22,  // $~N...s"
                /* 1860 */  0x90, 0x38, 0xF4, 0xC2, 0x38, 0x2D, 0xE0, 0x06,  // .8..8-..
                /* 1868 */  0xE2, 0x33, 0x25, 0x76, 0xCA, 0x27, 0xC2, 0xCE,  // .3%v.'..
                /* 1870 */  0x25, 0x98, 0xD1, 0x81, 0xEB, 0x72, 0xEF, 0xD1,  // %....r..
                /* 1878 */  0x81, 0xFF, 0x24, 0x80, 0xC7, 0x7A, 0xBC, 0x03,  // ..$..z..
                /* 1880 */  0xDF, 0x49, 0xDD, 0x77, 0x13, 0x5F, 0x64, 0x7C,  // .I.w._d|
                /* 1888 */  0x28, 0x7A, 0x6C, 0x01, 0x56, 0xFF, 0xFF, 0xF3,  // (zl.V...
                /* 1890 */  0x1D, 0x60, 0x2A, 0xDC, 0xE1, 0x0E, 0x15, 0xE7,  // .`*.....
                /* 1898 */  0x7C, 0x07, 0x50, 0xE3, 0x6C, 0xFD, 0x7C, 0x07,  // |.P.l.|.
                /* 18A0 */  0xAE, 0xFF, 0xFF, 0xF9, 0x0E, 0x86, 0xC8, 0xF3,  // ........
                /* 18A8 */  0x1D, 0x40, 0xF6, 0xFF, 0xFF, 0x19, 0x00, 0x73,  // .@.....s
                /* 18B0 */  0x46, 0xC3, 0x9D, 0xEF, 0xC0, 0x76, 0xB4, 0x01,  // F....v..
                /* 18B8 */  0xCC, 0x4D, 0xE3, 0xD1, 0x06, 0xDC, 0xC3, 0x85,  // .M......
                /* 18C0 */  0x3D, 0x0C, 0x9E, 0xE1, 0x0D, 0xE5, 0x43, 0x01,  // =.....C.
                /* 18C8 */  0x95, 0x74, 0xCA, 0xA6, 0x30, 0x66, 0xF1, 0x91,  // .t..0f..
                /* 18D0 */  0xC1, 0x07, 0x05, 0x7E, 0x64, 0xF0, 0x39, 0xE1,  // ...~d.9.
                /* 18D8 */  0xF1, 0xE1, 0x50, 0xD9, 0x11, 0xC6, 0x97, 0x10,  // ..P.....
                /* 18E0 */  0x1F, 0x15, 0x58, 0xF4, 0x71, 0xD2, 0x13, 0x14,  // ..X.q...
                /* 18E8 */  0x18, 0x87, 0xF8, 0xC8, 0xE7, 0x41, 0x3C, 0xD9,  // .....A<.
                /* 18F0 */  0xC0, 0x3A, 0x17, 0xFC, 0xFF, 0x9F, 0x0B, 0x00,  // .:......
                /* 18F8 */  0x33, 0x3A, 0x9F, 0x6F, 0x1A, 0xB9, 0x35, 0x82,  // 3:.o..5.
                /* 1900 */  0xC8, 0xC6, 0x51, 0x84, 0x72, 0x38, 0xC9, 0xE2,  // ..Q.r8..
                /* 1908 */  0x74, 0x11, 0xF4, 0x09, 0xC9, 0xD7, 0x8B, 0x53,  // t......S
                /* 1910 */  0x39, 0x55, 0xFC, 0x55, 0xC4, 0xCA, 0x21, 0x05,  // 9U.U..!.
                /* 1918 */  0xEF, 0xE3, 0x8A, 0x35, 0xC3, 0x28, 0xDE, 0x6B,  // ...5.(.k
                /* 1920 */  0x44, 0xA3, 0xF1, 0x08, 0x1C, 0x08, 0x46, 0x70,  // D.....Fp
                /* 1928 */  0x06, 0xF1, 0x49, 0xC4, 0xD9, 0x8E, 0x3A, 0x68,  // ..I...:h
                /* 1930 */  0x25, 0xE7, 0x3D, 0x32, 0x06, 0x76, 0xD0, 0xC1,  // %.=2.v..
                /* 1938 */  0x04, 0xB9, 0x9E, 0xD0, 0x99, 0xFB, 0x72, 0xC0,  // ......r.
                /* 1940 */  0x35, 0x40, 0xE8, 0x00, 0x62, 0x70, 0x5F, 0x52,  // 5@..bp_R
                /* 1948 */  0x60, 0x5C, 0xA8, 0x7C, 0x49, 0xC1, 0x9C, 0x8D,  // `\.|I...
                /* 1950 */  0x3C, 0x1B, 0xAB, 0x01, 0x45, 0x0D, 0xC0, 0x68,  // <...E..h
                /* 1958 */  0x98, 0x73, 0xC0, 0xC3, 0x09, 0xB8, 0x72, 0x5D,  // .s....r]
                /* 1960 */  0xF8, 0xD0, 0x2F, 0x09, 0xDF, 0x2D, 0x1E, 0x6C,  // ../..-.l
                /* 1968 */  0xD8, 0xDC, 0xC0, 0xF5, 0xFF, 0x9F, 0x1B, 0xCC,  // ........
                /* 1970 */  0xF1, 0x7B, 0x6E, 0xB0, 0xD0, 0x3C, 0x37, 0xF8,  // .{n..<7.
                /* 1978 */  0xF7, 0x3D, 0xEC, 0xE1, 0x10, 0x8F, 0xCC, 0xE6,  // .=......
                /* 1980 */  0xF6, 0x1C, 0x10, 0xE1, 0x15, 0xC1, 0x97, 0x1C,  // ........
                /* 1988 */  0x8F, 0x0E, 0x38, 0x00, 0x7A, 0x74, 0xB0, 0x90,  // ..8.zt..
                /* 1990 */  0x3C, 0x3A, 0xB0, 0x25, 0x1C, 0x1D, 0x5A, 0x0F,  // <:.%..Z.
                /* 1998 */  0x88, 0x5C, 0x9E, 0xB1, 0xC8, 0xC9, 0xE4, 0xF4,  // .\......
                /* 19A0 */  0x4E, 0xE6, 0x99, 0xE0, 0xEC, 0x9E, 0x2E, 0x82,  // N.......
                /* 19A8 */  0x04, 0x8A, 0x13, 0xFD, 0xD9, 0xC4, 0x13, 0x04,  // ........
                /* 19B0 */  0x0E, 0x03, 0xF0, 0x04, 0x61, 0xA1, 0x79, 0x82,  // ....a.y.
                /* 19B8 */  0x60, 0x8B, 0x78, 0xCD, 0x40, 0xDF, 0x3C, 0x61,  // `.x.@.<a
                /* 19C0 */  0x60, 0xFF, 0xFF, 0x5F, 0xE7, 0x98, 0xF7, 0xDB,  // `.._....
                /* 19C8 */  0x0D, 0xB9, 0x11, 0x00, 0x8F, 0x4B, 0xA1, 0x47,  // .....K.G
                /* 19D0 */  0x08, 0x0B, 0xCD, 0x47, 0x0D, 0xB0, 0xC5, 0x1B,  // ...G....
                /* 19D8 */  0x21, 0x7A, 0x58, 0xBE, 0x95, 0x9C, 0xDF, 0xC9,  // !zX.....
                /* 19E0 */  0x1D, 0x1F, 0xB0, 0x02, 0xF6, 0xF8, 0x60, 0xA1,  // ......`.
                /* 19E8 */  0x78, 0x7C, 0x60, 0xD3, 0x77, 0x37, 0x02, 0x05,  // x|`.w7..
                /* 19F0 */  0x90, 0x4F, 0x42, 0x3E, 0x9F, 0xBC, 0x0C, 0xB1,  // .OB>....
                /* 19F8 */  0x31, 0xBC, 0x4D, 0x19, 0xCD, 0xE8, 0x3C, 0xD3,  // 1.M...<.
                /* 1A00 */  0x96, 0x74, 0xBE, 0xE1, 0x29, 0x60, 0x74, 0x76,  // .t..)`tv
                /* 1A08 */  0x31, 0x88, 0x6F, 0x24, 0x56, 0x08, 0xA2, 0x63,  // 1.o$V..c
                /* 1A10 */  0x08, 0xFE, 0xBA, 0xEB, 0x19, 0xBD, 0x29, 0x78,  // ......)x
                /* 1A18 */  0xB6, 0x26, 0xA8, 0x07, 0x52, 0x27, 0x4F, 0x38,  // .&..R'O8
                /* 1A20 */  0xB7, 0x0B, 0xF6, 0xFF, 0x3F, 0x48, 0xB1, 0xBB,  // ....?H..
                /* 1A28 */  0xB5, 0xCF, 0xD8, 0xF0, 0x0F, 0x99, 0x1E, 0x8F,  // ........
                /* 1A30 */  0x6D, 0x1C, 0x8C, 0xE8, 0x09, 0xCB, 0x87, 0x6C,  // m......l
                /* 1A38 */  0x7E, 0x98, 0x78, 0x52, 0x62, 0xE7, 0xC9, 0x04,  // ~.xRb...
                /* 1A40 */  0x6F, 0x94, 0x09, 0x7A, 0x3B, 0x5F, 0xD3, 0x9B,  // o..z;_..
                /* 1A48 */  0xB6, 0x21, 0xA3, 0x32, 0x58, 0x43, 0x3C, 0xF3,  // .!.2XC<.
                /* 1A50 */  0x32, 0x7D, 0xEB, 0xD3, 0x71, 0x1B, 0xAE, 0x1E,  // 2}..q...
                /* 1A58 */  0x40, 0x8D, 0x85, 0x2B, 0x81, 0xD1, 0xA0, 0xC3,  // @..+....
                /* 1A60 */  0x3D, 0x5D, 0xBD, 0x5D, 0xF9, 0xB2, 0xE0, 0x0B,  // =].]....
                /* 1A68 */  0x83, 0x2F, 0x54, 0x3E, 0x7C, 0x1A, 0xEC, 0xBC,  // ./T>|...
                /* 1A70 */  0x22, 0xBC, 0x30, 0xF8, 0x36, 0xC5, 0x8E, 0xD7,  // ".0.6...
                /* 1A78 */  0x0C, 0x32, 0x54, 0x9C, 0xC0, 0x6F, 0xD7, 0x1C,  // .2T..o..
                /* 1A80 */  0x2C, 0xEC, 0x63, 0xC0, 0xE3, 0x86, 0xEF, 0x65,  // ,.c....e
                /* 1A88 */  0xEC, 0x26, 0x10, 0xEB, 0x31, 0xC9, 0x23, 0xE6,  // .&..1.#.
                /* 1A90 */  0xF7, 0xA9, 0x03, 0x8A, 0xF4, 0xFC, 0xE3, 0x09,  // ........
                /* 1A98 */  0xF8, 0x92, 0xE5, 0xFB, 0xE3, 0x49, 0xF9, 0xAC,  // .....I..
                /* 1AA0 */  0x6A, 0xF4, 0x57, 0x09, 0x5F, 0xCA, 0x8C, 0xEC,  // j.W._...
                /* 1AA8 */  0x13, 0x18, 0xBB, 0x49, 0xB2, 0x41, 0xF1, 0xAB,  // ...I.A..
                /* 1AB0 */  0xA9, 0x0F, 0x21, 0x9E, 0x0A, 0xBB, 0x3F, 0x61,  // ..!...?a
                /* 1AB8 */  0xC0, 0x8E, 0xC0, 0xA7, 0x43, 0x7E, 0x74, 0x09,  // ....C~t.
                /* 1AC0 */  0x14, 0xA5, 0x78, 0x4C, 0xDD, 0x1C, 0x3C, 0x43,  // ..xL..<C
                /* 1AC8 */  0x83, 0x62, 0xE0, 0x0F, 0x92, 0xCD, 0x2E, 0xAE,  // .b......
                /* 1AD0 */  0xB1, 0x7C, 0x2F, 0x31, 0x22, 0x76, 0x40, 0x0C,  // .|/1"v@.
                /* 1AD8 */  0xE5, 0x3D, 0xD2, 0xEA, 0x51, 0xC8, 0x1C, 0x3C,  // .=..Q..<
                /* 1AE0 */  0x22, 0xCF, 0xC6, 0xD3, 0x61, 0xA7, 0x0E, 0xFC,  // "...a...
                /* 1AE8 */  0x24, 0x7C, 0x6A, 0xF2, 0xC1, 0xCE, 0x03, 0xF2,  // $|j.....
                /* 1AF0 */  0x50, 0xF8, 0x14, 0x19, 0xB0, 0xFF, 0xFF, 0xC0,  // P.......
                /* 1AF8 */  0x78, 0x98, 0x97, 0x00, 0x06, 0xED, 0xE1, 0x33,  // x......3
                /* 1B00 */  0xF4, 0x17, 0x23, 0xA3, 0xF3, 0xF3, 0xCE, 0xE9,  // ..#.....
                /* 1B08 */  0xF8, 0x1C, 0xEA, 0xA3, 0x86, 0xEF, 0x01, 0x98,  // ........
                /* 1B10 */  0x33, 0x99, 0x4F, 0x00, 0x3E, 0xB3, 0x31, 0xA0,  // 3.O.>.1.
                /* 1B18 */  0x47, 0x7B, 0x06, 0xF2, 0xBE, 0xCA, 0x2E, 0x3F,  // G{.....?
                /* 1B20 */  0x18, 0xA4, 0x77, 0x5D, 0x9F, 0x7E, 0x30, 0xF7,  // ..w].~0.
                /* 1B28 */  0x33, 0x0E, 0x16, 0xE8, 0x58, 0xF9, 0x64, 0xE2,  // 3...X.d.
                /* 1B30 */  0x79, 0xC2, 0x1E, 0x29, 0x9C, 0xDB, 0x26, 0x8C,  // y..)..&.
                /* 1B38 */  0x2B, 0x2F, 0xBF, 0x06, 0xF2, 0x5B, 0x39, 0xB8,  // +/...[9.
                /* 1B40 */  0xAE, 0x18, 0x3E, 0x99, 0x80, 0x19, 0x1E, 0x13,  // ..>.....
                /* 1B48 */  0xE8, 0x3C, 0x43, 0x65, 0x8D, 0x0B, 0x75, 0xA4,  // .<Ce..u.
                /* 1B50 */  0xF1, 0x35, 0x95, 0x61, 0x3F, 0x0C, 0x78, 0xD2,  // .5.a?.x.
                /* 1B58 */  0x87, 0x79, 0x82, 0x2F, 0x6B, 0x18, 0x58, 0x5F,  // .y./k.X_
                /* 1B60 */  0x4A, 0x38, 0xAC, 0xD1, 0xC2, 0xBE, 0x0E, 0x18,  // J8......
                /* 1B68 */  0xF6, 0x11, 0x10, 0x77, 0xFD, 0x05, 0x0B, 0x20,  // ...w... 
                /* 1B70 */  0xFE, 0x92, 0xF0, 0x60, 0xE0, 0x09, 0x18, 0x90,  // ...`....
                /* 1B78 */  0xC5, 0x59, 0x15, 0x15, 0xB1, 0x1C, 0x05, 0x80,  // .Y......
                /* 1B80 */  0x41, 0xFD, 0xFF, 0x47, 0xE7, 0xFB, 0x37, 0xE0,  // A..G..7.
                /* 1B88 */  0xE4, 0xB2, 0x8D, 0xBF, 0x47, 0xBC, 0x1E, 0x78,  // ....G..x
                /* 1B90 */  0xB0, 0xEC, 0xB2, 0xFD, 0x20, 0xF3, 0x80, 0xF0,  // .... ...
                /* 1B98 */  0x1C, 0xF3, 0x0E, 0xF3, 0x50, 0xF0, 0x2E, 0x13,  // ....P...
                /* 1BA0 */  0x21, 0xC8, 0x53, 0xF6, 0x3B, 0x42, 0x84, 0x50,  // !.S.;B.P
                /* 1BA8 */  0x81, 0x5E, 0xB6, 0x8D, 0x17, 0xF4, 0x65, 0x22,  // .^....e"
                /* 1BB0 */  0x4A, 0x9C, 0x28, 0x11, 0x42, 0x19, 0xE3, 0x5C,  // J.(.B..\
                /* 1BB8 */  0x9E, 0x0E, 0x5E, 0x6A, 0xC2, 0x3D, 0x26, 0x04,  // ..^j.=&.
                /* 1BC0 */  0x7E, 0x72, 0x88, 0x12, 0xD8, 0x63, 0x7C, 0xD9,  // ~r...c|.
                /* 1BC8 */  0x66, 0xE2, 0x2F, 0x32, 0xBA, 0x27, 0xF9, 0xB2,  // f./2.'..
                /* 1BD0 */  0x0D, 0x38, 0xFF, 0xFF, 0x5F, 0xB6, 0xC1, 0x75,  // .8.._..u
                /* 1BD8 */  0x71, 0x06, 0xF3, 0x8D, 0x16, 0x30, 0x77, 0x71,  // q....0wq
                /* 1BE0 */  0x06, 0xFB, 0x70, 0x61, 0x0F, 0x83, 0x87, 0x79,  // ..pa...y
                /* 1BE8 */  0x4F, 0xF8, 0x50, 0x42, 0xE5, 0xC3, 0xA0, 0xCE,  // O.PB....
                /* 1BF0 */  0x25, 0xC0, 0xF1, 0xFF, 0x7F, 0x2E, 0x01, 0x46,  // %......F
                /* 1BF8 */  0x33, 0x7A, 0x03, 0x78, 0x15, 0x38, 0xED, 0x47,  // 3z.x.8.G
                /* 1C00 */  0x91, 0x87, 0x92, 0x43, 0x88, 0xF1, 0x3E, 0x12,  // ...C..>.
                /* 1C08 */  0xC4, 0x08, 0x87, 0xFE, 0x5C, 0xE2, 0xEB, 0xC8,  // ....\...
                /* 1C10 */  0x93, 0x5B, 0x88, 0x28, 0xEF, 0x27, 0x4F, 0x28,  // .[.(.'O(
                /* 1C18 */  0x86, 0x88, 0x12, 0x2C, 0x46, 0xB0, 0xD0, 0x4F,  // ...,F..O
                /* 1C20 */  0x25, 0xC6, 0x60, 0x87, 0x94, 0x20, 0xE1, 0x9E,  // %.`.. ..
                /* 1C28 */  0x4B, 0x98, 0xF4, 0xEF, 0x9D, 0xCE, 0xB9, 0x3E,  // K......>
                /* 1C30 */  0x97, 0x00, 0xFC, 0x08, 0x77, 0xB7, 0x45, 0x9F,  // ....w.E.
                /* 1C38 */  0x1B, 0x7C, 0x4C, 0xF0, 0xF9, 0xC0, 0x10, 0x8D,  // .|L.....
                /* 1C40 */  0x5F, 0x0C, 0xC8, 0xF5, 0xCD, 0x77, 0x04, 0x1F,  // _....w..
                /* 1C48 */  0x13, 0x5E, 0xE0, 0x18, 0x81, 0xFF, 0xFF, 0x01,  // .^......
                /* 1C50 */  0x86, 0x4E, 0xCF, 0x9D, 0xE0, 0x18, 0x94, 0x87,  // .N......
                /* 1C58 */  0x07, 0xFE, 0x03, 0x19, 0x3E, 0xFC, 0x75, 0x12,  // ....>.u.
                /* 1C60 */  0x75, 0x4C, 0xE0, 0xC3, 0x83, 0x77, 0xFA, 0x73,  // uL...w.s
                /* 1C68 */  0xC8, 0xA3, 0x18, 0x1D, 0x1C, 0x38, 0x9E, 0xEF,  // .....8..
                /* 1C70 */  0x1A, 0x1C, 0x08, 0x0E, 0x27, 0x0F, 0x1E, 0xD8,  // ....'...
                /* 1C78 */  0xC3, 0x19, 0x9B, 0x38, 0x1F, 0xC2, 0xD1, 0xF8,  // ...8....
                /* 1C80 */  0x08, 0x00, 0x8E, 0xB3, 0x03, 0xF8, 0xA2, 0x0E,  // ........
                /* 1C88 */  0x17, 0x7D, 0x38, 0xF0, 0x1D, 0x13, 0x06, 0xFA,  // .}8.....
                /* 1C90 */  0x6B, 0x86, 0x6F, 0x6F, 0x46, 0xE7, 0x71, 0x06,  // k.ooF.q.
                /* 1C98 */  0x0C, 0xAA, 0xC1, 0x7A, 0xC0, 0xF0, 0xFF, 0xFF,  // ...z....
                /* 1CA0 */  0x67, 0x40, 0xFC, 0x0C, 0x5E, 0x2E, 0x9E, 0x2C,  // g@..^..,
                /* 1CA8 */  0xF8, 0x28, 0xC1, 0x77, 0xE2, 0xF3, 0x89, 0x02,  // .(.w....
                /* 1CB0 */  0x37, 0x18, 0x9F, 0xEA, 0x31, 0x67, 0x09, 0xB0,  // 7...1g..
                /* 1CB8 */  0x5D, 0x57, 0x7D, 0x96, 0x00, 0x3E, 0xF2, 0x0E,  // ]W}..>..
                /* 1CC0 */  0x58, 0xA0, 0x39, 0x20, 0xC1, 0x38, 0x59, 0x01,  // X.9 .8Y.
                /* 1CC8 */  0x76, 0xC6, 0xF1, 0x64, 0x05, 0xE6, 0xFF, 0xFF,  // v..d....
                /* 1CD0 */  0xF0, 0x7C, 0x04, 0xC7, 0x8F, 0x81, 0x2B, 0xB4,  // .|....+.
                /* 1CD8 */  0xE9, 0x53, 0xA3, 0x51, 0xAB, 0x06, 0x65, 0x6A,  // .S.Q..ej
                /* 1CE0 */  0x94, 0x69, 0x50, 0xAB, 0x4F, 0xA5, 0xC6, 0x8C,  // .iP.O...
                /* 1CE8 */  0x09, 0x3B, 0x55, 0x29, 0xE0, 0xB3, 0x41, 0x03,  // .;U)..A.
                /* 1CF0 */  0xB3, 0x3C, 0x0A, 0x81, 0x58, 0xCC, 0x9B, 0x42,  // .<..X..B
                /* 1CF8 */  0x20, 0x0E, 0x0B, 0x42, 0x23, 0x1D, 0x8E, 0x04,  //  ..B#...
                /* 1D00 */  0x62, 0xC9, 0x47, 0x2C, 0x81, 0x58, 0xAE, 0x07,  // b.G,.X..
                /* 1D08 */  0x10, 0x16, 0xF0, 0x4D, 0x22, 0x70, 0xF2, 0x46,  // ...M"p.F
                /* 1D10 */  0x12, 0x38, 0x79, 0x26, 0x08, 0xC4, 0x91, 0x41,  // .8y&...A
                /* 1D18 */  0xA8, 0x50, 0x1D, 0x20, 0x2C, 0x26, 0x08, 0x0D,  // .P. ,&..
                /* 1D20 */  0xE5, 0x03, 0x84, 0x49, 0x7F, 0x1A, 0x08, 0x90,  // ...I....
                /* 1D28 */  0x18, 0x01, 0x61, 0xE1, 0x1E, 0x12, 0x02, 0xB1,  // ..a.....
                /* 1D30 */  0xB4, 0xE7, 0x83, 0x40, 0x2C, 0xC4, 0x0A, 0x08,  // ...@,...
                /* 1D38 */  0x8B, 0x0B, 0x42, 0xC3, 0x69, 0x01, 0x61, 0x92,  // ..B.i.a.
                /* 1D40 */  0xCC, 0x80, 0xB0, 0x40, 0x20, 0x54, 0xFE, 0x2B,  // ...@ T.+
                /* 1D48 */  0x5D, 0x20, 0x16, 0xE9, 0x06, 0x90, 0x2E, 0x5D,  // ] .....]
                /* 1D50 */  0x20, 0x0E, 0xA2, 0x07, 0x84, 0xC9, 0xF0, 0x03,  //  .......
                /* 1D58 */  0xC2, 0x42, 0x83, 0xD0, 0x68, 0xEF, 0x09, 0x01,  // .B..h...
                /* 1D60 */  0x12, 0x43, 0x20, 0x2C, 0xBE, 0x23, 0x10, 0x26,  // .C ,.#.&
                /* 1D68 */  0xFE, 0x69, 0x22, 0x10, 0xE7, 0xB7, 0x04, 0x71,  // .i"....q
                /* 1D70 */  0x53, 0x1A, 0x62, 0x4D, 0x40, 0x4C, 0x83, 0x27,  // S.bM@L.'
                /* 1D78 */  0x20, 0xA6, 0x08, 0x44, 0x40, 0x8E, 0xFD, 0xD2,  //  ..D@...
                /* 1D80 */  0x10, 0x90, 0x35, 0x98, 0x02, 0x62, 0xD1, 0x41,  // ..5..b.A
                /* 1D88 */  0x04, 0x64, 0x21, 0xAA, 0x80, 0x58, 0x5E, 0x57,  // .d!..X^W
                /* 1D90 */  0x40, 0x2C, 0x3C, 0x88, 0x80, 0x9C, 0xF9, 0xCD,  // @,<.....
                /* 1D98 */  0x2A, 0x20, 0x2B, 0x78, 0x74, 0x3D, 0x04, 0xB0,  // * +xt=..
                /* 1DA0 */  0xAF, 0xBC, 0x80, 0x9C, 0x1C, 0x44, 0x40, 0x0E,  // .....D@.
                /* 1DA8 */  0xEC, 0x0B, 0x88, 0xC5, 0x07, 0x11, 0x90, 0xB3,  // ........
                /* 1DB0 */  0xFE, 0xC1, 0x05, 0xE4, 0xE0, 0x20, 0x1A, 0x04,  // ..... ..
                /* 1DB8 */  0xF9, 0x68, 0x08, 0xC8, 0xE9, 0x41, 0x04, 0x44,  // .h...A.D
                /* 1DC0 */  0x7E, 0xE4, 0x02, 0xB1, 0xDA, 0x2F, 0xB9, 0x40,  // ~..../.@
                /* 1DC8 */  0xAC, 0xE7, 0x4F, 0xAE, 0xA1, 0x10, 0x10, 0xAA,  // ..O.....
                /* 1DD0 */  0x5C, 0xDD, 0x49, 0x85, 0xFD, 0xFF, 0x73, 0x80,  // \.I...s.
                /* 1DD8 */  0xD0, 0x5C, 0x20, 0x02, 0xB3, 0x0A, 0x77, 0x40,  // .\ ...w@
                /* 1DE0 */  0x4C, 0x15, 0x88, 0x80, 0x9C, 0x00, 0x88, 0xA6,  // L.......
                /* 1DE8 */  0x02, 0xA1, 0x29, 0xC1, 0xA8, 0xAE, 0x37, 0x88,  // ..)...7.
                /* 1DF0 */  0x80, 0x9C, 0x00, 0x84, 0xA6, 0x02, 0xA1, 0x29,  // .......)
                /* 1DF8 */  0x41, 0x04, 0x68, 0x55, 0xF6, 0x80, 0x98, 0x52,  // A.hU...R
                /* 1E00 */  0x10, 0xAA, 0x1C, 0x84, 0xA6, 0x03, 0xA1, 0xB2,  // ........
                /* 1E08 */  0xDF, 0xFD, 0x3A, 0x2C, 0x10, 0x10, 0x01, 0x39,  // ..:,...9
                /* 1E10 */  0x3A, 0x08, 0x15, 0xEE, 0x0F, 0x84, 0xE9, 0x7D,  // :......}
                /* 1E18 */  0x66, 0x08, 0xD0, 0xE9, 0x40, 0x04, 0xE4, 0xC4,  // f...@...
                /* 1E20 */  0x20, 0x54, 0xC1, 0x0F, 0x23, 0x08, 0x11, 0x0B,  //  T..#...
                /* 1E28 */  0x42, 0x15, 0xFC, 0x30, 0x82, 0x12, 0x2D, 0x2F,  // B..0..-/
                /* 1E30 */  0x0E, 0x01, 0x59, 0x1F, 0x08, 0xD5, 0x0B, 0x22,  // ..Y...."
                /* 1E38 */  0x30, 0x67, 0x03, 0xA2, 0x79, 0x41, 0x68, 0x7E,  // 0g..yAh~
                /* 1E40 */  0x30, 0xAA, 0xD5, 0x28, 0x10, 0xD3, 0x0F, 0x42,  // 0..(...B
                /* 1E48 */  0xF3, 0x80, 0x08, 0xCC, 0x0A, 0xDE, 0x1E, 0x07,  // ........
                /* 1E50 */  0xCC, 0x40, 0xA8, 0x4A, 0x10, 0x81, 0x39, 0x17,  // .@.J..9.
                /* 1E58 */  0x10, 0xCD, 0x0A, 0x42, 0xB3, 0x83, 0x51, 0xED,  // ...B..Q.
                /* 1E60 */  0x9F, 0x10, 0x0D, 0x80, 0x80, 0xD0, 0x7C, 0x20,  // ......| 
                /* 1E68 */  0x3A, 0x0C, 0x90, 0xE7, 0xA0, 0x80, 0xAC, 0x11,  // :.......
                /* 1E70 */  0x84, 0x6A, 0x06, 0xD1, 0xF1, 0x80, 0x00, 0xD1,  // .j......
                /* 1E78 */  0xFC, 0x20, 0x54, 0xCF, 0xC7, 0x24, 0x18, 0xC9,  // . T..$..
                /* 1E80 */  0x00, 0x22, 0x20, 0x6B, 0xF9, 0xF2, 0x07, 0x22,  // ." k..."
                /* 1E88 */  0xFA, 0x41, 0x04, 0xE4, 0x4C, 0x20, 0x34, 0x23,  // .A..L 4#
                /* 1E90 */  0x18, 0x55, 0xFB, 0x2E, 0xD2, 0x71, 0x80, 0x80,  // .U...q..
                /* 1E98 */  0xD0, 0x44, 0x20, 0x1A, 0x1E, 0x79, 0xED, 0x1C,  // .D ..y..
                /* 1EA0 */  0x1E, 0x03, 0xA1, 0x2A, 0x41, 0x04, 0x66, 0x8D,  // ...*A.f.
                /* 1EA8 */  0x0F, 0x4C, 0x81, 0x38, 0x21, 0x08, 0x55, 0x6F,  // .L.8!.Uo
                /* 1EB0 */  0xF7, 0xC0, 0x40, 0xF5, 0x82, 0xB0, 0xFF, 0xBF,  // ..@.....
                /* 1EB8 */  0x5A, 0xC1, 0x83, 0xA0, 0x20, 0x34, 0x11, 0x88,  // Z... 4..
                /* 1EC0 */  0x0E, 0x19, 0xE4, 0xD5, 0x12, 0x88, 0xE8, 0x02,  // ........
                /* 1EC8 */  0xA1, 0x3A, 0x41, 0x34, 0x64, 0x02, 0x44, 0xB3,  // .:A4d.D.
                /* 1ED0 */  0x82, 0xD0, 0xEC, 0x60, 0x34, 0xFB, 0xF3, 0x45,  // ...`4..E
                /* 1ED8 */  0xC3, 0x20, 0x5F, 0x25, 0x1D, 0x18, 0xC8, 0xE3,  // . _%....
                /* 1EE0 */  0x31, 0x08, 0x51, 0xF4, 0x6D, 0x12, 0x88, 0x73,  // 1.Q.m..s
                /* 1EE8 */  0x3F, 0x80, 0x34, 0x50, 0xF2, 0x29, 0x0A, 0x42,  // ?.4P.).B
                /* 1EF0 */  0xB4, 0x81, 0x08, 0xCC, 0x39, 0x80, 0x68, 0x36,  // ....9.h6
                /* 1EF8 */  0x10, 0x9A, 0x15, 0x8C, 0x66, 0x55, 0x7D, 0xC4,  // ....fU}.
                /* 1F00 */  0xA0, 0x4F, 0x9F, 0x43, 0x63, 0x2F, 0x3D, 0x81,  // .O.Cc/=.
                /* 1F08 */  0x58, 0xC9, 0xCB, 0xE6, 0xD1, 0x82, 0xFD, 0xBC,  // X.......
                /* 1F10 */  0x82, 0xB0, 0x4F, 0x59, 0x60, 0xF6, 0x32, 0xD2,  // ..OY`.2.
                /* 1F18 */  0x31, 0x80, 0x80, 0x50, 0x3D, 0xCF, 0x33, 0x1D,  // 1..P=.3.
                /* 1F20 */  0x01, 0x08, 0x88, 0x8E, 0x00, 0x04, 0x84, 0x66,  // .......f
                /* 1F28 */  0x04, 0xA1, 0xD9, 0x41, 0xA8, 0xAE, 0xA7, 0xA3,  // ...A....
                /* 1F30 */  0x40, 0xAD, 0xED, 0xBF, 0x13, 0x84, 0x24, 0x03,  // @.....$.
                /* 1F38 */  0xA1, 0xAA, 0x7F, 0xF3, 0x41, 0x88, 0xE2, 0xB7,  // ....A...
                /* 1F40 */  0xA3, 0x86, 0x49, 0x9E, 0x6A, 0x0F, 0x01, 0xEC,  // ..I.j...
                /* 1F48 */  0xA5, 0x28, 0x70, 0xEB, 0x06, 0xA1, 0x39, 0x40,  // .(p...9@
                /* 1F50 */  0x34, 0x50, 0x02, 0x44, 0xB5, 0xFC, 0x2E, 0x35,  // 4P.D...5
                /* 1F58 */  0x50, 0x02, 0x22, 0x30, 0x67, 0x02, 0xA2, 0x39,  // P."0g..9
                /* 1F60 */  0x41, 0xA8, 0x0A, 0xFD, 0xC3, 0xA0, 0x20, 0x02,  // A..... .
                /* 1F68 */  0x72, 0x0A, 0x10, 0x9A, 0x0A, 0x8C, 0xEA, 0xF0,  // r.......
                /* 1F70 */  0x3F, 0x00, 0x0A, 0x42, 0xB5, 0x82, 0xE8, 0x70,  // ?..B...p
                /* 1F78 */  0x41, 0x12, 0x80, 0xB0, 0xA4, 0x20, 0x34, 0x45,  // A.... 4E
                /* 1F80 */  0x83, 0x83, 0x09, 0x8D, 0x00, 0x48, 0x2B, 0x1C,  // .....H+.
                /* 1F88 */  0x6E, 0x68, 0x08, 0x70, 0x16, 0x0A, 0x84, 0x06,  // nh.p....
                /* 1F90 */  0x05, 0xD1, 0xB1, 0xC5, 0xA9, 0x41, 0x04, 0x68,  // .....A.h
                /* 1F98 */  0x81, 0x25, 0x0E, 0x20, 0x14, 0x84, 0xFE, 0xFF,  // .%. ....
                /* 1FA0 */  0x03, 0x80, 0x08, 0xD0, 0x69, 0x40, 0x74, 0x44,  // ....i@tD
                /* 1FA8 */  0x20, 0x60, 0x54, 0x47, 0x8A, 0x21, 0x51, 0x10,  //  `TG.!Q.
                /* 1FB0 */  0x01, 0x5A, 0x28, 0x88, 0x8E, 0x3E, 0xA4, 0x05,  // .Z(..>..
                /* 1FB8 */  0x18, 0x13, 0x05, 0x42, 0xC5, 0x83, 0x50, 0xAD,  // ...B..P.
                /* 1FC0 */  0x31, 0x40, 0x99, 0x72, 0x10, 0x81, 0x3A, 0x39,  // 1@.r..:9
                /* 1FC8 */  0x88, 0x8E, 0x04, 0xA4, 0xC6, 0xA1, 0x82, 0x82,  // ........
                /* 1FD0 */  0x50, 0xD5, 0x20, 0x54, 0x4E, 0x0E, 0x10, 0x26,  // P. TN..&
                /* 1FD8 */  0x0D, 0x84, 0xCA, 0x05, 0xD1, 0x00, 0xAC, 0x1D,  // ........
                /* 1FE0 */  0x44, 0xC7, 0x26, 0x02, 0x46, 0xE3, 0x83, 0x50,  // D.&.F..P
                /* 1FE8 */  0x49, 0x3D, 0x00, 0x99, 0x3E, 0x10, 0x01, 0x3A,  // I=..>..:
                /* 1FF0 */  0x3D, 0x88, 0x0E, 0x03, 0x24, 0xC8, 0x41, 0x84,  // =...$.A.
                /* 1FF8 */  0x82, 0x50, 0x89, 0x45, 0x40, 0x99, 0x60, 0x10,  // .P.E@.`.
                /* 2000 */  0x1D, 0x7F, 0x08, 0x88, 0xC0, 0x2C, 0x23, 0x09,  // .....,#.
                /* 2008 */  0x08, 0x13, 0x07, 0x42, 0xC5, 0x82, 0x50, 0x21,  // ...B..P!
                /* 2010 */  0x51, 0x40, 0x59, 0x0C, 0x10, 0x1A, 0x24, 0x0B,  // Q@Y...$.
                /* 2018 */  0x18, 0x0B, 0x07, 0x42, 0xC3, 0x82, 0xE8, 0x78,  // ...B...x
                /* 2020 */  0x45, 0xBA, 0x00, 0x31, 0xC9, 0x20, 0x34, 0x02,  // E..1. 4.
                /* 2028 */  0x08, 0x0D, 0x0B, 0x22, 0x40, 0x12, 0x06, 0x90,  // ..."@...
                /* 2030 */  0x82, 0xD0, 0x08, 0x20, 0x34, 0x2B, 0x08, 0xD5,  // ... 4+..
                /* 2038 */  0x5E, 0x06, 0x94, 0x25, 0x06, 0xD1, 0x91, 0x81,  // ^..%....
                /* 2040 */  0xA4, 0x39, 0x9C, 0x50, 0x10, 0x81, 0x39, 0x0D,  // .9.P..9.
                /* 2048 */  0x10, 0x4D, 0x08, 0x42, 0x13, 0x83, 0x50, 0x79,  // .M.B..Py
                /* 2050 */  0x6D, 0x40, 0x58, 0x7A, 0x10, 0x1D, 0x1F, 0xC8,  // m@Xz....
                /* 2058 */  0x83, 0x51, 0xC7, 0x07, 0x02, 0x42, 0x53, 0x81,  // .Q...BS.
                /* 2060 */  0xE8, 0xC0, 0x43, 0xEA, 0x1C, 0x78, 0x28, 0x08,  // ..C..x(.
                /* 2068 */  0x55, 0x0F, 0xA2, 0xC3, 0x03, 0x29, 0x04, 0xC2,  // U....)..
                /* 2070 */  0x74, 0x26, 0x3A, 0xD6, 0xD0, 0x46, 0x07, 0x03,  // t&:..F..
                /* 2078 */  0xFA, 0x08, 0x16, 0xA8, 0xFF, 0xFF, 0x6A, 0x2A,  // ......j*
                /* 2080 */  0x81, 0x30, 0x75, 0x20, 0x54, 0x3F, 0x08, 0xCD,  // .0u T?..
                /* 2088 */  0x0A, 0x22, 0x50, 0xEB, 0xCB, 0x74, 0x10, 0xA0,  // ."P..t..
                /* 2090 */  0x20, 0x34, 0x03, 0x88, 0x06, 0x40, 0x80, 0xA8,  //  4...@..
                /* 2098 */  0x9A, 0x4E, 0x03, 0xA0, 0x20, 0x3A, 0xA4, 0x90,  // .N.. :..
                /* 20A0 */  0x54, 0xC7, 0x12, 0xDA, 0x0A, 0x84, 0xA5, 0x05,  // T.......
                /* 20A8 */  0xA1, 0xC2, 0x7A, 0x81, 0x32, 0x91, 0x20, 0x54,  // ..z.2. T
                /* 20B0 */  0x38, 0x88, 0x8E, 0x06, 0x4E, 0x01, 0xA2, 0xA3,  // 8...N...
                /* 20B8 */  0x0A, 0x01, 0xA3, 0xD9, 0x41, 0xA8, 0x9E, 0x60,  // ....A..`
                /* 20C0 */  0x80, 0x4C, 0x1C, 0x88, 0x00, 0x9D, 0x04, 0x44,  // .L.....D
                /* 20C8 */  0x83, 0x25, 0x20, 0x34, 0x29, 0x20, 0x8D, 0x0D,  // .% 4) ..
                /* 20D0 */  0x48, 0xA5, 0x16, 0x3B, 0x46, 0x51, 0x10, 0x1A,  // H..;FQ..
                /* 20D8 */  0x05, 0x44, 0x80, 0xCE, 0x05, 0xA2, 0xC3, 0x1C,  // .D......
                /* 20E0 */  0x49, 0x76, 0xCA, 0xA4, 0x20, 0x54, 0x2C, 0x88,  // Iv.. T,.
                /* 20E8 */  0x0E, 0x17, 0x04, 0x44, 0x80, 0x8E, 0x0A, 0x46,  // ...D...F
                /* 20F0 */  0x63, 0x83, 0x50, 0x29, 0xCD, 0x00, 0x99, 0x2E,  // c.P)....
                /* 20F8 */  0x10, 0x01, 0x3A, 0x35, 0x88, 0xC0, 0xAC, 0x21,  // ..:5...!
                /* 2100 */  0xDA, 0x21, 0x81, 0x82, 0xD0, 0x68, 0xD9, 0x40,  // .!...h.@
                /* 2108 */  0x59, 0x50, 0x10, 0x1D, 0xED, 0x48, 0x37, 0x30,  // YP...H70
                /* 2110 */  0x26, 0x1F, 0x84, 0x86, 0x02, 0xA1, 0x21, 0x41,  // &.....!A
                /* 2118 */  0x68, 0x80, 0x72, 0x87, 0x38, 0x0A, 0x42, 0xE5,  // h.r.8.B.
                /* 2120 */  0xD4, 0x03, 0x61, 0x61, 0x40, 0xA8, 0xD0, 0x7C,  // ..aa@..|
                /* 2128 */  0x47, 0x3B, 0xDA, 0x0F, 0x90, 0x06, 0x04, 0x61,  // G;.....a
                /* 2130 */  0xF1, 0x40, 0xE8, 0xFF, 0x1F                     // .@...
            })
        }

        OperationRegion (LDPT, SystemIO, 0x80, 0x01)
        Field (LDPT, ByteAcc, NoLock, Preserve)
        {
            LPDG,   8
        }

        OperationRegion (LDBP, SystemIO, 0x024C, 0x04)
        Field (LDBP, ByteAcc, NoLock, Preserve)
        {
            SLD1,   8, 
            SLD2,   8, 
            LLPD,   8, 
            LUPD,   8
        }

        Mutex (LDPS, 0x00)
        Mutex (LEXD, 0x00)
        Name (EDDA, 0x00)
        Method (ODBG, 1, NotSerialized)
        {
            Acquire (LDPS, 0xFFFF)
            LLPD = Arg0
            LPDG = Arg0
            Release (LDPS)
            Return (0x00)
        }

        Method (ODG1, 1, NotSerialized)
        {
            Acquire (LDPS, 0xFFFF)
            LUPD = Arg0
            Release (LDPS)
            Return (0x00)
        }

        Method (ODGW, 1, NotSerialized)
        {
            Acquire (LDPS, 0xFFFF)
            LLPD = (Arg0 & 0xFF)
            LUPD = ((Arg0 >> 0x08) & 0xFF)
            LPDG = (Arg0 & 0xFF)
            Release (LDPS)
            Return (0x00)
        }

        Method (ODGD, 1, NotSerialized)
        {
            Return (0x00)
        }

        Method (OTBY, 1, NotSerialized)
        {
            Return (0x00)
        }

        Method (OTWD, 1, NotSerialized)
        {
            Return (0x00)
        }

        Method (OTDD, 1, NotSerialized)
        {
            Return (0x00)
        }

        Method (ISDR, 0, NotSerialized)
        {
            Return (0x00)
        }

        Method (EODB, 0, Serialized)
        {
            Acquire (LEXD, 0xFFFF)
            ODBG (EDDA)
            Release (LEXD)
        }

        Method (EODW, 0, Serialized)
        {
            Acquire (LEXD, 0xFFFF)
            ODGW (EDDA)
            Release (LEXD)
        }

        Method (EODD, 0, Serialized)
        {
            Acquire (LEXD, 0xFFFF)
            ODGD (EDDA)
            Release (LEXD)
        }
    }

    Method (\_SB.DCKD, 0, Serialized)
    {
        Local0 = 0x01
        If ((GPL0 & 0x2000))
        {
            Local0 = 0x00
        }

        Return (Local0)
    }

    Method (\_SB.HST1.ISUD, 0, Serialized)
    {
        Return (0x01)
    }

    Method (\_GPE.DKET, 0, Serialized)
    {
        If ((ICPT == 0x00))
        {
            If (\_SB.DCKD ())
            {
                Notify (\_SB.PCI0.LPCB.SIO.COM1, 0x00) // Bus Check
            }
            Else
            {
                Notify (\_SB.PCI0.LPCB.SIO.COM1, 0x01) // Device Check
            }
        }
    }

    Method (\_SB.PCI0.ACEL.ALED, 1, Serialized)
    {
        If (Arg0)
        {
            GPL2 |= 0x02
        }
        Else
        {
            GPL2 &= ~0x02
        }
    }

    Method (\_SB.GRFS, 0, Serialized)
    {
        Local0 = \_SB.PCI0.LPCB.EC0.KRFS ()
        Return (Local0)
    }

    Method (\_SB.HODM, 3, NotSerialized)
    {
        Return (Package (0x02)
        {
            0x03, 
            0x00
        })
    }

    Method (PPTS, 1, Serialized)
    {
        \_SB.SSMI (0x5D, 0x03, 0x00, 0x00, 0x00)
        Local0 = 0x00
    }

    Method (PWAK, 1, Serialized)
    {
        Notify (\_SB.PCI0.LPCB.SIO.COM1, 0x00) // Bus Check
        Notify (\_SB.PCI0.RP02, 0x00) // Bus Check
        Notify (\_SB.PCI0.EHC1, 0x00) // Bus Check
        Notify (\_SB.PCI0.EHC2, 0x00) // Bus Check
        If (((Arg0 == 0x04) || (Arg0 == 0x03)))
        {
            \_SB.SSMI (0x5D, 0x01, 0x00, 0x00, 0x00)
            Notify (\_SB.PCI0.RP03, 0x00) // Bus Check
        }

        If (((Arg0 == 0x04) || (Arg0 == 0x03)))
        {
            If ((\WCOS () == 0x06))
            {
                If (\_SB.PCI0.RP06.NIC.LPON ())
                {
                    If (\_SB.DCKD ())
                    {
                        Notify (\_SB.PCI0.RP06.NIC, 0x00) // Bus Check
                    }
                }
            }
        }
    }

    Method (\_SB.PCI0.LPCB.PS2M._HID, 0, Serialized)  // _HID: Hardware ID
    {
        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler, x=0-9, A-Z
        _T_0 = PRDT /* \PRDT */
        If ((_T_0 == 0x01))
        {
            Local1 = 0x7C012E4F
        }
        ElseIf ((_T_0 == 0x02))
        {
            Local1 = 0x7B012E4F
        }
        ElseIf ((_T_0 == 0x03))
        {
            Local1 = 0x7D012E4F
        }
        ElseIf ((_T_0 == 0x05))
        {
            Local1 = 0x83012E4F
        }
        ElseIf ((_T_0 == 0x07))
        {
            Local1 = 0x80012E4F
        }
        ElseIf ((_T_0 == 0x08))
        {
            Local1 = 0x87012E4F
        }
        ElseIf ((_T_0 == 0x09))
        {
            Local1 = 0x86012E4F
        }
        ElseIf ((_T_0 == 0x0A))
        {
            Local1 = 0x85012E4F
        }
        ElseIf ((_T_0 == 0x0C))
        {
            Local1 = 0x7D012E4F
        }
        Else
        {
            Local1 = 0x65012E4F
        }

        Return (Local1)
    }

    Name (_S0, Package (0x03)  // _S0_: S0 System State
    {
        0x00, 
        0x00, 
        0x00
    })
    Name (_S3, Package (0x03)  // _S3_: S3 System State
    {
        0x05, 
        0x05, 
        0x00
    })
    Name (_S4, Package (0x03)  // _S4_: S4 System State
    {
        0x06, 
        0x06, 
        0x00
    })
    Name (_S5, Package (0x03)  // _S5_: S5 System State
    {
        0x07, 
        0x07, 
        0x00
    })
}


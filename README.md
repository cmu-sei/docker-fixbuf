[![Software Engineering Institute](https://avatars.githubusercontent.com/u/12465755?s=200&v=4)](https://www.sei.cmu.edu/)

[![Blog](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Blog)](https://insights.sei.cmu.edu/blog/ "blog posts from our experts in Software Engineering.")
[![Youtube](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Youtube&logo=youtube)](https://www.youtube.com/@TheSEICMU/ "vidoes from our experts in Software Engineering.")
[![Podcasts](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Podcasts&logo=applepodcasts)](https://insights.sei.cmu.edu/podcasts/ "podcasts from our experts in Software Engineering.")
[![GitHub](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=GitHub&logo=github)](https://github.com/cmu-sei "view the source for all of our repositories.")
[![Flow Tools](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Flow%20Tools)](https://tools.netsa.cert.org/ "documentation and source for all our flow collection and analysis tools.")


At the [SEI](https://www.sei.cmu.edu/), we research software engineering, cybersecurity, and AI engineering problems; create innovative technologies; and put solutions into practice.

Find us at:

* [Blog](https://insights.sei.cmu.edu/blog/) - blog posts from our experts in Software Engineering.
* [Youtube](https://www.youtube.com/@TheSEICMU/) - vidoes from our experts in Software Engineering.
* [Podcasts](https://insights.sei.cmu.edu/podcasts/) - podcasts from our experts in Software Engineering.
* [GitHub](https://github.com/cmu-sei) - view the source for all of our repositories.
* [Flow Tools](https://tools.netsa.cert.org/) - documentation and source for all our flow collection and analysis tools.

# [certcc/fixbuf](https://tools.netsa.cert.org/fixbuf2/index.html)


[![CI](https://img.shields.io/github/actions/workflow/status/cmu-sei/docker-fixbuf/release.yml?style=for-the-badge&logo=github)](https://github.com/cmu-sei/docker-fixbuf/actions?query=workflow%3ARelease) [![Docker pulls](https://img.shields.io/docker/pulls/cmusei/fixbuf?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/cmusei/fixbuf/)

[libfixbuf](https://tools.netsa.cert.org/fixbuf2/index.html) is a compliant implementation of the IPFIX Protocol, as defined in the "Specification of the IPFIX Protocol for the Exchange of Flow Information" (RFC 7011). It supports the information model defined in "Information Model for IP Flow Information Export" (RFC 7012), extended as proposed by "Bidirectional Flow Export using IPFIX" (RFC 5103) to support information elements for representing biflows. libfixbuf supports structured data elements as described in "Export of Structured Data in IPFIX" (RFC 6313), which adds the ability to export basicLists, subTemplateLists, and subTemplateMultiLists. libfixbuf can export type information for IPFIX elements as described in "Exporting Type Information for IPFIX Information Elements" (RFC 5610), and it supports reading this information.

## Documentation

More information [here](https://tools.netsa.cert.org/fixbuf2/libfixbuf/index.html).

## Usage

The intention of this container is to be used as a base for building other [NetSA tool](https://tools.netsa.cert.org/index.html) container images.

However, [ipfixDump](https://tools.netsa.cert.org/fixbuf2/ipfixDump.html) is included as part of the fixbuf install and can be used to print contents of an IPFIX file as human-readable text.  For example, the below command mounts the `$PWD/test` folder from the host to `/tmp` in the `fixbuf` container.  It contains a yaf produced ipfix file named `flows.yaf-20231026175944-00000.yaf`, that we use ipfixDump to produce stats for:

```bash
docker run --rm -it -v $PWD/test:/tmp \
  cmusei/fixbuf:latest \
  ipfixDump \
  --in /tmp/flows.yaf-20231026175944-00000.yaf \
  --stats \
  --yaf
```
```
*** File Stats: 2 Messages, 9 Data Records, 43 Template Records ***
  Template ID | Records
45873 (0xb331)| 9
49155 (0xc003)| 0
49156 (0xc004)| 0
49157 (0xc005)| 0
49160 (0xc008)| 0
49161 (0xc009)| 0
49171 (0xc013)| 0
49173 (0xc015)| 0
49176 (0xc018)| 0
49664 (0xc200)| 0
49670 (0xc206)| 0
49920 (0xc300)| 0
50176 (0xc400)| 0
50432 (0xc500)| 0
50688 (0xc600)| 0
50944 (0xc700)| 0
51200 (0xc800)| 0
51456 (0xc900)| 0
51712 (0xca00)| 0
51722 (0xca0a)| 4
51723 (0xca0b)| 4
51969 (0xcb01)| 0
51970 (0xcb02)| 0
51971 (0xcb03)| 0
52224 (0xcc00)| 1
52480 (0xcd00)| 0
52736 (0xce00)| 0
52737 (0xce01)| 0
52738 (0xce02)| 0
52739 (0xce03)| 0
52740 (0xce04)| 0
52741 (0xce05)| 0
52742 (0xce06)| 0
52743 (0xce07)| 0
52744 (0xce08)| 0
52745 (0xce09)| 0
52748 (0xce0c)| 0
52749 (0xce0d)| 0
52756 (0xce14)| 0
52992 (0xcf00)| 0
53251 (0xd003)| 0
53252 (0xd004)| 0
53253 (0xd005)| 0
```

Version 3+ of the fixbuf container contains the [ipfix2json](https://tools.netsa.cert.org/fixbuf/ipfix2json.html) tool, which can be used to print contents of an IPFIX file as json text.  For example, using the same IPFIX input file from above `flows.yaf-20231026175944-00000.yaf`:

```bash
docker run --rm -it -v $PWD/test:/tmp \
  cmusei/fixbuf:3 \
  ipfix2json \
  --in /tmp/flows.yaf-20231026175944-00000.yaf \
  --out -
```
```
{"template_record:0xd005()":["certToolId","observationTimeSeconds"]}
{"template_record:0xc003()":["tcpSequenceNumber","initialTCPFlags","unionTCPFlags"]}
{"template_record:0xce07()":["dnsTXTData"]}
{"template_record:0xc009()":["mptcpInitialDataSequenceNumber","mptcpReceiverToken","mptcpMaximumSegmentSize","mptcpAddressId","mptcpFlags"]}
{"template_record:0xca00()":["basicList","basicList","basicList","basicList","basicList","basicList","basicList"]}
{"template_record:0xc400()":["tftpFilename","tftpMode"]}
{"template_record:0xce02()":["sourceIPv6Address"]}
{"template_record:0xce0d()":["mysqlCommandText","mysqlCommandCode","paddingOctets"]}
{"template_record:0xc004()":["sourceMacAddress","destinationMacAddress"]}
{"template_record:0xce08()":["dnsSRVTarget","dnsSRVPriority","dnsSRVWeight","dnsSRVPort","paddingOctets"]}
{"template_record:0xc015()":["dataByteCount","averageInterarrivalTime","standardDeviationInterarrivalTime","tcpUrgTotalCount","smallPacketCount","nonEmptyPacketCount","largePacketCount","firstNonEmptyPacketSize","maxPacketSize","standardDeviationPayloadLength","firstEightNonEmptyPacketDirections","paddingOctets","reverseDataByteCount","reverseAverageInterarrivalTime","reverseStandardDeviationInterarrivalTime","reverseTcpUrgTotalCount","reverseSmallPacketCount","reverseNonEmptyPacketCount","reverseLargePacketCount","reverseFirstNonEmptyPacketSize","reverseMaxPacketSize","reverseStandardDeviationPayloadLength","paddingOctets"]}
snip...  
```
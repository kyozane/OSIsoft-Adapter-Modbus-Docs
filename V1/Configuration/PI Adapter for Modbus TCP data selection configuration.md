---
uid: OSIsoftAdapterForModbusTCPDataSelectionConfiguration
---

# OSIsoft Adapter for Modbus TCP data selection configuration

In addition to the data source configuration, you need to provide a data selection configuration to specify the data you want the adapter to collect from the data sources.

## Configure Modbus TCP data selection

You cannot modify Modbus TCP data selection configurations manually. You must use the REST endpoints to add or edit the configuration.

Complete the following procedure to configure the Modbus TCP data selection:

1. Using any text editor, create a file that contains a Modbus TCP data selection in the JSON format.
    - For content structure, see [Modbus TCP data selection examples](#modbus-tcp-data-selection-examples).
    - For a table of all available parameters, see [Modbus TCP data selection parameters](#modbus-tcp-data-selection-parameters).
2. Save the file. For example, `DataSelection.config.json`.
3. Use any of the [Configuration tools](xref:ConfigurationTools) capable of making HTTP requests to execute either a `POST` or `PUT` command to their appropriate endpoint:

    **Note:** The following examples use Modbus1 as the adapter component name. For more information on how to add a component, see [System components configuration](xref:SystemComponentsConfiguration).
  
    `5590` is the default port number. If you selected a different port number, replace it with that value.

    - **POST** endpoint: `http://localhost:5590/api/v1/configuration/<componentId>/DataSelection/`

      Example using `curl`:

      **Note:** Run this command from the same directory where the file is located.
    
      ```bash
      curl -d "@DataSelection.config.json" -H "Content-Type: application/json" -X POST "http://localhost:5590/api/v1/configuration/Modbus1/DataSelection"
      ```

    - **PUT** endpoint: `http://localhost:5590/api/v1/configuration/<componentId>/DataSelection/<Id>`

      Example using `curl`:
    
      **Note:** Run this command from the same directory where the file is located.
      
        ```bash
        curl -d "@DataSelection.config.json" -H "Content-Type: application/json" -X PUT "http://localhost:5590/api/v1/configuration/Modbus1/DataSelection/DataItem1"
        ```

## Modbus TCP data selection schema

The full schema definition for the Modbus data selection configuration is in the `Modbus_DataSelection_schema.json` file located in one of the folders listed below:

Windows: `%ProgramFiles%\OSIsoft\Adapters\Modbus\Schemas`

Linux: `/opt/OSIsoft/Adapters/Modbus/Schemas`

## Modbus TCP data selection parameters

The following parameters are available to configure a Modbus TCP data selection:

| Parameter | Required | Type | Description |
|-----------|----------|------|-------------|
| **DeviceId** | Required | `string` | Specifies the DataSource device that this data selection item will be read from. The value must match one of the `<Id>` values specified in the DataSource [Devices](xref:OSIsoftAdapterForModbusTCPDataSourceConfiguration#devices) configuration.
| **Selected** | Optional | `boolean` | Selects or clears a measurement. To select an item, set to `true`. To remove an item, leave the field empty or set to false.  If not configured, the default value is `true`.|
| **Name** | Optional | `string` | The optional friendly name of the data item collected from the data source. If not configured, the default value will be the stream ID. |
| **UnitId** | Required | number | Modbus TCP slave device unit ID. This must be a value between 0 and 247, inclusively. |
| **RegisterType** | Required | number or `string` | Modbus TCP register type. Supported types are `Coil`, `Discrete`, `Input16`, `Input32`, `Holding16` and `Holding32`.<br><br>`Input16` and `Holding16` are used to read registers that have a size of 16 bits. For registers that have a size of 32 bits, use the `Input32` and `Holding32` register types. To represent the types, you can type in the register type ID or the exact name: <br><br>`1` or `Coil` (Read Coil Status)<br>`2` or `Discrete` (Read Discrete Input Status)<br>`3` or `Holding16` (Read 16-bit Holding Registers)<br>`4` or `Holding32` (Read 32-bit Holding Registers)<br>`6` or `Input16` (Read 16-bit Input Registers)<br>`7` or `Input32` (Read 32-bit Input Registers)<br><br>For more information, see [Register types](#register-types).|
| **RegisterOffset** | Required | number | The 0 relative offset to the starting register for this measurement. For example, if your Holding registers start at base register 40001, the offset to this register is 0. For 40002, the offset to this register is 1.|
| **DataTypeCode** | Required | number | An integer representing the data type that the adapter will read starting at the register specified by the offset. Supported data types are:<br>`1` = `Boolean`<br>`10` = `Int16`<br>`20` = `UInt16`<br>`30` = `Int32`<br>`31` = `Int32ByteSwap`<br>`100` = `Float32`<br>`101` = `Float32ByteSwap`<br>`110` = `Float64`<br>`111` = `Float64ByteSwap`<br>`1001` - `1250` = `String` <br>`2001` - `2250` = `StringByteSwap` |
| **ScheduleId** | Required | `string` | The id of an existing schedule for reading values.|
| **BitMap** | Optional | `string` | The bitmap is used to extract and reorder bits from a word register. The format of the bitmap is uuvvwwxxyyzz, where uu, vv, ww, yy, and zz each refer to a single bit. A leading zero is required if the referenced bit is less than 10. The low-order bit is 01 and high-order bit is either 16 or 32. Up to 16 bits can be referenced for a 16-bit word (data types 10 and 20) and up to 32 bits can be referenced for a 32-bit word (data type 30 and 31). The bitmap 0307120802 maps the second bit of the original word to the first bit of the new word, the eighth bit to the second bit, the twelfth bit to the third bit, and so on. The high-order bits of the new word are padded with zeros if they are not specified. |
| **ConversionFactor** | Optional | number | Use this numerical value to scale the raw response received from the Modbus TCP device. If you specify ConversionFactor, regardless of the specified data type, the value is promoted to a float32 (single) when stored. [Result = (Value / Conversion Factor)] |
| **ConversionOffset** | Optional | number | Use this numerical value to apply an offset to the response received from the Modbus TCP device. If you specify ConversionOffset, regardless of the specified data type, the value is promoted to a float32 (single) when stored.  [Result = (Value - Conversion Offset)] |
| **DataFilterId** | Optional | `string` | If you want data filtering for this data selection item, specify the name of an existing data filter. If you do not specify the value or set it `null`, all values read are output without being filtered. |
| **StreamID** | Optional | `string` | The custom stream ID that will be used to create the streams. If you do not specify the StreamID, the adapter generates a default stream ID based on the measurement configuration. A properly configured custom stream ID follows these rules:<br><br>Is not case-sensitive.<br>Can contain spaces.<br>Cannot start with two underscores ("__").<br>Can contain a maximum of 100 characters.<br>Cannot use the following characters:<br> `/` `:` `?` `#` `[` `]` `@` `!` `$` `&` `'` `(` `)` `\` `*` `+` `,` `;` `=` `%` `<` `>` `|`<br>Cannot start or end with a period.<br>Cannot contain consecutive periods.<br>Cannot consist of only periods. If not specified default StreamId follows the format of `<DeviceId`>.`<UnitId`>.`<RegisterType`>.`<RegisterOffset`>.

Each JSON object in the file represents a measurement. You can modify the fields in each object to configure the measurement parameters. To add more measurements, you need to create more JSON objects with properly completed fields.

### Register types

Register types are used to configure measurements in Modbus TCP data selection. The adapter supports six register types, corresponding to four function codes (1-4). Since one function code can return two types of registers, 16-bit or 32-bit depending on the device, either the register type or the register type code is required when configuring the data selection for the adapter.

The following table lists all the register types supported in the adapter.

| Register Type | Register Type Code | Description | Function Code |
|---------------|-------------------|-------------|---------------|
| `Coil`        | `1`               |Read `Coil` Status| `1` |
| `Discrete`        | `2`               |Read `Discrete` Input Status | `2` |
| `Holding16`        | `3`               |Read 16-bit Holding Registers | `3` |
| `Holding32`        | `4`               |Read 32-bit Holding Registers | `3` |
| `Input16`        | `6`               |Read 16-bit Input Registers |`4`|
| `Input32`        | `7`               |Read 32-bit Input Registers |`4`|

When reading from function codes `1` and `2`, the adapter expects these to be returned as single bits. For function codes `3` and `4`, the adapter expects 16 bits to be returned from devices that contain 16-bit registers and 32 bits to be returned from devices that contain 32-bit registers.

### DataTypeCode

#### DataTypeCode 1

| Name          | Value Type | Register Type | Meaning | Output Type | Interface data type code |
|---------------|------------|---------------|---------|-------------|--------------------------|
| BoolModbus    | `Bool`       | `Coil Discrete` | 0=Modbus0 / 1=Modbus1| `bool`        | NA                      |

#### DataTypeCode 10

| Name          | Value Type | Register Type | Meaning | Output Type | Interface data type code |
|---------------|------------|---------------|---------|-------------|--------------------------|
| Int16    | `Int16`      | `Bool`/`16-bit` |Read 1 Modbus register and interpret as a 16-bit integer. Bytes [BA] read from the PLC are stored as [AB]. | `Int16` | 1|

#### DataTypeCode 20

| Name          | Value Type | Register Type | Meaning | Output Type | Interface data type code |
|---------------|------------|---------------|---------|-------------|--------------------------|
| UInt16    | `UInt16`      | `Bool`/`16-bit` |Read 1 Modbus register and interpret as an unsigned 16-bit integer. Bytes [BA] read from the PLC are stored as [AB]. | `Int32` | 11|

#### DataTypeCode 30

| Name          | Value Type | Register Type | Meaning | Output Type | Interface data type code |
|---------------|------------|---------------|---------|-------------|--------------------------|
| Int32    | `Int32`      | `16-`/`32-bit` |Read 32-bits from the PLC and interpret as a 32-bit integer.  Bytes [DCBA] read from the PLC are stored as [ABCD]. | `Int32` | 7|

#### DataTypeCode 31

| Name          | Value Type | Register Type | Meaning | Output Type | Interface data type code |
|---------------|------------|---------------|---------|-------------|--------------------------|
| Int32ByteSwap    | `Int32`      | `16-`/`32-bit` |Read 32-bits from the PLC and interpret as a 32-bit integer.  Bytes [BADC] read from the PLC are stored as [ABCD]. | `Int32` | 7|

#### DataTypeCode 100

| Name          | Value Type | Register Type | Meaning | Output Type | Interface data type code |
|---------------|------------|---------------|---------|-------------|--------------------------|
| Float32    | `Float32`      | `16-`/`32-bit` |Read 32-bits from the PLC and interpret as a 32-bit float.  Bytes [DCBA] read from the PLC are stored as [ABCD]. | `Float32` | 6|

#### DataTypeCode 101

| Name          | Value Type | Register Type | Meaning | Output Type | Interface data type code |
|---------------|------------|---------------|---------|-------------|--------------------------|
| Float32ByteSwap    | `Float32`      | `16-`/`32-bit` |Read 32-bits from the PLC and interpret as a 32-bit float.  Bytes [BADC] read from the PLC are stored as [ABCD]. | `Float32` | 6|

#### DataTypeCode 110

| Name          | Value Type | Register Type | Meaning | Output Type | Interface data type code |
|---------------|------------|---------------|---------|-------------|--------------------------|
| Float64    | `Float64`      | `16-`/`32-bit` |Read 64-bits from the PLC and interpret as a 64-bit float.  Bytes [HGFEDCBA] read from the device are stored as [ABCDEFGH]. | `Float64` | 6 |

#### DataTypeCode 111

| Name          | Value Type | Register Type | Meaning | Output Type | Interface data type code |
|---------------|------------|---------------|---------|-------------|--------------------------|
| Float64ByteSwap    | `Float64`      | `16-`/`32-bit`|Read 64-bits from the PLC and interpret as a 64-bit float. Bytes [BADCFEHG] read from the device are stored as [ABCDEFGH]. | `Float64` | 6|

#### DataTypeCode 1001-1250

| Name          | Value Type | Register Type | Meaning | Output Type | Interface data type code |
|---------------|------------|---------------|---------|-------------|--------------------------|
| String    | `String`      | `16-`/`32-bit` | 1001 will a 1-character string, 1002 will read a 2-character string, 1003 will read a 3-character string and so on. Bytes [AB] are interpreted as "AB". | `String` | 101 to 199|

#### DataTypeCode 2001-2250

| Name          | Value Type | Register Type | Meaning | Output Type | Interface data type code |
|---------------|------------|---------------|---------|-------------|--------------------------|
| StringByteSwap    | `String`      | `16-`/`32-bit` | 2001 will a 1-character string, 2002 will read a 2-character string, 2003 will read a 3-character string and so on. Bytes [BA] are interpreted as "AB". | `String` | 101 to 199|

## Modbus TCP data selection examples

The following are examples of valid Modbus TCP data selection configurations.

**Minimum data selection configuration:**

```json
[
    {
        "DeviceId" : "Device1",
        "UnitId": 1,
        "RegisterType": "Holding16",
        "RegisterOffset": 122,
        "DataTypeCode": 20,
        "ScheduleId": "Schedule1"
    }
]
```

**Maximum data selection configuration:**

```json
[
    {
        "StreamId": "DataItem1",
        "DeviceId" : "Device1",
        "Selected": true,
        "Name": "MyDataItem",
        "UnitId": 1,
        "RegisterType": "Holding16",
        "RegisterOffset": 123,
        "DataTypeCode": 20,
        "ScheduleId": "Schedule1",
        "StreamId": "stream.1",
        "BitMap": "020301",
        "ConversionFactor": 12.3,
        "ConversionOffset": 14.5,
        "DataFilterId" : "DataFilter1"
    }
]
```

## REST URLs

| Relative URL | HTTP verb | Action |
| ------------ | --------- | ------ |
| api/v1/configuration/_ComponentId_/DataSelection  | `GET` | Retrieves the Modbus TCP data selection configuration |
| api/v1/configuration/_ComponentId_/DataSelection  | `PUT` | Configures or updates the Modbus TCP data selection configuration |
| api/v1/configuration/_ComponentId_/DataSelection | `DELETE` | Deletes the Modbus TCP data selection configuration |
| api/v1/configuration/_ComponentId_/DataSelection | `PATCH` | Allows partial updating of configured data selection items. <br>**Note:** The request must be an array containing one or more data selection items. Each data selection item in the array must include its `StreamId` |
| api/v1/configuration/_ComponentId_/DataSelection/_StreamId_ | `PUT` | Updates or creates a new data selection with the specified *StreamId* |
| api/v1/configuration/_ComponentId_/DataSelection/_StreamId_ | `DELETE` | Deletes a specific data selection item of the Modbus TCP data selection configuration |

**Note:** Replace `ComponentId` with the Id of your Modbus TCP component. For example, `Modbus1`.

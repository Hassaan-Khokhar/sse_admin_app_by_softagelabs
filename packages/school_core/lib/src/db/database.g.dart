// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SchoolsTable extends Schools with TableInfo<$SchoolsTable, School> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchoolsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    name,
    address,
    phone,
    logoUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schools';
  @override
  VerificationContext validateIntegrity(
    Insertable<School> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  School map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return School(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
    );
  }

  @override
  $SchoolsTable createAlias(String alias) {
    return $SchoolsTable(attachedDatabase, alias);
  }
}

class School extends DataClass implements Insertable<School> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String name;
  final String? address;
  final String? phone;
  final String? logoUrl;
  const School({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.name,
    this.address,
    this.phone,
    this.logoUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    return map;
  }

  SchoolsCompanion toCompanion(bool nullToAbsent) {
    return SchoolsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
    );
  }

  factory School.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return School(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      phone: serializer.fromJson<String?>(json['phone']),
      logoUrl: serializer.fromJson<String?>(json['logo_url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'phone': serializer.toJson<String?>(phone),
      'logo_url': serializer.toJson<String?>(logoUrl),
    };
  }

  School copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? name,
    Value<String?> address = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> logoUrl = const Value.absent(),
  }) => School(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    name: name ?? this.name,
    address: address.present ? address.value : this.address,
    phone: phone.present ? phone.value : this.phone,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
  );
  School copyWithCompanion(SchoolsCompanion data) {
    return School(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      phone: data.phone.present ? data.phone.value : this.phone,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('School(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('logoUrl: $logoUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    name,
    address,
    phone,
    logoUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is School &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.phone == this.phone &&
          other.logoUrl == this.logoUrl);
}

class SchoolsCompanion extends UpdateCompanion<School> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> name;
  final Value<String?> address;
  final Value<String?> phone;
  final Value<String?> logoUrl;
  final Value<int> rowid;
  const SchoolsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SchoolsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String name,
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name);
  static Insertable<School> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? phone,
    Expression<String>? logoUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SchoolsCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? name,
    Value<String?>? address,
    Value<String?>? phone,
    Value<String?>? logoUrl,
    Value<int>? rowid,
  }) {
    return SchoolsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      logoUrl: logoUrl ?? this.logoUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchoolsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AcademicYearsTable extends AcademicYears
    with TableInfo<$AcademicYearsTable, AcademicYear> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AcademicYearsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCurrentMeta = const VerificationMeta(
    'isCurrent',
  );
  @override
  late final GeneratedColumn<bool> isCurrent = GeneratedColumn<bool>(
    'is_current',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_current" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    name,
    startDate,
    endDate,
    isCurrent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'academic_years';
  @override
  VerificationContext validateIntegrity(
    Insertable<AcademicYear> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('is_current')) {
      context.handle(
        _isCurrentMeta,
        isCurrent.isAcceptableOrUnknown(data['is_current']!, _isCurrentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AcademicYear map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AcademicYear(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_date'],
      )!,
      isCurrent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_current'],
      )!,
    );
  }

  @override
  $AcademicYearsTable createAlias(String alias) {
    return $AcademicYearsTable(attachedDatabase, alias);
  }
}

class AcademicYear extends DataClass implements Insertable<AcademicYear> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;

  /// e.g. `'2026-2027'`.
  final String name;

  /// DATE as `YYYY-MM-DD`.
  final String startDate;
  final String endDate;
  final bool isCurrent;
  const AcademicYear({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['name'] = Variable<String>(name);
    map['start_date'] = Variable<String>(startDate);
    map['end_date'] = Variable<String>(endDate);
    map['is_current'] = Variable<bool>(isCurrent);
    return map;
  }

  AcademicYearsCompanion toCompanion(bool nullToAbsent) {
    return AcademicYearsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      name: Value(name),
      startDate: Value(startDate),
      endDate: Value(endDate),
      isCurrent: Value(isCurrent),
    );
  }

  factory AcademicYear.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AcademicYear(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<String>(json['start_date']),
      endDate: serializer.fromJson<String>(json['end_date']),
      isCurrent: serializer.fromJson<bool>(json['is_current']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'name': serializer.toJson<String>(name),
      'start_date': serializer.toJson<String>(startDate),
      'end_date': serializer.toJson<String>(endDate),
      'is_current': serializer.toJson<bool>(isCurrent),
    };
  }

  AcademicYear copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? name,
    String? startDate,
    String? endDate,
    bool? isCurrent,
  }) => AcademicYear(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    name: name ?? this.name,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    isCurrent: isCurrent ?? this.isCurrent,
  );
  AcademicYear copyWithCompanion(AcademicYearsCompanion data) {
    return AcademicYear(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      name: data.name.present ? data.name.value : this.name,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      isCurrent: data.isCurrent.present ? data.isCurrent.value : this.isCurrent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AcademicYear(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isCurrent: $isCurrent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    name,
    startDate,
    endDate,
    isCurrent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AcademicYear &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.isCurrent == this.isCurrent);
}

class AcademicYearsCompanion extends UpdateCompanion<AcademicYear> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> name;
  final Value<String> startDate;
  final Value<String> endDate;
  final Value<bool> isCurrent;
  final Value<int> rowid;
  const AcademicYearsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isCurrent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AcademicYearsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String name,
    required String startDate,
    required String endDate,
    this.isCurrent = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       name = Value(name),
       startDate = Value(startDate),
       endDate = Value(endDate);
  static Insertable<AcademicYear> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? name,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<bool>? isCurrent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (isCurrent != null) 'is_current': isCurrent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AcademicYearsCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? name,
    Value<String>? startDate,
    Value<String>? endDate,
    Value<bool>? isCurrent,
    Value<int>? rowid,
  }) {
    return AcademicYearsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrent: isCurrent ?? this.isCurrent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (isCurrent.present) {
      map['is_current'] = Variable<bool>(isCurrent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AcademicYearsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isCurrent: $isCurrent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClassesTable extends Classes with TableInfo<$ClassesTable, SchoolClass> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _academicYearIdMeta = const VerificationMeta(
    'academicYearId',
  );
  @override
  late final GeneratedColumn<String> academicYearId = GeneratedColumn<String>(
    'academic_year_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<int> grade = GeneratedColumn<int>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sectionMeta = const VerificationMeta(
    'section',
  );
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
    'section',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classTeacherIdMeta = const VerificationMeta(
    'classTeacherId',
  );
  @override
  late final GeneratedColumn<String> classTeacherId = GeneratedColumn<String>(
    'class_teacher_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roomMeta = const VerificationMeta('room');
  @override
  late final GeneratedColumn<String> room = GeneratedColumn<String>(
    'room',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    academicYearId,
    grade,
    section,
    displayName,
    classTeacherId,
    room,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'classes';
  @override
  VerificationContext validateIntegrity(
    Insertable<SchoolClass> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('academic_year_id')) {
      context.handle(
        _academicYearIdMeta,
        academicYearId.isAcceptableOrUnknown(
          data['academic_year_id']!,
          _academicYearIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_academicYearIdMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('section')) {
      context.handle(
        _sectionMeta,
        section.isAcceptableOrUnknown(data['section']!, _sectionMeta),
      );
    } else if (isInserting) {
      context.missing(_sectionMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('class_teacher_id')) {
      context.handle(
        _classTeacherIdMeta,
        classTeacherId.isAcceptableOrUnknown(
          data['class_teacher_id']!,
          _classTeacherIdMeta,
        ),
      );
    }
    if (data.containsKey('room')) {
      context.handle(
        _roomMeta,
        room.isAcceptableOrUnknown(data['room']!, _roomMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {schoolId, academicYearId, grade, section},
  ];
  @override
  SchoolClass map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SchoolClass(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      academicYearId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}academic_year_id'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grade'],
      )!,
      section: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      classTeacherId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_teacher_id'],
      ),
      room: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room'],
      ),
    );
  }

  @override
  $ClassesTable createAlias(String alias) {
    return $ClassesTable(attachedDatabase, alias);
  }
}

class SchoolClass extends DataClass implements Insertable<SchoolClass> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String academicYearId;

  /// 1..12.
  final int grade;

  /// `'A'`, `'B'`.
  final String section;

  /// `'9-A'` — denormalised so list screens do not join to render a label.
  final String displayName;
  final String? classTeacherId;
  final String? room;
  const SchoolClass({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.academicYearId,
    required this.grade,
    required this.section,
    required this.displayName,
    this.classTeacherId,
    this.room,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['academic_year_id'] = Variable<String>(academicYearId);
    map['grade'] = Variable<int>(grade);
    map['section'] = Variable<String>(section);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || classTeacherId != null) {
      map['class_teacher_id'] = Variable<String>(classTeacherId);
    }
    if (!nullToAbsent || room != null) {
      map['room'] = Variable<String>(room);
    }
    return map;
  }

  ClassesCompanion toCompanion(bool nullToAbsent) {
    return ClassesCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      academicYearId: Value(academicYearId),
      grade: Value(grade),
      section: Value(section),
      displayName: Value(displayName),
      classTeacherId: classTeacherId == null && nullToAbsent
          ? const Value.absent()
          : Value(classTeacherId),
      room: room == null && nullToAbsent ? const Value.absent() : Value(room),
    );
  }

  factory SchoolClass.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SchoolClass(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      academicYearId: serializer.fromJson<String>(json['academic_year_id']),
      grade: serializer.fromJson<int>(json['grade']),
      section: serializer.fromJson<String>(json['section']),
      displayName: serializer.fromJson<String>(json['display_name']),
      classTeacherId: serializer.fromJson<String?>(json['class_teacher_id']),
      room: serializer.fromJson<String?>(json['room']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'academic_year_id': serializer.toJson<String>(academicYearId),
      'grade': serializer.toJson<int>(grade),
      'section': serializer.toJson<String>(section),
      'display_name': serializer.toJson<String>(displayName),
      'class_teacher_id': serializer.toJson<String?>(classTeacherId),
      'room': serializer.toJson<String?>(room),
    };
  }

  SchoolClass copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? academicYearId,
    int? grade,
    String? section,
    String? displayName,
    Value<String?> classTeacherId = const Value.absent(),
    Value<String?> room = const Value.absent(),
  }) => SchoolClass(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    academicYearId: academicYearId ?? this.academicYearId,
    grade: grade ?? this.grade,
    section: section ?? this.section,
    displayName: displayName ?? this.displayName,
    classTeacherId: classTeacherId.present
        ? classTeacherId.value
        : this.classTeacherId,
    room: room.present ? room.value : this.room,
  );
  SchoolClass copyWithCompanion(ClassesCompanion data) {
    return SchoolClass(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      academicYearId: data.academicYearId.present
          ? data.academicYearId.value
          : this.academicYearId,
      grade: data.grade.present ? data.grade.value : this.grade,
      section: data.section.present ? data.section.value : this.section,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      classTeacherId: data.classTeacherId.present
          ? data.classTeacherId.value
          : this.classTeacherId,
      room: data.room.present ? data.room.value : this.room,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SchoolClass(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('academicYearId: $academicYearId, ')
          ..write('grade: $grade, ')
          ..write('section: $section, ')
          ..write('displayName: $displayName, ')
          ..write('classTeacherId: $classTeacherId, ')
          ..write('room: $room')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    academicYearId,
    grade,
    section,
    displayName,
    classTeacherId,
    room,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SchoolClass &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.academicYearId == this.academicYearId &&
          other.grade == this.grade &&
          other.section == this.section &&
          other.displayName == this.displayName &&
          other.classTeacherId == this.classTeacherId &&
          other.room == this.room);
}

class ClassesCompanion extends UpdateCompanion<SchoolClass> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> academicYearId;
  final Value<int> grade;
  final Value<String> section;
  final Value<String> displayName;
  final Value<String?> classTeacherId;
  final Value<String?> room;
  final Value<int> rowid;
  const ClassesCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.academicYearId = const Value.absent(),
    this.grade = const Value.absent(),
    this.section = const Value.absent(),
    this.displayName = const Value.absent(),
    this.classTeacherId = const Value.absent(),
    this.room = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClassesCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String academicYearId,
    required int grade,
    required String section,
    required String displayName,
    this.classTeacherId = const Value.absent(),
    this.room = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       academicYearId = Value(academicYearId),
       grade = Value(grade),
       section = Value(section),
       displayName = Value(displayName);
  static Insertable<SchoolClass> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? academicYearId,
    Expression<int>? grade,
    Expression<String>? section,
    Expression<String>? displayName,
    Expression<String>? classTeacherId,
    Expression<String>? room,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (academicYearId != null) 'academic_year_id': academicYearId,
      if (grade != null) 'grade': grade,
      if (section != null) 'section': section,
      if (displayName != null) 'display_name': displayName,
      if (classTeacherId != null) 'class_teacher_id': classTeacherId,
      if (room != null) 'room': room,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClassesCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? academicYearId,
    Value<int>? grade,
    Value<String>? section,
    Value<String>? displayName,
    Value<String?>? classTeacherId,
    Value<String?>? room,
    Value<int>? rowid,
  }) {
    return ClassesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      academicYearId: academicYearId ?? this.academicYearId,
      grade: grade ?? this.grade,
      section: section ?? this.section,
      displayName: displayName ?? this.displayName,
      classTeacherId: classTeacherId ?? this.classTeacherId,
      room: room ?? this.room,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (academicYearId.present) {
      map['academic_year_id'] = Variable<String>(academicYearId.value);
    }
    if (grade.present) {
      map['grade'] = Variable<int>(grade.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (classTeacherId.present) {
      map['class_teacher_id'] = Variable<String>(classTeacherId.value);
    }
    if (room.present) {
      map['room'] = Variable<String>(room.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('academicYearId: $academicYearId, ')
          ..write('grade: $grade, ')
          ..write('section: $section, ')
          ..write('displayName: $displayName, ')
          ..write('classTeacherId: $classTeacherId, ')
          ..write('room: $room, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _teacherIdMeta = const VerificationMeta(
    'teacherId',
  );
  @override
  late final GeneratedColumn<String> teacherId = GeneratedColumn<String>(
    'teacher_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalMarksMeta = const VerificationMeta(
    'totalMarks',
  );
  @override
  late final GeneratedColumn<int> totalMarks = GeneratedColumn<int>(
    'total_marks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(100),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    classId,
    name,
    code,
    teacherId,
    totalMarks,
    sortOrder,
    icon,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subject> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    }
    if (data.containsKey('teacher_id')) {
      context.handle(
        _teacherIdMeta,
        teacherId.isAcceptableOrUnknown(data['teacher_id']!, _teacherIdMeta),
      );
    }
    if (data.containsKey('total_marks')) {
      context.handle(
        _totalMarksMeta,
        totalMarks.isAcceptableOrUnknown(data['total_marks']!, _totalMarksMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      ),
      teacherId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}teacher_id'],
      ),
      totalMarks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_marks'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String classId;

  /// `'Mathematics'`.
  final String name;

  /// `'MATH'`.
  final String? code;
  final String? teacherId;
  final int totalMarks;
  final int sortOrder;

  /// Icon key for the student app's grid tile.
  final String? icon;
  const Subject({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.classId,
    required this.name,
    this.code,
    this.teacherId,
    required this.totalMarks,
    required this.sortOrder,
    this.icon,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['class_id'] = Variable<String>(classId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || teacherId != null) {
      map['teacher_id'] = Variable<String>(teacherId);
    }
    map['total_marks'] = Variable<int>(totalMarks);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      classId: Value(classId),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      teacherId: teacherId == null && nullToAbsent
          ? const Value.absent()
          : Value(teacherId),
      totalMarks: Value(totalMarks),
      sortOrder: Value(sortOrder),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
    );
  }

  factory Subject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      classId: serializer.fromJson<String>(json['class_id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      teacherId: serializer.fromJson<String?>(json['teacher_id']),
      totalMarks: serializer.fromJson<int>(json['total_marks']),
      sortOrder: serializer.fromJson<int>(json['sort_order']),
      icon: serializer.fromJson<String?>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'class_id': serializer.toJson<String>(classId),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'teacher_id': serializer.toJson<String?>(teacherId),
      'total_marks': serializer.toJson<int>(totalMarks),
      'sort_order': serializer.toJson<int>(sortOrder),
      'icon': serializer.toJson<String?>(icon),
    };
  }

  Subject copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? classId,
    String? name,
    Value<String?> code = const Value.absent(),
    Value<String?> teacherId = const Value.absent(),
    int? totalMarks,
    int? sortOrder,
    Value<String?> icon = const Value.absent(),
  }) => Subject(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    classId: classId ?? this.classId,
    name: name ?? this.name,
    code: code.present ? code.value : this.code,
    teacherId: teacherId.present ? teacherId.value : this.teacherId,
    totalMarks: totalMarks ?? this.totalMarks,
    sortOrder: sortOrder ?? this.sortOrder,
    icon: icon.present ? icon.value : this.icon,
  );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      classId: data.classId.present ? data.classId.value : this.classId,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      teacherId: data.teacherId.present ? data.teacherId.value : this.teacherId,
      totalMarks: data.totalMarks.present
          ? data.totalMarks.value
          : this.totalMarks,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('teacherId: $teacherId, ')
          ..write('totalMarks: $totalMarks, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    classId,
    name,
    code,
    teacherId,
    totalMarks,
    sortOrder,
    icon,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.classId == this.classId &&
          other.name == this.name &&
          other.code == this.code &&
          other.teacherId == this.teacherId &&
          other.totalMarks == this.totalMarks &&
          other.sortOrder == this.sortOrder &&
          other.icon == this.icon);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> classId;
  final Value<String> name;
  final Value<String?> code;
  final Value<String?> teacherId;
  final Value<int> totalMarks;
  final Value<int> sortOrder;
  final Value<String?> icon;
  final Value<int> rowid;
  const SubjectsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.classId = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.totalMarks = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubjectsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String classId,
    required String name,
    this.code = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.totalMarks = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       classId = Value(classId),
       name = Value(name);
  static Insertable<Subject> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? classId,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? teacherId,
    Expression<int>? totalMarks,
    Expression<int>? sortOrder,
    Expression<String>? icon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (classId != null) 'class_id': classId,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (teacherId != null) 'teacher_id': teacherId,
      if (totalMarks != null) 'total_marks': totalMarks,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (icon != null) 'icon': icon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubjectsCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? classId,
    Value<String>? name,
    Value<String?>? code,
    Value<String?>? teacherId,
    Value<int>? totalMarks,
    Value<int>? sortOrder,
    Value<String?>? icon,
    Value<int>? rowid,
  }) {
    return SubjectsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      classId: classId ?? this.classId,
      name: name ?? this.name,
      code: code ?? this.code,
      teacherId: teacherId ?? this.teacherId,
      totalMarks: totalMarks ?? this.totalMarks,
      sortOrder: sortOrder ?? this.sortOrder,
      icon: icon ?? this.icon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (teacherId.present) {
      map['teacher_id'] = Variable<String>(teacherId.value);
    }
    if (totalMarks.present) {
      map['total_marks'] = Variable<int>(totalMarks.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('teacherId: $teacherId, ')
          ..write('totalMarks: $totalMarks, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('icon: $icon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppUsersTable extends AppUsers with TableInfo<$AppUsersTable, AppUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastLoginAtMeta = const VerificationMeta(
    'lastLoginAt',
  );
  @override
  late final GeneratedColumn<String> lastLoginAt = GeneratedColumn<String>(
    'last_login_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    role,
    email,
    phone,
    fullName,
    isActive,
    lastLoginAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('last_login_at')) {
      context.handle(
        _lastLoginAtMeta,
        lastLoginAt.isAcceptableOrUnknown(
          data['last_login_at']!,
          _lastLoginAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppUser(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      lastLoginAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_login_at'],
      ),
    );
  }

  @override
  $AppUsersTable createAlias(String alias) {
    return $AppUsersTable(attachedDatabase, alias);
  }
}

class AppUser extends DataClass implements Insertable<AppUser> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;

  /// `UserRole.wire` — `'super_admin'` | `'teacher'` | `'student'`.
  final String role;
  final String? email;
  final String? phone;
  final String fullName;

  /// Flipped to false when a student is withdrawn.
  ///
  /// The student app checks this on every sync and logs out if false. That is
  /// the closing beat of the demo video (CLAUDE.md §12).
  final bool isActive;
  final String? lastLoginAt;
  const AppUser({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.role,
    this.email,
    this.phone,
    required this.fullName,
    required this.isActive,
    this.lastLoginAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['full_name'] = Variable<String>(fullName);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastLoginAt != null) {
      map['last_login_at'] = Variable<String>(lastLoginAt);
    }
    return map;
  }

  AppUsersCompanion toCompanion(bool nullToAbsent) {
    return AppUsersCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      role: Value(role),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      fullName: Value(fullName),
      isActive: Value(isActive),
      lastLoginAt: lastLoginAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLoginAt),
    );
  }

  factory AppUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUser(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      role: serializer.fromJson<String>(json['role']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      fullName: serializer.fromJson<String>(json['full_name']),
      isActive: serializer.fromJson<bool>(json['is_active']),
      lastLoginAt: serializer.fromJson<String?>(json['last_login_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'role': serializer.toJson<String>(role),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'full_name': serializer.toJson<String>(fullName),
      'is_active': serializer.toJson<bool>(isActive),
      'last_login_at': serializer.toJson<String?>(lastLoginAt),
    };
  }

  AppUser copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? role,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    String? fullName,
    bool? isActive,
    Value<String?> lastLoginAt = const Value.absent(),
  }) => AppUser(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    role: role ?? this.role,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    fullName: fullName ?? this.fullName,
    isActive: isActive ?? this.isActive,
    lastLoginAt: lastLoginAt.present ? lastLoginAt.value : this.lastLoginAt,
  );
  AppUser copyWithCompanion(AppUsersCompanion data) {
    return AppUser(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      role: data.role.present ? data.role.value : this.role,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastLoginAt: data.lastLoginAt.present
          ? data.lastLoginAt.value
          : this.lastLoginAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppUser(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('role: $role, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('fullName: $fullName, ')
          ..write('isActive: $isActive, ')
          ..write('lastLoginAt: $lastLoginAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    role,
    email,
    phone,
    fullName,
    isActive,
    lastLoginAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.role == this.role &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.fullName == this.fullName &&
          other.isActive == this.isActive &&
          other.lastLoginAt == this.lastLoginAt);
}

class AppUsersCompanion extends UpdateCompanion<AppUser> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> role;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String> fullName;
  final Value<bool> isActive;
  final Value<String?> lastLoginAt;
  final Value<int> rowid;
  const AppUsersCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.role = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.fullName = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastLoginAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppUsersCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String role,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    required String fullName,
    this.isActive = const Value.absent(),
    this.lastLoginAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       role = Value(role),
       fullName = Value(fullName);
  static Insertable<AppUser> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? role,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? fullName,
    Expression<bool>? isActive,
    Expression<String>? lastLoginAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (role != null) 'role': role,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (fullName != null) 'full_name': fullName,
      if (isActive != null) 'is_active': isActive,
      if (lastLoginAt != null) 'last_login_at': lastLoginAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppUsersCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? role,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String>? fullName,
    Value<bool>? isActive,
    Value<String?>? lastLoginAt,
    Value<int>? rowid,
  }) {
    return AppUsersCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      isActive: isActive ?? this.isActive,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastLoginAt.present) {
      map['last_login_at'] = Variable<String>(lastLoginAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppUsersCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('role: $role, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('fullName: $fullName, ')
          ..write('isActive: $isActive, ')
          ..write('lastLoginAt: $lastLoginAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeachersTable extends Teachers with TableInfo<$TeachersTable, Teacher> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeachersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _employeeNoMeta = const VerificationMeta(
    'employeeNo',
  );
  @override
  late final GeneratedColumn<String> employeeNo = GeneratedColumn<String>(
    'employee_no',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cnicMeta = const VerificationMeta('cnic');
  @override
  late final GeneratedColumn<String> cnic = GeneratedColumn<String>(
    'cnic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qualificationMeta = const VerificationMeta(
    'qualification',
  );
  @override
  late final GeneratedColumn<String> qualification = GeneratedColumn<String>(
    'qualification',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _joiningDateMeta = const VerificationMeta(
    'joiningDate',
  );
  @override
  late final GeneratedColumn<String> joiningDate = GeneratedColumn<String>(
    'joining_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    userId,
    schoolId,
    employeeNo,
    fullName,
    cnic,
    phone,
    qualification,
    joiningDate,
    photoUrl,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teachers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Teacher> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('employee_no')) {
      context.handle(
        _employeeNoMeta,
        employeeNo.isAcceptableOrUnknown(data['employee_no']!, _employeeNoMeta),
      );
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('cnic')) {
      context.handle(
        _cnicMeta,
        cnic.isAcceptableOrUnknown(data['cnic']!, _cnicMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('qualification')) {
      context.handle(
        _qualificationMeta,
        qualification.isAcceptableOrUnknown(
          data['qualification']!,
          _qualificationMeta,
        ),
      );
    }
    if (data.containsKey('joining_date')) {
      context.handle(
        _joiningDateMeta,
        joiningDate.isAcceptableOrUnknown(
          data['joining_date']!,
          _joiningDateMeta,
        ),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {schoolId, employeeNo},
  ];
  @override
  Teacher map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Teacher(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      employeeNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}employee_no'],
      ),
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      cnic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cnic'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      qualification: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qualification'],
      ),
      joiningDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}joining_date'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $TeachersTable createAlias(String alias) {
    return $TeachersTable(attachedDatabase, alias);
  }
}

class Teacher extends DataClass implements Insertable<Teacher> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;

  /// Null until the teacher has an app login.
  final String? userId;
  final String schoolId;
  final String? employeeNo;
  final String fullName;
  final String? cnic;
  final String? phone;
  final String? qualification;
  final String? joiningDate;
  final String? photoUrl;
  final bool isActive;
  const Teacher({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    this.userId,
    required this.schoolId,
    this.employeeNo,
    required this.fullName,
    this.cnic,
    this.phone,
    this.qualification,
    this.joiningDate,
    this.photoUrl,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['school_id'] = Variable<String>(schoolId);
    if (!nullToAbsent || employeeNo != null) {
      map['employee_no'] = Variable<String>(employeeNo);
    }
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || cnic != null) {
      map['cnic'] = Variable<String>(cnic);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || qualification != null) {
      map['qualification'] = Variable<String>(qualification);
    }
    if (!nullToAbsent || joiningDate != null) {
      map['joining_date'] = Variable<String>(joiningDate);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  TeachersCompanion toCompanion(bool nullToAbsent) {
    return TeachersCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      schoolId: Value(schoolId),
      employeeNo: employeeNo == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeNo),
      fullName: Value(fullName),
      cnic: cnic == null && nullToAbsent ? const Value.absent() : Value(cnic),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      qualification: qualification == null && nullToAbsent
          ? const Value.absent()
          : Value(qualification),
      joiningDate: joiningDate == null && nullToAbsent
          ? const Value.absent()
          : Value(joiningDate),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      isActive: Value(isActive),
    );
  }

  factory Teacher.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Teacher(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['user_id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      employeeNo: serializer.fromJson<String?>(json['employee_no']),
      fullName: serializer.fromJson<String>(json['full_name']),
      cnic: serializer.fromJson<String?>(json['cnic']),
      phone: serializer.fromJson<String?>(json['phone']),
      qualification: serializer.fromJson<String?>(json['qualification']),
      joiningDate: serializer.fromJson<String?>(json['joining_date']),
      photoUrl: serializer.fromJson<String?>(json['photo_url']),
      isActive: serializer.fromJson<bool>(json['is_active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<String?>(userId),
      'school_id': serializer.toJson<String>(schoolId),
      'employee_no': serializer.toJson<String?>(employeeNo),
      'full_name': serializer.toJson<String>(fullName),
      'cnic': serializer.toJson<String?>(cnic),
      'phone': serializer.toJson<String?>(phone),
      'qualification': serializer.toJson<String?>(qualification),
      'joining_date': serializer.toJson<String?>(joiningDate),
      'photo_url': serializer.toJson<String?>(photoUrl),
      'is_active': serializer.toJson<bool>(isActive),
    };
  }

  Teacher copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    Value<String?> userId = const Value.absent(),
    String? schoolId,
    Value<String?> employeeNo = const Value.absent(),
    String? fullName,
    Value<String?> cnic = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> qualification = const Value.absent(),
    Value<String?> joiningDate = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    bool? isActive,
  }) => Teacher(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    schoolId: schoolId ?? this.schoolId,
    employeeNo: employeeNo.present ? employeeNo.value : this.employeeNo,
    fullName: fullName ?? this.fullName,
    cnic: cnic.present ? cnic.value : this.cnic,
    phone: phone.present ? phone.value : this.phone,
    qualification: qualification.present
        ? qualification.value
        : this.qualification,
    joiningDate: joiningDate.present ? joiningDate.value : this.joiningDate,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    isActive: isActive ?? this.isActive,
  );
  Teacher copyWithCompanion(TeachersCompanion data) {
    return Teacher(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      employeeNo: data.employeeNo.present
          ? data.employeeNo.value
          : this.employeeNo,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      cnic: data.cnic.present ? data.cnic.value : this.cnic,
      phone: data.phone.present ? data.phone.value : this.phone,
      qualification: data.qualification.present
          ? data.qualification.value
          : this.qualification,
      joiningDate: data.joiningDate.present
          ? data.joiningDate.value
          : this.joiningDate,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Teacher(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('schoolId: $schoolId, ')
          ..write('employeeNo: $employeeNo, ')
          ..write('fullName: $fullName, ')
          ..write('cnic: $cnic, ')
          ..write('phone: $phone, ')
          ..write('qualification: $qualification, ')
          ..write('joiningDate: $joiningDate, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    userId,
    schoolId,
    employeeNo,
    fullName,
    cnic,
    phone,
    qualification,
    joiningDate,
    photoUrl,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Teacher &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.schoolId == this.schoolId &&
          other.employeeNo == this.employeeNo &&
          other.fullName == this.fullName &&
          other.cnic == this.cnic &&
          other.phone == this.phone &&
          other.qualification == this.qualification &&
          other.joiningDate == this.joiningDate &&
          other.photoUrl == this.photoUrl &&
          other.isActive == this.isActive);
}

class TeachersCompanion extends UpdateCompanion<Teacher> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String?> userId;
  final Value<String> schoolId;
  final Value<String?> employeeNo;
  final Value<String> fullName;
  final Value<String?> cnic;
  final Value<String?> phone;
  final Value<String?> qualification;
  final Value<String?> joiningDate;
  final Value<String?> photoUrl;
  final Value<bool> isActive;
  final Value<int> rowid;
  const TeachersCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.employeeNo = const Value.absent(),
    this.fullName = const Value.absent(),
    this.cnic = const Value.absent(),
    this.phone = const Value.absent(),
    this.qualification = const Value.absent(),
    this.joiningDate = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeachersCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    this.userId = const Value.absent(),
    required String schoolId,
    this.employeeNo = const Value.absent(),
    required String fullName,
    this.cnic = const Value.absent(),
    this.phone = const Value.absent(),
    this.qualification = const Value.absent(),
    this.joiningDate = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       fullName = Value(fullName);
  static Insertable<Teacher> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? schoolId,
    Expression<String>? employeeNo,
    Expression<String>? fullName,
    Expression<String>? cnic,
    Expression<String>? phone,
    Expression<String>? qualification,
    Expression<String>? joiningDate,
    Expression<String>? photoUrl,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (schoolId != null) 'school_id': schoolId,
      if (employeeNo != null) 'employee_no': employeeNo,
      if (fullName != null) 'full_name': fullName,
      if (cnic != null) 'cnic': cnic,
      if (phone != null) 'phone': phone,
      if (qualification != null) 'qualification': qualification,
      if (joiningDate != null) 'joining_date': joiningDate,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeachersCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String?>? userId,
    Value<String>? schoolId,
    Value<String?>? employeeNo,
    Value<String>? fullName,
    Value<String?>? cnic,
    Value<String?>? phone,
    Value<String?>? qualification,
    Value<String?>? joiningDate,
    Value<String?>? photoUrl,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return TeachersCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      schoolId: schoolId ?? this.schoolId,
      employeeNo: employeeNo ?? this.employeeNo,
      fullName: fullName ?? this.fullName,
      cnic: cnic ?? this.cnic,
      phone: phone ?? this.phone,
      qualification: qualification ?? this.qualification,
      joiningDate: joiningDate ?? this.joiningDate,
      photoUrl: photoUrl ?? this.photoUrl,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (employeeNo.present) {
      map['employee_no'] = Variable<String>(employeeNo.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (cnic.present) {
      map['cnic'] = Variable<String>(cnic.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (qualification.present) {
      map['qualification'] = Variable<String>(qualification.value);
    }
    if (joiningDate.present) {
      map['joining_date'] = Variable<String>(joiningDate.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeachersCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('schoolId: $schoolId, ')
          ..write('employeeNo: $employeeNo, ')
          ..write('fullName: $fullName, ')
          ..write('cnic: $cnic, ')
          ..write('phone: $phone, ')
          ..write('qualification: $qualification, ')
          ..write('joiningDate: $joiningDate, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeacherClassAssignmentsTable extends TeacherClassAssignments
    with TableInfo<$TeacherClassAssignmentsTable, TeacherClassAssignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeacherClassAssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teacherIdMeta = const VerificationMeta(
    'teacherId',
  );
  @override
  late final GeneratedColumn<String> teacherId = GeneratedColumn<String>(
    'teacher_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _canMarkAttendanceMeta = const VerificationMeta(
    'canMarkAttendance',
  );
  @override
  late final GeneratedColumn<bool> canMarkAttendance = GeneratedColumn<bool>(
    'can_mark_attendance',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_mark_attendance" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    teacherId,
    classId,
    subjectId,
    canMarkAttendance,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teacher_class_assignments';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeacherClassAssignment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('teacher_id')) {
      context.handle(
        _teacherIdMeta,
        teacherId.isAcceptableOrUnknown(data['teacher_id']!, _teacherIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teacherIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    }
    if (data.containsKey('can_mark_attendance')) {
      context.handle(
        _canMarkAttendanceMeta,
        canMarkAttendance.isAcceptableOrUnknown(
          data['can_mark_attendance']!,
          _canMarkAttendanceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeacherClassAssignment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeacherClassAssignment(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      teacherId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}teacher_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      ),
      canMarkAttendance: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_mark_attendance'],
      )!,
    );
  }

  @override
  $TeacherClassAssignmentsTable createAlias(String alias) {
    return $TeacherClassAssignmentsTable(attachedDatabase, alias);
  }
}

class TeacherClassAssignment extends DataClass
    implements Insertable<TeacherClassAssignment> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String teacherId;
  final String classId;

  /// Null means this teacher is the CLASS teacher rather than a subject
  /// teacher.
  final String? subjectId;
  final bool canMarkAttendance;
  const TeacherClassAssignment({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.teacherId,
    required this.classId,
    this.subjectId,
    required this.canMarkAttendance,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['teacher_id'] = Variable<String>(teacherId);
    map['class_id'] = Variable<String>(classId);
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<String>(subjectId);
    }
    map['can_mark_attendance'] = Variable<bool>(canMarkAttendance);
    return map;
  }

  TeacherClassAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return TeacherClassAssignmentsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      teacherId: Value(teacherId),
      classId: Value(classId),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
      canMarkAttendance: Value(canMarkAttendance),
    );
  }

  factory TeacherClassAssignment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeacherClassAssignment(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      teacherId: serializer.fromJson<String>(json['teacher_id']),
      classId: serializer.fromJson<String>(json['class_id']),
      subjectId: serializer.fromJson<String?>(json['subject_id']),
      canMarkAttendance: serializer.fromJson<bool>(json['can_mark_attendance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'teacher_id': serializer.toJson<String>(teacherId),
      'class_id': serializer.toJson<String>(classId),
      'subject_id': serializer.toJson<String?>(subjectId),
      'can_mark_attendance': serializer.toJson<bool>(canMarkAttendance),
    };
  }

  TeacherClassAssignment copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? teacherId,
    String? classId,
    Value<String?> subjectId = const Value.absent(),
    bool? canMarkAttendance,
  }) => TeacherClassAssignment(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    teacherId: teacherId ?? this.teacherId,
    classId: classId ?? this.classId,
    subjectId: subjectId.present ? subjectId.value : this.subjectId,
    canMarkAttendance: canMarkAttendance ?? this.canMarkAttendance,
  );
  TeacherClassAssignment copyWithCompanion(
    TeacherClassAssignmentsCompanion data,
  ) {
    return TeacherClassAssignment(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      teacherId: data.teacherId.present ? data.teacherId.value : this.teacherId,
      classId: data.classId.present ? data.classId.value : this.classId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      canMarkAttendance: data.canMarkAttendance.present
          ? data.canMarkAttendance.value
          : this.canMarkAttendance,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeacherClassAssignment(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('teacherId: $teacherId, ')
          ..write('classId: $classId, ')
          ..write('subjectId: $subjectId, ')
          ..write('canMarkAttendance: $canMarkAttendance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    teacherId,
    classId,
    subjectId,
    canMarkAttendance,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeacherClassAssignment &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.teacherId == this.teacherId &&
          other.classId == this.classId &&
          other.subjectId == this.subjectId &&
          other.canMarkAttendance == this.canMarkAttendance);
}

class TeacherClassAssignmentsCompanion
    extends UpdateCompanion<TeacherClassAssignment> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> teacherId;
  final Value<String> classId;
  final Value<String?> subjectId;
  final Value<bool> canMarkAttendance;
  final Value<int> rowid;
  const TeacherClassAssignmentsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.classId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.canMarkAttendance = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeacherClassAssignmentsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String teacherId,
    required String classId,
    this.subjectId = const Value.absent(),
    this.canMarkAttendance = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       teacherId = Value(teacherId),
       classId = Value(classId);
  static Insertable<TeacherClassAssignment> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? teacherId,
    Expression<String>? classId,
    Expression<String>? subjectId,
    Expression<bool>? canMarkAttendance,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (teacherId != null) 'teacher_id': teacherId,
      if (classId != null) 'class_id': classId,
      if (subjectId != null) 'subject_id': subjectId,
      if (canMarkAttendance != null) 'can_mark_attendance': canMarkAttendance,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeacherClassAssignmentsCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? teacherId,
    Value<String>? classId,
    Value<String?>? subjectId,
    Value<bool>? canMarkAttendance,
    Value<int>? rowid,
  }) {
    return TeacherClassAssignmentsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      teacherId: teacherId ?? this.teacherId,
      classId: classId ?? this.classId,
      subjectId: subjectId ?? this.subjectId,
      canMarkAttendance: canMarkAttendance ?? this.canMarkAttendance,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (teacherId.present) {
      map['teacher_id'] = Variable<String>(teacherId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (canMarkAttendance.present) {
      map['can_mark_attendance'] = Variable<bool>(canMarkAttendance.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeacherClassAssignmentsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('teacherId: $teacherId, ')
          ..write('classId: $classId, ')
          ..write('subjectId: $subjectId, ')
          ..write('canMarkAttendance: $canMarkAttendance, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _admissionNoMeta = const VerificationMeta(
    'admissionNo',
  );
  @override
  late final GeneratedColumn<String> admissionNo = GeneratedColumn<String>(
    'admission_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rollNoMeta = const VerificationMeta('rollNo');
  @override
  late final GeneratedColumn<int> rollNo = GeneratedColumn<int>(
    'roll_no',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatherNameMeta = const VerificationMeta(
    'fatherName',
  );
  @override
  late final GeneratedColumn<String> fatherName = GeneratedColumn<String>(
    'father_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _guardianPhoneMeta = const VerificationMeta(
    'guardianPhone',
  );
  @override
  late final GeneratedColumn<String> guardianPhone = GeneratedColumn<String>(
    'guardian_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _documentsMeta = const VerificationMeta(
    'documents',
  );
  @override
  late final GeneratedColumn<String> documents = GeneratedColumn<String>(
    'documents',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _admissionDateMeta = const VerificationMeta(
    'admissionDate',
  );
  @override
  late final GeneratedColumn<String> admissionDate = GeneratedColumn<String>(
    'admission_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _leftDateMeta = const VerificationMeta(
    'leftDate',
  );
  @override
  late final GeneratedColumn<String> leftDate = GeneratedColumn<String>(
    'left_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _leftReasonMeta = const VerificationMeta(
    'leftReason',
  );
  @override
  late final GeneratedColumn<String> leftReason = GeneratedColumn<String>(
    'left_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    userId,
    schoolId,
    classId,
    admissionNo,
    rollNo,
    fullName,
    fatherName,
    guardianPhone,
    dateOfBirth,
    gender,
    address,
    documents,
    photoUrl,
    admissionDate,
    status,
    leftDate,
    leftReason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(
    Insertable<Student> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    }
    if (data.containsKey('admission_no')) {
      context.handle(
        _admissionNoMeta,
        admissionNo.isAcceptableOrUnknown(
          data['admission_no']!,
          _admissionNoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_admissionNoMeta);
    }
    if (data.containsKey('roll_no')) {
      context.handle(
        _rollNoMeta,
        rollNo.isAcceptableOrUnknown(data['roll_no']!, _rollNoMeta),
      );
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('father_name')) {
      context.handle(
        _fatherNameMeta,
        fatherName.isAcceptableOrUnknown(data['father_name']!, _fatherNameMeta),
      );
    }
    if (data.containsKey('guardian_phone')) {
      context.handle(
        _guardianPhoneMeta,
        guardianPhone.isAcceptableOrUnknown(
          data['guardian_phone']!,
          _guardianPhoneMeta,
        ),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('documents')) {
      context.handle(
        _documentsMeta,
        documents.isAcceptableOrUnknown(data['documents']!, _documentsMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('admission_date')) {
      context.handle(
        _admissionDateMeta,
        admissionDate.isAcceptableOrUnknown(
          data['admission_date']!,
          _admissionDateMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('left_date')) {
      context.handle(
        _leftDateMeta,
        leftDate.isAcceptableOrUnknown(data['left_date']!, _leftDateMeta),
      );
    }
    if (data.containsKey('left_reason')) {
      context.handle(
        _leftReasonMeta,
        leftReason.isAcceptableOrUnknown(data['left_reason']!, _leftReasonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {schoolId, admissionNo},
  ];
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      ),
      admissionNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}admission_no'],
      )!,
      rollNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}roll_no'],
      ),
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      fatherName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}father_name'],
      ),
      guardianPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}guardian_phone'],
      ),
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_of_birth'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      documents: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}documents'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      admissionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}admission_date'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      leftDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}left_date'],
      ),
      leftReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}left_reason'],
      ),
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;

  /// Null until the student has an app login.
  final String? userId;
  final String schoolId;

  /// Null while a student is enrolled but not yet placed in a class.
  final String? classId;

  /// `'2026-0341'` — school-wide and PERMANENT.
  ///
  /// Distinct from [rollNo], which is per-class and resets every year. The
  /// university app's single `FA23-BCS-067` could not express both
  /// (CLAUDE.md §8).
  final String admissionNo;

  /// `23` — position within the class, reset yearly.
  final int? rollNo;
  final String fullName;
  final String? fatherName;

  /// Guardian's number, for the OFFICE only.
  ///
  /// These are minors: this must never be rendered anywhere in the student
  /// app. CLAUDE.md §7.
  final String? guardianPhone;
  final String? dateOfBirth;

  /// `Gender.wire` — `'male'` | `'female'`.
  final String? gender;
  final String? address;
  final String? documents;
  final String? photoUrl;
  final String? admissionDate;

  /// `StudentStatus.wire`, defaulting to `'active'`.
  final String status;
  final String? leftDate;
  final String? leftReason;
  const Student({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    this.userId,
    required this.schoolId,
    this.classId,
    required this.admissionNo,
    this.rollNo,
    required this.fullName,
    this.fatherName,
    this.guardianPhone,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.documents,
    this.photoUrl,
    this.admissionDate,
    required this.status,
    this.leftDate,
    this.leftReason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['school_id'] = Variable<String>(schoolId);
    if (!nullToAbsent || classId != null) {
      map['class_id'] = Variable<String>(classId);
    }
    map['admission_no'] = Variable<String>(admissionNo);
    if (!nullToAbsent || rollNo != null) {
      map['roll_no'] = Variable<int>(rollNo);
    }
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || fatherName != null) {
      map['father_name'] = Variable<String>(fatherName);
    }
    if (!nullToAbsent || guardianPhone != null) {
      map['guardian_phone'] = Variable<String>(guardianPhone);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<String>(dateOfBirth);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || documents != null) {
      map['documents'] = Variable<String>(documents);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || admissionDate != null) {
      map['admission_date'] = Variable<String>(admissionDate);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || leftDate != null) {
      map['left_date'] = Variable<String>(leftDate);
    }
    if (!nullToAbsent || leftReason != null) {
      map['left_reason'] = Variable<String>(leftReason);
    }
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      schoolId: Value(schoolId),
      classId: classId == null && nullToAbsent
          ? const Value.absent()
          : Value(classId),
      admissionNo: Value(admissionNo),
      rollNo: rollNo == null && nullToAbsent
          ? const Value.absent()
          : Value(rollNo),
      fullName: Value(fullName),
      fatherName: fatherName == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherName),
      guardianPhone: guardianPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(guardianPhone),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      documents: documents == null && nullToAbsent
          ? const Value.absent()
          : Value(documents),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      admissionDate: admissionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(admissionDate),
      status: Value(status),
      leftDate: leftDate == null && nullToAbsent
          ? const Value.absent()
          : Value(leftDate),
      leftReason: leftReason == null && nullToAbsent
          ? const Value.absent()
          : Value(leftReason),
    );
  }

  factory Student.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['user_id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      classId: serializer.fromJson<String?>(json['class_id']),
      admissionNo: serializer.fromJson<String>(json['admission_no']),
      rollNo: serializer.fromJson<int?>(json['roll_no']),
      fullName: serializer.fromJson<String>(json['full_name']),
      fatherName: serializer.fromJson<String?>(json['father_name']),
      guardianPhone: serializer.fromJson<String?>(json['guardian_phone']),
      dateOfBirth: serializer.fromJson<String?>(json['date_of_birth']),
      gender: serializer.fromJson<String?>(json['gender']),
      address: serializer.fromJson<String?>(json['address']),
      documents: serializer.fromJson<String?>(json['documents']),
      photoUrl: serializer.fromJson<String?>(json['photo_url']),
      admissionDate: serializer.fromJson<String?>(json['admission_date']),
      status: serializer.fromJson<String>(json['status']),
      leftDate: serializer.fromJson<String?>(json['left_date']),
      leftReason: serializer.fromJson<String?>(json['left_reason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<String?>(userId),
      'school_id': serializer.toJson<String>(schoolId),
      'class_id': serializer.toJson<String?>(classId),
      'admission_no': serializer.toJson<String>(admissionNo),
      'roll_no': serializer.toJson<int?>(rollNo),
      'full_name': serializer.toJson<String>(fullName),
      'father_name': serializer.toJson<String?>(fatherName),
      'guardian_phone': serializer.toJson<String?>(guardianPhone),
      'date_of_birth': serializer.toJson<String?>(dateOfBirth),
      'gender': serializer.toJson<String?>(gender),
      'address': serializer.toJson<String?>(address),
      'documents': serializer.toJson<String?>(documents),
      'photo_url': serializer.toJson<String?>(photoUrl),
      'admission_date': serializer.toJson<String?>(admissionDate),
      'status': serializer.toJson<String>(status),
      'left_date': serializer.toJson<String?>(leftDate),
      'left_reason': serializer.toJson<String?>(leftReason),
    };
  }

  Student copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    Value<String?> userId = const Value.absent(),
    String? schoolId,
    Value<String?> classId = const Value.absent(),
    String? admissionNo,
    Value<int?> rollNo = const Value.absent(),
    String? fullName,
    Value<String?> fatherName = const Value.absent(),
    Value<String?> guardianPhone = const Value.absent(),
    Value<String?> dateOfBirth = const Value.absent(),
    Value<String?> gender = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> documents = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    Value<String?> admissionDate = const Value.absent(),
    String? status,
    Value<String?> leftDate = const Value.absent(),
    Value<String?> leftReason = const Value.absent(),
  }) => Student(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    schoolId: schoolId ?? this.schoolId,
    classId: classId.present ? classId.value : this.classId,
    admissionNo: admissionNo ?? this.admissionNo,
    rollNo: rollNo.present ? rollNo.value : this.rollNo,
    fullName: fullName ?? this.fullName,
    fatherName: fatherName.present ? fatherName.value : this.fatherName,
    guardianPhone: guardianPhone.present
        ? guardianPhone.value
        : this.guardianPhone,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    gender: gender.present ? gender.value : this.gender,
    address: address.present ? address.value : this.address,
    documents: documents.present ? documents.value : this.documents,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    admissionDate: admissionDate.present
        ? admissionDate.value
        : this.admissionDate,
    status: status ?? this.status,
    leftDate: leftDate.present ? leftDate.value : this.leftDate,
    leftReason: leftReason.present ? leftReason.value : this.leftReason,
  );
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      classId: data.classId.present ? data.classId.value : this.classId,
      admissionNo: data.admissionNo.present
          ? data.admissionNo.value
          : this.admissionNo,
      rollNo: data.rollNo.present ? data.rollNo.value : this.rollNo,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      fatherName: data.fatherName.present
          ? data.fatherName.value
          : this.fatherName,
      guardianPhone: data.guardianPhone.present
          ? data.guardianPhone.value
          : this.guardianPhone,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      gender: data.gender.present ? data.gender.value : this.gender,
      address: data.address.present ? data.address.value : this.address,
      documents: data.documents.present ? data.documents.value : this.documents,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      admissionDate: data.admissionDate.present
          ? data.admissionDate.value
          : this.admissionDate,
      status: data.status.present ? data.status.value : this.status,
      leftDate: data.leftDate.present ? data.leftDate.value : this.leftDate,
      leftReason: data.leftReason.present
          ? data.leftReason.value
          : this.leftReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('admissionNo: $admissionNo, ')
          ..write('rollNo: $rollNo, ')
          ..write('fullName: $fullName, ')
          ..write('fatherName: $fatherName, ')
          ..write('guardianPhone: $guardianPhone, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('address: $address, ')
          ..write('documents: $documents, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('admissionDate: $admissionDate, ')
          ..write('status: $status, ')
          ..write('leftDate: $leftDate, ')
          ..write('leftReason: $leftReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    userId,
    schoolId,
    classId,
    admissionNo,
    rollNo,
    fullName,
    fatherName,
    guardianPhone,
    dateOfBirth,
    gender,
    address,
    documents,
    photoUrl,
    admissionDate,
    status,
    leftDate,
    leftReason,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.schoolId == this.schoolId &&
          other.classId == this.classId &&
          other.admissionNo == this.admissionNo &&
          other.rollNo == this.rollNo &&
          other.fullName == this.fullName &&
          other.fatherName == this.fatherName &&
          other.guardianPhone == this.guardianPhone &&
          other.dateOfBirth == this.dateOfBirth &&
          other.gender == this.gender &&
          other.address == this.address &&
          other.documents == this.documents &&
          other.photoUrl == this.photoUrl &&
          other.admissionDate == this.admissionDate &&
          other.status == this.status &&
          other.leftDate == this.leftDate &&
          other.leftReason == this.leftReason);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String?> userId;
  final Value<String> schoolId;
  final Value<String?> classId;
  final Value<String> admissionNo;
  final Value<int?> rollNo;
  final Value<String> fullName;
  final Value<String?> fatherName;
  final Value<String?> guardianPhone;
  final Value<String?> dateOfBirth;
  final Value<String?> gender;
  final Value<String?> address;
  final Value<String?> documents;
  final Value<String?> photoUrl;
  final Value<String?> admissionDate;
  final Value<String> status;
  final Value<String?> leftDate;
  final Value<String?> leftReason;
  final Value<int> rowid;
  const StudentsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.classId = const Value.absent(),
    this.admissionNo = const Value.absent(),
    this.rollNo = const Value.absent(),
    this.fullName = const Value.absent(),
    this.fatherName = const Value.absent(),
    this.guardianPhone = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.address = const Value.absent(),
    this.documents = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.admissionDate = const Value.absent(),
    this.status = const Value.absent(),
    this.leftDate = const Value.absent(),
    this.leftReason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    this.userId = const Value.absent(),
    required String schoolId,
    this.classId = const Value.absent(),
    required String admissionNo,
    this.rollNo = const Value.absent(),
    required String fullName,
    this.fatherName = const Value.absent(),
    this.guardianPhone = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.address = const Value.absent(),
    this.documents = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.admissionDate = const Value.absent(),
    this.status = const Value.absent(),
    this.leftDate = const Value.absent(),
    this.leftReason = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       admissionNo = Value(admissionNo),
       fullName = Value(fullName);
  static Insertable<Student> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? schoolId,
    Expression<String>? classId,
    Expression<String>? admissionNo,
    Expression<int>? rollNo,
    Expression<String>? fullName,
    Expression<String>? fatherName,
    Expression<String>? guardianPhone,
    Expression<String>? dateOfBirth,
    Expression<String>? gender,
    Expression<String>? address,
    Expression<String>? documents,
    Expression<String>? photoUrl,
    Expression<String>? admissionDate,
    Expression<String>? status,
    Expression<String>? leftDate,
    Expression<String>? leftReason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (schoolId != null) 'school_id': schoolId,
      if (classId != null) 'class_id': classId,
      if (admissionNo != null) 'admission_no': admissionNo,
      if (rollNo != null) 'roll_no': rollNo,
      if (fullName != null) 'full_name': fullName,
      if (fatherName != null) 'father_name': fatherName,
      if (guardianPhone != null) 'guardian_phone': guardianPhone,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (gender != null) 'gender': gender,
      if (address != null) 'address': address,
      if (documents != null) 'documents': documents,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (admissionDate != null) 'admission_date': admissionDate,
      if (status != null) 'status': status,
      if (leftDate != null) 'left_date': leftDate,
      if (leftReason != null) 'left_reason': leftReason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentsCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String?>? userId,
    Value<String>? schoolId,
    Value<String?>? classId,
    Value<String>? admissionNo,
    Value<int?>? rollNo,
    Value<String>? fullName,
    Value<String?>? fatherName,
    Value<String?>? guardianPhone,
    Value<String?>? dateOfBirth,
    Value<String?>? gender,
    Value<String?>? address,
    Value<String?>? documents,
    Value<String?>? photoUrl,
    Value<String?>? admissionDate,
    Value<String>? status,
    Value<String?>? leftDate,
    Value<String?>? leftReason,
    Value<int>? rowid,
  }) {
    return StudentsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      schoolId: schoolId ?? this.schoolId,
      classId: classId ?? this.classId,
      admissionNo: admissionNo ?? this.admissionNo,
      rollNo: rollNo ?? this.rollNo,
      fullName: fullName ?? this.fullName,
      fatherName: fatherName ?? this.fatherName,
      guardianPhone: guardianPhone ?? this.guardianPhone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      documents: documents ?? this.documents,
      photoUrl: photoUrl ?? this.photoUrl,
      admissionDate: admissionDate ?? this.admissionDate,
      status: status ?? this.status,
      leftDate: leftDate ?? this.leftDate,
      leftReason: leftReason ?? this.leftReason,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (admissionNo.present) {
      map['admission_no'] = Variable<String>(admissionNo.value);
    }
    if (rollNo.present) {
      map['roll_no'] = Variable<int>(rollNo.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (fatherName.present) {
      map['father_name'] = Variable<String>(fatherName.value);
    }
    if (guardianPhone.present) {
      map['guardian_phone'] = Variable<String>(guardianPhone.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (documents.present) {
      map['documents'] = Variable<String>(documents.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (admissionDate.present) {
      map['admission_date'] = Variable<String>(admissionDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (leftDate.present) {
      map['left_date'] = Variable<String>(leftDate.value);
    }
    if (leftReason.present) {
      map['left_reason'] = Variable<String>(leftReason.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('admissionNo: $admissionNo, ')
          ..write('rollNo: $rollNo, ')
          ..write('fullName: $fullName, ')
          ..write('fatherName: $fatherName, ')
          ..write('guardianPhone: $guardianPhone, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('address: $address, ')
          ..write('documents: $documents, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('admissionDate: $admissionDate, ')
          ..write('status: $status, ')
          ..write('leftDate: $leftDate, ')
          ..write('leftReason: $leftReason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttendanceTable extends Attendance
    with TableInfo<$AttendanceTable, AttendanceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _markedByMeta = const VerificationMeta(
    'markedBy',
  );
  @override
  late final GeneratedColumn<String> markedBy = GeneratedColumn<String>(
    'marked_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _markedAtMeta = const VerificationMeta(
    'markedAt',
  );
  @override
  late final GeneratedColumn<String> markedAt = GeneratedColumn<String>(
    'marked_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    studentId,
    classId,
    date,
    status,
    remarks,
    markedBy,
    markedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    if (data.containsKey('marked_by')) {
      context.handle(
        _markedByMeta,
        markedBy.isAcceptableOrUnknown(data['marked_by']!, _markedByMeta),
      );
    } else if (isInserting) {
      context.missing(_markedByMeta);
    }
    if (data.containsKey('marked_at')) {
      context.handle(
        _markedAtMeta,
        markedAt.isAcceptableOrUnknown(data['marked_at']!, _markedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_markedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {studentId, date},
  ];
  @override
  AttendanceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      ),
      markedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marked_by'],
      )!,
      markedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marked_at'],
      )!,
    );
  }

  @override
  $AttendanceTable createAlias(String alias) {
    return $AttendanceTable(attachedDatabase, alias);
  }
}

class AttendanceRow extends DataClass implements Insertable<AttendanceRow> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String studentId;
  final String classId;

  /// DATE as `YYYY-MM-DD`, in the school's LOCAL calendar. See
  /// `encodeDate` in time.dart for why this must not go through UTC.
  final String date;

  /// `AttendanceStatus.wire` — one of `present`, `absent`, `leave`, `late`,
  /// `holiday`. Five states, not a boolean (CLAUDE.md §8).
  final String status;
  final String? remarks;
  final String markedBy;
  final String markedAt;
  const AttendanceRow({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.studentId,
    required this.classId,
    required this.date,
    required this.status,
    this.remarks,
    required this.markedBy,
    required this.markedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['student_id'] = Variable<String>(studentId);
    map['class_id'] = Variable<String>(classId);
    map['date'] = Variable<String>(date);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || remarks != null) {
      map['remarks'] = Variable<String>(remarks);
    }
    map['marked_by'] = Variable<String>(markedBy);
    map['marked_at'] = Variable<String>(markedAt);
    return map;
  }

  AttendanceCompanion toCompanion(bool nullToAbsent) {
    return AttendanceCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      studentId: Value(studentId),
      classId: Value(classId),
      date: Value(date),
      status: Value(status),
      remarks: remarks == null && nullToAbsent
          ? const Value.absent()
          : Value(remarks),
      markedBy: Value(markedBy),
      markedAt: Value(markedAt),
    );
  }

  factory AttendanceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceRow(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      studentId: serializer.fromJson<String>(json['student_id']),
      classId: serializer.fromJson<String>(json['class_id']),
      date: serializer.fromJson<String>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      remarks: serializer.fromJson<String?>(json['remarks']),
      markedBy: serializer.fromJson<String>(json['marked_by']),
      markedAt: serializer.fromJson<String>(json['marked_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'student_id': serializer.toJson<String>(studentId),
      'class_id': serializer.toJson<String>(classId),
      'date': serializer.toJson<String>(date),
      'status': serializer.toJson<String>(status),
      'remarks': serializer.toJson<String?>(remarks),
      'marked_by': serializer.toJson<String>(markedBy),
      'marked_at': serializer.toJson<String>(markedAt),
    };
  }

  AttendanceRow copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? studentId,
    String? classId,
    String? date,
    String? status,
    Value<String?> remarks = const Value.absent(),
    String? markedBy,
    String? markedAt,
  }) => AttendanceRow(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    studentId: studentId ?? this.studentId,
    classId: classId ?? this.classId,
    date: date ?? this.date,
    status: status ?? this.status,
    remarks: remarks.present ? remarks.value : this.remarks,
    markedBy: markedBy ?? this.markedBy,
    markedAt: markedAt ?? this.markedAt,
  );
  AttendanceRow copyWithCompanion(AttendanceCompanion data) {
    return AttendanceRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      classId: data.classId.present ? data.classId.value : this.classId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      markedBy: data.markedBy.present ? data.markedBy.value : this.markedBy,
      markedAt: data.markedAt.present ? data.markedAt.value : this.markedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('studentId: $studentId, ')
          ..write('classId: $classId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('remarks: $remarks, ')
          ..write('markedBy: $markedBy, ')
          ..write('markedAt: $markedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    studentId,
    classId,
    date,
    status,
    remarks,
    markedBy,
    markedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceRow &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.studentId == this.studentId &&
          other.classId == this.classId &&
          other.date == this.date &&
          other.status == this.status &&
          other.remarks == this.remarks &&
          other.markedBy == this.markedBy &&
          other.markedAt == this.markedAt);
}

class AttendanceCompanion extends UpdateCompanion<AttendanceRow> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> studentId;
  final Value<String> classId;
  final Value<String> date;
  final Value<String> status;
  final Value<String?> remarks;
  final Value<String> markedBy;
  final Value<String> markedAt;
  final Value<int> rowid;
  const AttendanceCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.classId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.remarks = const Value.absent(),
    this.markedBy = const Value.absent(),
    this.markedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String studentId,
    required String classId,
    required String date,
    required String status,
    this.remarks = const Value.absent(),
    required String markedBy,
    required String markedAt,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       studentId = Value(studentId),
       classId = Value(classId),
       date = Value(date),
       status = Value(status),
       markedBy = Value(markedBy),
       markedAt = Value(markedAt);
  static Insertable<AttendanceRow> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? studentId,
    Expression<String>? classId,
    Expression<String>? date,
    Expression<String>? status,
    Expression<String>? remarks,
    Expression<String>? markedBy,
    Expression<String>? markedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (studentId != null) 'student_id': studentId,
      if (classId != null) 'class_id': classId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (remarks != null) 'remarks': remarks,
      if (markedBy != null) 'marked_by': markedBy,
      if (markedAt != null) 'marked_at': markedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? studentId,
    Value<String>? classId,
    Value<String>? date,
    Value<String>? status,
    Value<String?>? remarks,
    Value<String>? markedBy,
    Value<String>? markedAt,
    Value<int>? rowid,
  }) {
    return AttendanceCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      studentId: studentId ?? this.studentId,
      classId: classId ?? this.classId,
      date: date ?? this.date,
      status: status ?? this.status,
      remarks: remarks ?? this.remarks,
      markedBy: markedBy ?? this.markedBy,
      markedAt: markedAt ?? this.markedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (markedBy.present) {
      map['marked_by'] = Variable<String>(markedBy.value);
    }
    if (markedAt.present) {
      map['marked_at'] = Variable<String>(markedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('studentId: $studentId, ')
          ..write('classId: $classId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('remarks: $remarks, ')
          ..write('markedBy: $markedBy, ')
          ..write('markedAt: $markedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeacherAttendanceTable extends TeacherAttendance
    with TableInfo<$TeacherAttendanceTable, TeacherAttendanceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeacherAttendanceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teacherIdMeta = const VerificationMeta(
    'teacherId',
  );
  @override
  late final GeneratedColumn<String> teacherId = GeneratedColumn<String>(
    'teacher_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkInTimeMeta = const VerificationMeta(
    'checkInTime',
  );
  @override
  late final GeneratedColumn<String> checkInTime = GeneratedColumn<String>(
    'check_in_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _markedByMeta = const VerificationMeta(
    'markedBy',
  );
  @override
  late final GeneratedColumn<String> markedBy = GeneratedColumn<String>(
    'marked_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _markedAtMeta = const VerificationMeta(
    'markedAt',
  );
  @override
  late final GeneratedColumn<String> markedAt = GeneratedColumn<String>(
    'marked_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    teacherId,
    date,
    status,
    checkInTime,
    remarks,
    markedBy,
    markedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teacher_attendance';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeacherAttendanceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('teacher_id')) {
      context.handle(
        _teacherIdMeta,
        teacherId.isAcceptableOrUnknown(data['teacher_id']!, _teacherIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teacherIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('check_in_time')) {
      context.handle(
        _checkInTimeMeta,
        checkInTime.isAcceptableOrUnknown(
          data['check_in_time']!,
          _checkInTimeMeta,
        ),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    if (data.containsKey('marked_by')) {
      context.handle(
        _markedByMeta,
        markedBy.isAcceptableOrUnknown(data['marked_by']!, _markedByMeta),
      );
    } else if (isInserting) {
      context.missing(_markedByMeta);
    }
    if (data.containsKey('marked_at')) {
      context.handle(
        _markedAtMeta,
        markedAt.isAcceptableOrUnknown(data['marked_at']!, _markedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_markedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {teacherId, date},
  ];
  @override
  TeacherAttendanceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeacherAttendanceRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      teacherId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}teacher_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      checkInTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_in_time'],
      ),
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      ),
      markedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marked_by'],
      )!,
      markedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marked_at'],
      )!,
    );
  }

  @override
  $TeacherAttendanceTable createAlias(String alias) {
    return $TeacherAttendanceTable(attachedDatabase, alias);
  }
}

class TeacherAttendanceRow extends DataClass
    implements Insertable<TeacherAttendanceRow> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String teacherId;

  /// DATE as `YYYY-MM-DD`, local calendar — same rules as student attendance.
  final String date;

  /// `AttendanceStatus.wire` — the same five states, deliberately. One enum
  /// serves both registers.
  final String status;

  /// `'08:05'`. Wall-clock text, not a timestamp: it is a time of day and
  /// never needs a timezone. Null when the office did not record arrival.
  final String? checkInTime;

  /// 'Medical leave', 'Official duty'. Free text — leave categories vary by
  /// school and guessing at this one's HR policy would be worse than nothing.
  final String? remarks;
  final String markedBy;
  final String markedAt;
  const TeacherAttendanceRow({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.teacherId,
    required this.date,
    required this.status,
    this.checkInTime,
    this.remarks,
    required this.markedBy,
    required this.markedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['teacher_id'] = Variable<String>(teacherId);
    map['date'] = Variable<String>(date);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || checkInTime != null) {
      map['check_in_time'] = Variable<String>(checkInTime);
    }
    if (!nullToAbsent || remarks != null) {
      map['remarks'] = Variable<String>(remarks);
    }
    map['marked_by'] = Variable<String>(markedBy);
    map['marked_at'] = Variable<String>(markedAt);
    return map;
  }

  TeacherAttendanceCompanion toCompanion(bool nullToAbsent) {
    return TeacherAttendanceCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      teacherId: Value(teacherId),
      date: Value(date),
      status: Value(status),
      checkInTime: checkInTime == null && nullToAbsent
          ? const Value.absent()
          : Value(checkInTime),
      remarks: remarks == null && nullToAbsent
          ? const Value.absent()
          : Value(remarks),
      markedBy: Value(markedBy),
      markedAt: Value(markedAt),
    );
  }

  factory TeacherAttendanceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeacherAttendanceRow(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      teacherId: serializer.fromJson<String>(json['teacher_id']),
      date: serializer.fromJson<String>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      checkInTime: serializer.fromJson<String?>(json['check_in_time']),
      remarks: serializer.fromJson<String?>(json['remarks']),
      markedBy: serializer.fromJson<String>(json['marked_by']),
      markedAt: serializer.fromJson<String>(json['marked_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'teacher_id': serializer.toJson<String>(teacherId),
      'date': serializer.toJson<String>(date),
      'status': serializer.toJson<String>(status),
      'check_in_time': serializer.toJson<String?>(checkInTime),
      'remarks': serializer.toJson<String?>(remarks),
      'marked_by': serializer.toJson<String>(markedBy),
      'marked_at': serializer.toJson<String>(markedAt),
    };
  }

  TeacherAttendanceRow copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? teacherId,
    String? date,
    String? status,
    Value<String?> checkInTime = const Value.absent(),
    Value<String?> remarks = const Value.absent(),
    String? markedBy,
    String? markedAt,
  }) => TeacherAttendanceRow(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    teacherId: teacherId ?? this.teacherId,
    date: date ?? this.date,
    status: status ?? this.status,
    checkInTime: checkInTime.present ? checkInTime.value : this.checkInTime,
    remarks: remarks.present ? remarks.value : this.remarks,
    markedBy: markedBy ?? this.markedBy,
    markedAt: markedAt ?? this.markedAt,
  );
  TeacherAttendanceRow copyWithCompanion(TeacherAttendanceCompanion data) {
    return TeacherAttendanceRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      teacherId: data.teacherId.present ? data.teacherId.value : this.teacherId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      checkInTime: data.checkInTime.present
          ? data.checkInTime.value
          : this.checkInTime,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      markedBy: data.markedBy.present ? data.markedBy.value : this.markedBy,
      markedAt: data.markedAt.present ? data.markedAt.value : this.markedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeacherAttendanceRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('teacherId: $teacherId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('checkInTime: $checkInTime, ')
          ..write('remarks: $remarks, ')
          ..write('markedBy: $markedBy, ')
          ..write('markedAt: $markedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    teacherId,
    date,
    status,
    checkInTime,
    remarks,
    markedBy,
    markedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeacherAttendanceRow &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.teacherId == this.teacherId &&
          other.date == this.date &&
          other.status == this.status &&
          other.checkInTime == this.checkInTime &&
          other.remarks == this.remarks &&
          other.markedBy == this.markedBy &&
          other.markedAt == this.markedAt);
}

class TeacherAttendanceCompanion extends UpdateCompanion<TeacherAttendanceRow> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> teacherId;
  final Value<String> date;
  final Value<String> status;
  final Value<String?> checkInTime;
  final Value<String?> remarks;
  final Value<String> markedBy;
  final Value<String> markedAt;
  final Value<int> rowid;
  const TeacherAttendanceCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.checkInTime = const Value.absent(),
    this.remarks = const Value.absent(),
    this.markedBy = const Value.absent(),
    this.markedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeacherAttendanceCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String teacherId,
    required String date,
    required String status,
    this.checkInTime = const Value.absent(),
    this.remarks = const Value.absent(),
    required String markedBy,
    required String markedAt,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       teacherId = Value(teacherId),
       date = Value(date),
       status = Value(status),
       markedBy = Value(markedBy),
       markedAt = Value(markedAt);
  static Insertable<TeacherAttendanceRow> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? teacherId,
    Expression<String>? date,
    Expression<String>? status,
    Expression<String>? checkInTime,
    Expression<String>? remarks,
    Expression<String>? markedBy,
    Expression<String>? markedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (teacherId != null) 'teacher_id': teacherId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (checkInTime != null) 'check_in_time': checkInTime,
      if (remarks != null) 'remarks': remarks,
      if (markedBy != null) 'marked_by': markedBy,
      if (markedAt != null) 'marked_at': markedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeacherAttendanceCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? teacherId,
    Value<String>? date,
    Value<String>? status,
    Value<String?>? checkInTime,
    Value<String?>? remarks,
    Value<String>? markedBy,
    Value<String>? markedAt,
    Value<int>? rowid,
  }) {
    return TeacherAttendanceCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      teacherId: teacherId ?? this.teacherId,
      date: date ?? this.date,
      status: status ?? this.status,
      checkInTime: checkInTime ?? this.checkInTime,
      remarks: remarks ?? this.remarks,
      markedBy: markedBy ?? this.markedBy,
      markedAt: markedAt ?? this.markedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (teacherId.present) {
      map['teacher_id'] = Variable<String>(teacherId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (checkInTime.present) {
      map['check_in_time'] = Variable<String>(checkInTime.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (markedBy.present) {
      map['marked_by'] = Variable<String>(markedBy.value);
    }
    if (markedAt.present) {
      map['marked_at'] = Variable<String>(markedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeacherAttendanceCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('teacherId: $teacherId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('checkInTime: $checkInTime, ')
          ..write('remarks: $remarks, ')
          ..write('markedBy: $markedBy, ')
          ..write('markedAt: $markedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamsTable extends Exams with TableInfo<$ExamsTable, Exam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _academicYearIdMeta = const VerificationMeta(
    'academicYearId',
  );
  @override
  late final GeneratedColumn<String> academicYearId = GeneratedColumn<String>(
    'academic_year_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _examTypeMeta = const VerificationMeta(
    'examType',
  );
  @override
  late final GeneratedColumn<String> examType = GeneratedColumn<String>(
    'exam_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPublishedMeta = const VerificationMeta(
    'isPublished',
  );
  @override
  late final GeneratedColumn<bool> isPublished = GeneratedColumn<bool>(
    'is_published',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_published" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    academicYearId,
    name,
    examType,
    startDate,
    endDate,
    isPublished,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exams';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exam> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('academic_year_id')) {
      context.handle(
        _academicYearIdMeta,
        academicYearId.isAcceptableOrUnknown(
          data['academic_year_id']!,
          _academicYearIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_academicYearIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('exam_type')) {
      context.handle(
        _examTypeMeta,
        examType.isAcceptableOrUnknown(data['exam_type']!, _examTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_examTypeMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('is_published')) {
      context.handle(
        _isPublishedMeta,
        isPublished.isAcceptableOrUnknown(
          data['is_published']!,
          _isPublishedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exam(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      academicYearId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}academic_year_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      examType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exam_type'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_date'],
      ),
      isPublished: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_published'],
      )!,
    );
  }

  @override
  $ExamsTable createAlias(String alias) {
    return $ExamsTable(attachedDatabase, alias);
  }
}

class Exam extends DataClass implements Insertable<Exam> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String academicYearId;

  /// `'First Term'`.
  final String name;

  /// `ExamType.wire` — `first_term` | `mid_term` | `final_term` | `test` |
  /// `quiz`.
  final String examType;
  final String? startDate;
  final String? endDate;

  /// The gate. False means hidden from students.
  ///
  /// The principal enters marks over several days, then flips one switch and
  /// every student sees their result at once. It stops half-entered results
  /// leaking, and it is a good demo beat (CLAUDE.md §8).
  ///
  /// Enforced server-side too: the student RLS policy on `marks` joins to
  /// `exams` and requires `is_published`, so this is not merely a UI filter.
  final bool isPublished;
  const Exam({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.academicYearId,
    required this.name,
    required this.examType,
    this.startDate,
    this.endDate,
    required this.isPublished,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['academic_year_id'] = Variable<String>(academicYearId);
    map['name'] = Variable<String>(name);
    map['exam_type'] = Variable<String>(examType);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<String>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    map['is_published'] = Variable<bool>(isPublished);
    return map;
  }

  ExamsCompanion toCompanion(bool nullToAbsent) {
    return ExamsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      academicYearId: Value(academicYearId),
      name: Value(name),
      examType: Value(examType),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      isPublished: Value(isPublished),
    );
  }

  factory Exam.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exam(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      academicYearId: serializer.fromJson<String>(json['academic_year_id']),
      name: serializer.fromJson<String>(json['name']),
      examType: serializer.fromJson<String>(json['exam_type']),
      startDate: serializer.fromJson<String?>(json['start_date']),
      endDate: serializer.fromJson<String?>(json['end_date']),
      isPublished: serializer.fromJson<bool>(json['is_published']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'academic_year_id': serializer.toJson<String>(academicYearId),
      'name': serializer.toJson<String>(name),
      'exam_type': serializer.toJson<String>(examType),
      'start_date': serializer.toJson<String?>(startDate),
      'end_date': serializer.toJson<String?>(endDate),
      'is_published': serializer.toJson<bool>(isPublished),
    };
  }

  Exam copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? academicYearId,
    String? name,
    String? examType,
    Value<String?> startDate = const Value.absent(),
    Value<String?> endDate = const Value.absent(),
    bool? isPublished,
  }) => Exam(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    academicYearId: academicYearId ?? this.academicYearId,
    name: name ?? this.name,
    examType: examType ?? this.examType,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    isPublished: isPublished ?? this.isPublished,
  );
  Exam copyWithCompanion(ExamsCompanion data) {
    return Exam(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      academicYearId: data.academicYearId.present
          ? data.academicYearId.value
          : this.academicYearId,
      name: data.name.present ? data.name.value : this.name,
      examType: data.examType.present ? data.examType.value : this.examType,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      isPublished: data.isPublished.present
          ? data.isPublished.value
          : this.isPublished,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exam(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('academicYearId: $academicYearId, ')
          ..write('name: $name, ')
          ..write('examType: $examType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isPublished: $isPublished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    academicYearId,
    name,
    examType,
    startDate,
    endDate,
    isPublished,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exam &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.academicYearId == this.academicYearId &&
          other.name == this.name &&
          other.examType == this.examType &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.isPublished == this.isPublished);
}

class ExamsCompanion extends UpdateCompanion<Exam> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> academicYearId;
  final Value<String> name;
  final Value<String> examType;
  final Value<String?> startDate;
  final Value<String?> endDate;
  final Value<bool> isPublished;
  final Value<int> rowid;
  const ExamsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.academicYearId = const Value.absent(),
    this.name = const Value.absent(),
    this.examType = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isPublished = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String academicYearId,
    required String name,
    required String examType,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isPublished = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       academicYearId = Value(academicYearId),
       name = Value(name),
       examType = Value(examType);
  static Insertable<Exam> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? academicYearId,
    Expression<String>? name,
    Expression<String>? examType,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<bool>? isPublished,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (academicYearId != null) 'academic_year_id': academicYearId,
      if (name != null) 'name': name,
      if (examType != null) 'exam_type': examType,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (isPublished != null) 'is_published': isPublished,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamsCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? academicYearId,
    Value<String>? name,
    Value<String>? examType,
    Value<String?>? startDate,
    Value<String?>? endDate,
    Value<bool>? isPublished,
    Value<int>? rowid,
  }) {
    return ExamsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      academicYearId: academicYearId ?? this.academicYearId,
      name: name ?? this.name,
      examType: examType ?? this.examType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isPublished: isPublished ?? this.isPublished,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (academicYearId.present) {
      map['academic_year_id'] = Variable<String>(academicYearId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (examType.present) {
      map['exam_type'] = Variable<String>(examType.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (isPublished.present) {
      map['is_published'] = Variable<bool>(isPublished.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('academicYearId: $academicYearId, ')
          ..write('name: $name, ')
          ..write('examType: $examType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isPublished: $isPublished, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MarksTable extends Marks with TableInfo<$MarksTable, Mark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<String> examId = GeneratedColumn<String>(
    'exam_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _obtainedMarksMeta = const VerificationMeta(
    'obtainedMarks',
  );
  @override
  late final GeneratedColumn<double> obtainedMarks = GeneratedColumn<double>(
    'obtained_marks',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalMarksMeta = const VerificationMeta(
    'totalMarks',
  );
  @override
  late final GeneratedColumn<double> totalMarks = GeneratedColumn<double>(
    'total_marks',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(100),
  );
  static const VerificationMeta _isAbsentMeta = const VerificationMeta(
    'isAbsent',
  );
  @override
  late final GeneratedColumn<bool> isAbsent = GeneratedColumn<bool>(
    'is_absent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_absent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enteredByMeta = const VerificationMeta(
    'enteredBy',
  );
  @override
  late final GeneratedColumn<String> enteredBy = GeneratedColumn<String>(
    'entered_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    examId,
    studentId,
    subjectId,
    classId,
    obtainedMarks,
    totalMarks,
    isAbsent,
    grade,
    remarks,
    enteredBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'marks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Mark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('exam_id')) {
      context.handle(
        _examIdMeta,
        examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta),
      );
    } else if (isInserting) {
      context.missing(_examIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('obtained_marks')) {
      context.handle(
        _obtainedMarksMeta,
        obtainedMarks.isAcceptableOrUnknown(
          data['obtained_marks']!,
          _obtainedMarksMeta,
        ),
      );
    }
    if (data.containsKey('total_marks')) {
      context.handle(
        _totalMarksMeta,
        totalMarks.isAcceptableOrUnknown(data['total_marks']!, _totalMarksMeta),
      );
    }
    if (data.containsKey('is_absent')) {
      context.handle(
        _isAbsentMeta,
        isAbsent.isAcceptableOrUnknown(data['is_absent']!, _isAbsentMeta),
      );
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    if (data.containsKey('entered_by')) {
      context.handle(
        _enteredByMeta,
        enteredBy.isAcceptableOrUnknown(data['entered_by']!, _enteredByMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {examId, studentId, subjectId},
  ];
  @override
  Mark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Mark(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      examId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exam_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
      obtainedMarks: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}obtained_marks'],
      ),
      totalMarks: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_marks'],
      )!,
      isAbsent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_absent'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      ),
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      ),
      enteredBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entered_by'],
      ),
    );
  }

  @override
  $MarksTable createAlias(String alias) {
    return $MarksTable(attachedDatabase, alias);
  }
}

class Mark extends DataClass implements Insertable<Mark> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String examId;
  final String studentId;
  final String subjectId;
  final String classId;

  /// NUMERIC(6,2) → REAL. Null while the paper is unmarked.
  final double? obtainedMarks;
  final double totalMarks;
  final bool isAbsent;

  /// `'A+'`, `'A'`, … Computed on save via `gradeForMarks` in grading.dart.
  ///
  /// Denormalised deliberately: the report card and the student's marksheet
  /// must show the same letter forever, even if the school changes its scale
  /// next year.
  final String? grade;
  final String? remarks;
  final String? enteredBy;
  const Mark({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.examId,
    required this.studentId,
    required this.subjectId,
    required this.classId,
    this.obtainedMarks,
    required this.totalMarks,
    required this.isAbsent,
    this.grade,
    this.remarks,
    this.enteredBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['exam_id'] = Variable<String>(examId);
    map['student_id'] = Variable<String>(studentId);
    map['subject_id'] = Variable<String>(subjectId);
    map['class_id'] = Variable<String>(classId);
    if (!nullToAbsent || obtainedMarks != null) {
      map['obtained_marks'] = Variable<double>(obtainedMarks);
    }
    map['total_marks'] = Variable<double>(totalMarks);
    map['is_absent'] = Variable<bool>(isAbsent);
    if (!nullToAbsent || grade != null) {
      map['grade'] = Variable<String>(grade);
    }
    if (!nullToAbsent || remarks != null) {
      map['remarks'] = Variable<String>(remarks);
    }
    if (!nullToAbsent || enteredBy != null) {
      map['entered_by'] = Variable<String>(enteredBy);
    }
    return map;
  }

  MarksCompanion toCompanion(bool nullToAbsent) {
    return MarksCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      examId: Value(examId),
      studentId: Value(studentId),
      subjectId: Value(subjectId),
      classId: Value(classId),
      obtainedMarks: obtainedMarks == null && nullToAbsent
          ? const Value.absent()
          : Value(obtainedMarks),
      totalMarks: Value(totalMarks),
      isAbsent: Value(isAbsent),
      grade: grade == null && nullToAbsent
          ? const Value.absent()
          : Value(grade),
      remarks: remarks == null && nullToAbsent
          ? const Value.absent()
          : Value(remarks),
      enteredBy: enteredBy == null && nullToAbsent
          ? const Value.absent()
          : Value(enteredBy),
    );
  }

  factory Mark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Mark(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      examId: serializer.fromJson<String>(json['exam_id']),
      studentId: serializer.fromJson<String>(json['student_id']),
      subjectId: serializer.fromJson<String>(json['subject_id']),
      classId: serializer.fromJson<String>(json['class_id']),
      obtainedMarks: serializer.fromJson<double?>(json['obtained_marks']),
      totalMarks: serializer.fromJson<double>(json['total_marks']),
      isAbsent: serializer.fromJson<bool>(json['is_absent']),
      grade: serializer.fromJson<String?>(json['grade']),
      remarks: serializer.fromJson<String?>(json['remarks']),
      enteredBy: serializer.fromJson<String?>(json['entered_by']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'exam_id': serializer.toJson<String>(examId),
      'student_id': serializer.toJson<String>(studentId),
      'subject_id': serializer.toJson<String>(subjectId),
      'class_id': serializer.toJson<String>(classId),
      'obtained_marks': serializer.toJson<double?>(obtainedMarks),
      'total_marks': serializer.toJson<double>(totalMarks),
      'is_absent': serializer.toJson<bool>(isAbsent),
      'grade': serializer.toJson<String?>(grade),
      'remarks': serializer.toJson<String?>(remarks),
      'entered_by': serializer.toJson<String?>(enteredBy),
    };
  }

  Mark copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? examId,
    String? studentId,
    String? subjectId,
    String? classId,
    Value<double?> obtainedMarks = const Value.absent(),
    double? totalMarks,
    bool? isAbsent,
    Value<String?> grade = const Value.absent(),
    Value<String?> remarks = const Value.absent(),
    Value<String?> enteredBy = const Value.absent(),
  }) => Mark(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    examId: examId ?? this.examId,
    studentId: studentId ?? this.studentId,
    subjectId: subjectId ?? this.subjectId,
    classId: classId ?? this.classId,
    obtainedMarks: obtainedMarks.present
        ? obtainedMarks.value
        : this.obtainedMarks,
    totalMarks: totalMarks ?? this.totalMarks,
    isAbsent: isAbsent ?? this.isAbsent,
    grade: grade.present ? grade.value : this.grade,
    remarks: remarks.present ? remarks.value : this.remarks,
    enteredBy: enteredBy.present ? enteredBy.value : this.enteredBy,
  );
  Mark copyWithCompanion(MarksCompanion data) {
    return Mark(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      examId: data.examId.present ? data.examId.value : this.examId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      classId: data.classId.present ? data.classId.value : this.classId,
      obtainedMarks: data.obtainedMarks.present
          ? data.obtainedMarks.value
          : this.obtainedMarks,
      totalMarks: data.totalMarks.present
          ? data.totalMarks.value
          : this.totalMarks,
      isAbsent: data.isAbsent.present ? data.isAbsent.value : this.isAbsent,
      grade: data.grade.present ? data.grade.value : this.grade,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      enteredBy: data.enteredBy.present ? data.enteredBy.value : this.enteredBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Mark(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('examId: $examId, ')
          ..write('studentId: $studentId, ')
          ..write('subjectId: $subjectId, ')
          ..write('classId: $classId, ')
          ..write('obtainedMarks: $obtainedMarks, ')
          ..write('totalMarks: $totalMarks, ')
          ..write('isAbsent: $isAbsent, ')
          ..write('grade: $grade, ')
          ..write('remarks: $remarks, ')
          ..write('enteredBy: $enteredBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    examId,
    studentId,
    subjectId,
    classId,
    obtainedMarks,
    totalMarks,
    isAbsent,
    grade,
    remarks,
    enteredBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mark &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.examId == this.examId &&
          other.studentId == this.studentId &&
          other.subjectId == this.subjectId &&
          other.classId == this.classId &&
          other.obtainedMarks == this.obtainedMarks &&
          other.totalMarks == this.totalMarks &&
          other.isAbsent == this.isAbsent &&
          other.grade == this.grade &&
          other.remarks == this.remarks &&
          other.enteredBy == this.enteredBy);
}

class MarksCompanion extends UpdateCompanion<Mark> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> examId;
  final Value<String> studentId;
  final Value<String> subjectId;
  final Value<String> classId;
  final Value<double?> obtainedMarks;
  final Value<double> totalMarks;
  final Value<bool> isAbsent;
  final Value<String?> grade;
  final Value<String?> remarks;
  final Value<String?> enteredBy;
  final Value<int> rowid;
  const MarksCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.examId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.classId = const Value.absent(),
    this.obtainedMarks = const Value.absent(),
    this.totalMarks = const Value.absent(),
    this.isAbsent = const Value.absent(),
    this.grade = const Value.absent(),
    this.remarks = const Value.absent(),
    this.enteredBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MarksCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String examId,
    required String studentId,
    required String subjectId,
    required String classId,
    this.obtainedMarks = const Value.absent(),
    this.totalMarks = const Value.absent(),
    this.isAbsent = const Value.absent(),
    this.grade = const Value.absent(),
    this.remarks = const Value.absent(),
    this.enteredBy = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       examId = Value(examId),
       studentId = Value(studentId),
       subjectId = Value(subjectId),
       classId = Value(classId);
  static Insertable<Mark> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? examId,
    Expression<String>? studentId,
    Expression<String>? subjectId,
    Expression<String>? classId,
    Expression<double>? obtainedMarks,
    Expression<double>? totalMarks,
    Expression<bool>? isAbsent,
    Expression<String>? grade,
    Expression<String>? remarks,
    Expression<String>? enteredBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (examId != null) 'exam_id': examId,
      if (studentId != null) 'student_id': studentId,
      if (subjectId != null) 'subject_id': subjectId,
      if (classId != null) 'class_id': classId,
      if (obtainedMarks != null) 'obtained_marks': obtainedMarks,
      if (totalMarks != null) 'total_marks': totalMarks,
      if (isAbsent != null) 'is_absent': isAbsent,
      if (grade != null) 'grade': grade,
      if (remarks != null) 'remarks': remarks,
      if (enteredBy != null) 'entered_by': enteredBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MarksCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? examId,
    Value<String>? studentId,
    Value<String>? subjectId,
    Value<String>? classId,
    Value<double?>? obtainedMarks,
    Value<double>? totalMarks,
    Value<bool>? isAbsent,
    Value<String?>? grade,
    Value<String?>? remarks,
    Value<String?>? enteredBy,
    Value<int>? rowid,
  }) {
    return MarksCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      examId: examId ?? this.examId,
      studentId: studentId ?? this.studentId,
      subjectId: subjectId ?? this.subjectId,
      classId: classId ?? this.classId,
      obtainedMarks: obtainedMarks ?? this.obtainedMarks,
      totalMarks: totalMarks ?? this.totalMarks,
      isAbsent: isAbsent ?? this.isAbsent,
      grade: grade ?? this.grade,
      remarks: remarks ?? this.remarks,
      enteredBy: enteredBy ?? this.enteredBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<String>(examId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (obtainedMarks.present) {
      map['obtained_marks'] = Variable<double>(obtainedMarks.value);
    }
    if (totalMarks.present) {
      map['total_marks'] = Variable<double>(totalMarks.value);
    }
    if (isAbsent.present) {
      map['is_absent'] = Variable<bool>(isAbsent.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (enteredBy.present) {
      map['entered_by'] = Variable<String>(enteredBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MarksCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('examId: $examId, ')
          ..write('studentId: $studentId, ')
          ..write('subjectId: $subjectId, ')
          ..write('classId: $classId, ')
          ..write('obtainedMarks: $obtainedMarks, ')
          ..write('totalMarks: $totalMarks, ')
          ..write('isAbsent: $isAbsent, ')
          ..write('grade: $grade, ')
          ..write('remarks: $remarks, ')
          ..write('enteredBy: $enteredBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeeStructuresTable extends FeeStructures
    with TableInfo<$FeeStructuresTable, FeeStructure> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeeStructuresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _academicYearIdMeta = const VerificationMeta(
    'academicYearId',
  );
  @override
  late final GeneratedColumn<String> academicYearId = GeneratedColumn<String>(
    'academic_year_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tuitionFeeMeta = const VerificationMeta(
    'tuitionFee',
  );
  @override
  late final GeneratedColumn<double> tuitionFee = GeneratedColumn<double>(
    'tuition_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _admissionFeeMeta = const VerificationMeta(
    'admissionFee',
  );
  @override
  late final GeneratedColumn<double> admissionFee = GeneratedColumn<double>(
    'admission_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _examFeeMeta = const VerificationMeta(
    'examFee',
  );
  @override
  late final GeneratedColumn<double> examFee = GeneratedColumn<double>(
    'exam_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _otherFeeMeta = const VerificationMeta(
    'otherFee',
  );
  @override
  late final GeneratedColumn<double> otherFee = GeneratedColumn<double>(
    'other_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _otherLabelMeta = const VerificationMeta(
    'otherLabel',
  );
  @override
  late final GeneratedColumn<String> otherLabel = GeneratedColumn<String>(
    'other_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    academicYearId,
    classId,
    tuitionFee,
    admissionFee,
    examFee,
    otherFee,
    otherLabel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fee_structures';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeeStructure> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('academic_year_id')) {
      context.handle(
        _academicYearIdMeta,
        academicYearId.isAcceptableOrUnknown(
          data['academic_year_id']!,
          _academicYearIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_academicYearIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    }
    if (data.containsKey('tuition_fee')) {
      context.handle(
        _tuitionFeeMeta,
        tuitionFee.isAcceptableOrUnknown(data['tuition_fee']!, _tuitionFeeMeta),
      );
    }
    if (data.containsKey('admission_fee')) {
      context.handle(
        _admissionFeeMeta,
        admissionFee.isAcceptableOrUnknown(
          data['admission_fee']!,
          _admissionFeeMeta,
        ),
      );
    }
    if (data.containsKey('exam_fee')) {
      context.handle(
        _examFeeMeta,
        examFee.isAcceptableOrUnknown(data['exam_fee']!, _examFeeMeta),
      );
    }
    if (data.containsKey('other_fee')) {
      context.handle(
        _otherFeeMeta,
        otherFee.isAcceptableOrUnknown(data['other_fee']!, _otherFeeMeta),
      );
    }
    if (data.containsKey('other_label')) {
      context.handle(
        _otherLabelMeta,
        otherLabel.isAcceptableOrUnknown(data['other_label']!, _otherLabelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeeStructure map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeeStructure(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      academicYearId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}academic_year_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      ),
      tuitionFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tuition_fee'],
      )!,
      admissionFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}admission_fee'],
      )!,
      examFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exam_fee'],
      )!,
      otherFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}other_fee'],
      )!,
      otherLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_label'],
      ),
    );
  }

  @override
  $FeeStructuresTable createAlias(String alias) {
    return $FeeStructuresTable(attachedDatabase, alias);
  }
}

class FeeStructure extends DataClass implements Insertable<FeeStructure> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String academicYearId;

  /// Null means the structure applies school-wide.
  final String? classId;

  /// All money is PKR, NUMERIC(10,2) → REAL.
  final double tuitionFee;
  final double admissionFee;
  final double examFee;
  final double otherFee;
  final String? otherLabel;
  const FeeStructure({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.academicYearId,
    this.classId,
    required this.tuitionFee,
    required this.admissionFee,
    required this.examFee,
    required this.otherFee,
    this.otherLabel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['academic_year_id'] = Variable<String>(academicYearId);
    if (!nullToAbsent || classId != null) {
      map['class_id'] = Variable<String>(classId);
    }
    map['tuition_fee'] = Variable<double>(tuitionFee);
    map['admission_fee'] = Variable<double>(admissionFee);
    map['exam_fee'] = Variable<double>(examFee);
    map['other_fee'] = Variable<double>(otherFee);
    if (!nullToAbsent || otherLabel != null) {
      map['other_label'] = Variable<String>(otherLabel);
    }
    return map;
  }

  FeeStructuresCompanion toCompanion(bool nullToAbsent) {
    return FeeStructuresCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      academicYearId: Value(academicYearId),
      classId: classId == null && nullToAbsent
          ? const Value.absent()
          : Value(classId),
      tuitionFee: Value(tuitionFee),
      admissionFee: Value(admissionFee),
      examFee: Value(examFee),
      otherFee: Value(otherFee),
      otherLabel: otherLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(otherLabel),
    );
  }

  factory FeeStructure.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeeStructure(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      academicYearId: serializer.fromJson<String>(json['academic_year_id']),
      classId: serializer.fromJson<String?>(json['class_id']),
      tuitionFee: serializer.fromJson<double>(json['tuition_fee']),
      admissionFee: serializer.fromJson<double>(json['admission_fee']),
      examFee: serializer.fromJson<double>(json['exam_fee']),
      otherFee: serializer.fromJson<double>(json['other_fee']),
      otherLabel: serializer.fromJson<String?>(json['other_label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'academic_year_id': serializer.toJson<String>(academicYearId),
      'class_id': serializer.toJson<String?>(classId),
      'tuition_fee': serializer.toJson<double>(tuitionFee),
      'admission_fee': serializer.toJson<double>(admissionFee),
      'exam_fee': serializer.toJson<double>(examFee),
      'other_fee': serializer.toJson<double>(otherFee),
      'other_label': serializer.toJson<String?>(otherLabel),
    };
  }

  FeeStructure copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? academicYearId,
    Value<String?> classId = const Value.absent(),
    double? tuitionFee,
    double? admissionFee,
    double? examFee,
    double? otherFee,
    Value<String?> otherLabel = const Value.absent(),
  }) => FeeStructure(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    academicYearId: academicYearId ?? this.academicYearId,
    classId: classId.present ? classId.value : this.classId,
    tuitionFee: tuitionFee ?? this.tuitionFee,
    admissionFee: admissionFee ?? this.admissionFee,
    examFee: examFee ?? this.examFee,
    otherFee: otherFee ?? this.otherFee,
    otherLabel: otherLabel.present ? otherLabel.value : this.otherLabel,
  );
  FeeStructure copyWithCompanion(FeeStructuresCompanion data) {
    return FeeStructure(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      academicYearId: data.academicYearId.present
          ? data.academicYearId.value
          : this.academicYearId,
      classId: data.classId.present ? data.classId.value : this.classId,
      tuitionFee: data.tuitionFee.present
          ? data.tuitionFee.value
          : this.tuitionFee,
      admissionFee: data.admissionFee.present
          ? data.admissionFee.value
          : this.admissionFee,
      examFee: data.examFee.present ? data.examFee.value : this.examFee,
      otherFee: data.otherFee.present ? data.otherFee.value : this.otherFee,
      otherLabel: data.otherLabel.present
          ? data.otherLabel.value
          : this.otherLabel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeeStructure(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('academicYearId: $academicYearId, ')
          ..write('classId: $classId, ')
          ..write('tuitionFee: $tuitionFee, ')
          ..write('admissionFee: $admissionFee, ')
          ..write('examFee: $examFee, ')
          ..write('otherFee: $otherFee, ')
          ..write('otherLabel: $otherLabel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    academicYearId,
    classId,
    tuitionFee,
    admissionFee,
    examFee,
    otherFee,
    otherLabel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeeStructure &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.academicYearId == this.academicYearId &&
          other.classId == this.classId &&
          other.tuitionFee == this.tuitionFee &&
          other.admissionFee == this.admissionFee &&
          other.examFee == this.examFee &&
          other.otherFee == this.otherFee &&
          other.otherLabel == this.otherLabel);
}

class FeeStructuresCompanion extends UpdateCompanion<FeeStructure> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> academicYearId;
  final Value<String?> classId;
  final Value<double> tuitionFee;
  final Value<double> admissionFee;
  final Value<double> examFee;
  final Value<double> otherFee;
  final Value<String?> otherLabel;
  final Value<int> rowid;
  const FeeStructuresCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.academicYearId = const Value.absent(),
    this.classId = const Value.absent(),
    this.tuitionFee = const Value.absent(),
    this.admissionFee = const Value.absent(),
    this.examFee = const Value.absent(),
    this.otherFee = const Value.absent(),
    this.otherLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeeStructuresCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String academicYearId,
    this.classId = const Value.absent(),
    this.tuitionFee = const Value.absent(),
    this.admissionFee = const Value.absent(),
    this.examFee = const Value.absent(),
    this.otherFee = const Value.absent(),
    this.otherLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       academicYearId = Value(academicYearId);
  static Insertable<FeeStructure> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? academicYearId,
    Expression<String>? classId,
    Expression<double>? tuitionFee,
    Expression<double>? admissionFee,
    Expression<double>? examFee,
    Expression<double>? otherFee,
    Expression<String>? otherLabel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (academicYearId != null) 'academic_year_id': academicYearId,
      if (classId != null) 'class_id': classId,
      if (tuitionFee != null) 'tuition_fee': tuitionFee,
      if (admissionFee != null) 'admission_fee': admissionFee,
      if (examFee != null) 'exam_fee': examFee,
      if (otherFee != null) 'other_fee': otherFee,
      if (otherLabel != null) 'other_label': otherLabel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeeStructuresCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? academicYearId,
    Value<String?>? classId,
    Value<double>? tuitionFee,
    Value<double>? admissionFee,
    Value<double>? examFee,
    Value<double>? otherFee,
    Value<String?>? otherLabel,
    Value<int>? rowid,
  }) {
    return FeeStructuresCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      academicYearId: academicYearId ?? this.academicYearId,
      classId: classId ?? this.classId,
      tuitionFee: tuitionFee ?? this.tuitionFee,
      admissionFee: admissionFee ?? this.admissionFee,
      examFee: examFee ?? this.examFee,
      otherFee: otherFee ?? this.otherFee,
      otherLabel: otherLabel ?? this.otherLabel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (academicYearId.present) {
      map['academic_year_id'] = Variable<String>(academicYearId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (tuitionFee.present) {
      map['tuition_fee'] = Variable<double>(tuitionFee.value);
    }
    if (admissionFee.present) {
      map['admission_fee'] = Variable<double>(admissionFee.value);
    }
    if (examFee.present) {
      map['exam_fee'] = Variable<double>(examFee.value);
    }
    if (otherFee.present) {
      map['other_fee'] = Variable<double>(otherFee.value);
    }
    if (otherLabel.present) {
      map['other_label'] = Variable<String>(otherLabel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeeStructuresCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('academicYearId: $academicYearId, ')
          ..write('classId: $classId, ')
          ..write('tuitionFee: $tuitionFee, ')
          ..write('admissionFee: $admissionFee, ')
          ..write('examFee: $examFee, ')
          ..write('otherFee: $otherFee, ')
          ..write('otherLabel: $otherLabel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeeChallansTable extends FeeChallans
    with TableInfo<$FeeChallansTable, FeeChallan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeeChallansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _challanNoMeta = const VerificationMeta(
    'challanNo',
  );
  @override
  late final GeneratedColumn<String> challanNo = GeneratedColumn<String>(
    'challan_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tuitionFeeMeta = const VerificationMeta(
    'tuitionFee',
  );
  @override
  late final GeneratedColumn<double> tuitionFee = GeneratedColumn<double>(
    'tuition_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _admissionFeeMeta = const VerificationMeta(
    'admissionFee',
  );
  @override
  late final GeneratedColumn<double> admissionFee = GeneratedColumn<double>(
    'admission_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _examFeeMeta = const VerificationMeta(
    'examFee',
  );
  @override
  late final GeneratedColumn<double> examFee = GeneratedColumn<double>(
    'exam_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _otherFeeMeta = const VerificationMeta(
    'otherFee',
  );
  @override
  late final GeneratedColumn<double> otherFee = GeneratedColumn<double>(
    'other_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _arrearsMeta = const VerificationMeta(
    'arrears',
  );
  @override
  late final GeneratedColumn<double> arrears = GeneratedColumn<double>(
    'arrears',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fineMeta = const VerificationMeta('fine');
  @override
  late final GeneratedColumn<double> fine = GeneratedColumn<double>(
    'fine',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<String> issueDate = GeneratedColumn<String>(
    'issue_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unpaid'),
  );
  static const VerificationMeta _paidAmountMeta = const VerificationMeta(
    'paidAmount',
  );
  @override
  late final GeneratedColumn<double> paidAmount = GeneratedColumn<double>(
    'paid_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paidDateMeta = const VerificationMeta(
    'paidDate',
  );
  @override
  late final GeneratedColumn<String> paidDate = GeneratedColumn<String>(
    'paid_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receivedByMeta = const VerificationMeta(
    'receivedBy',
  );
  @override
  late final GeneratedColumn<String> receivedBy = GeneratedColumn<String>(
    'received_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    studentId,
    classId,
    challanNo,
    month,
    year,
    title,
    tuitionFee,
    admissionFee,
    examFee,
    otherFee,
    arrears,
    discount,
    fine,
    totalAmount,
    issueDate,
    dueDate,
    status,
    paidAmount,
    paidDate,
    paymentMethod,
    receivedBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fee_challans';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeeChallan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('challan_no')) {
      context.handle(
        _challanNoMeta,
        challanNo.isAcceptableOrUnknown(data['challan_no']!, _challanNoMeta),
      );
    } else if (isInserting) {
      context.missing(_challanNoMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('tuition_fee')) {
      context.handle(
        _tuitionFeeMeta,
        tuitionFee.isAcceptableOrUnknown(data['tuition_fee']!, _tuitionFeeMeta),
      );
    }
    if (data.containsKey('admission_fee')) {
      context.handle(
        _admissionFeeMeta,
        admissionFee.isAcceptableOrUnknown(
          data['admission_fee']!,
          _admissionFeeMeta,
        ),
      );
    }
    if (data.containsKey('exam_fee')) {
      context.handle(
        _examFeeMeta,
        examFee.isAcceptableOrUnknown(data['exam_fee']!, _examFeeMeta),
      );
    }
    if (data.containsKey('other_fee')) {
      context.handle(
        _otherFeeMeta,
        otherFee.isAcceptableOrUnknown(data['other_fee']!, _otherFeeMeta),
      );
    }
    if (data.containsKey('arrears')) {
      context.handle(
        _arrearsMeta,
        arrears.isAcceptableOrUnknown(data['arrears']!, _arrearsMeta),
      );
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('fine')) {
      context.handle(
        _fineMeta,
        fine.isAcceptableOrUnknown(data['fine']!, _fineMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_issueDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
        _paidAmountMeta,
        paidAmount.isAcceptableOrUnknown(data['paid_amount']!, _paidAmountMeta),
      );
    }
    if (data.containsKey('paid_date')) {
      context.handle(
        _paidDateMeta,
        paidDate.isAcceptableOrUnknown(data['paid_date']!, _paidDateMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('received_by')) {
      context.handle(
        _receivedByMeta,
        receivedBy.isAcceptableOrUnknown(data['received_by']!, _receivedByMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {studentId, month, year, title},
  ];
  @override
  FeeChallan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeeChallan(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
      challanNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challan_no'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      tuitionFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tuition_fee'],
      )!,
      admissionFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}admission_fee'],
      )!,
      examFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exam_fee'],
      )!,
      otherFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}other_fee'],
      )!,
      arrears: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}arrears'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      fine: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fine'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issue_date'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      paidAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}paid_amount'],
      )!,
      paidDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paid_date'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      receivedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}received_by'],
      ),
    );
  }

  @override
  $FeeChallansTable createAlias(String alias) {
    return $FeeChallansTable(attachedDatabase, alias);
  }
}

class FeeChallan extends DataClass implements Insertable<FeeChallan> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String studentId;
  final String classId;

  /// `'CH-2026-08-0341'`.
  final String challanNo;

  /// 1..12.
  final int month;
  final int year;

  /// E.g. 'Sports Fine', 'August Tuition'
  final String? title;
  final double tuitionFee;
  final double admissionFee;
  final double examFee;
  final double otherFee;

  /// Unpaid balance carried forward from previous months.
  ///
  /// Without this the bulk generator produces wrong totals from month two and
  /// the school's books never balance (CLAUDE.md §8).
  final double arrears;
  final double discount;
  final double fine;
  final double totalAmount;
  final String issueDate;
  final String dueDate;

  /// `ChallanStatus.wire`, defaulting to `'unpaid'`.
  final String status;
  final double paidAmount;
  final String? paidDate;

  /// `PaymentMethod.wire` — `'cash'` | `'bank'` | `'online'`.
  final String? paymentMethod;
  final String? receivedBy;
  const FeeChallan({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.studentId,
    required this.classId,
    required this.challanNo,
    required this.month,
    required this.year,
    this.title,
    required this.tuitionFee,
    required this.admissionFee,
    required this.examFee,
    required this.otherFee,
    required this.arrears,
    required this.discount,
    required this.fine,
    required this.totalAmount,
    required this.issueDate,
    required this.dueDate,
    required this.status,
    required this.paidAmount,
    this.paidDate,
    this.paymentMethod,
    this.receivedBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['student_id'] = Variable<String>(studentId);
    map['class_id'] = Variable<String>(classId);
    map['challan_no'] = Variable<String>(challanNo);
    map['month'] = Variable<int>(month);
    map['year'] = Variable<int>(year);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['tuition_fee'] = Variable<double>(tuitionFee);
    map['admission_fee'] = Variable<double>(admissionFee);
    map['exam_fee'] = Variable<double>(examFee);
    map['other_fee'] = Variable<double>(otherFee);
    map['arrears'] = Variable<double>(arrears);
    map['discount'] = Variable<double>(discount);
    map['fine'] = Variable<double>(fine);
    map['total_amount'] = Variable<double>(totalAmount);
    map['issue_date'] = Variable<String>(issueDate);
    map['due_date'] = Variable<String>(dueDate);
    map['status'] = Variable<String>(status);
    map['paid_amount'] = Variable<double>(paidAmount);
    if (!nullToAbsent || paidDate != null) {
      map['paid_date'] = Variable<String>(paidDate);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    if (!nullToAbsent || receivedBy != null) {
      map['received_by'] = Variable<String>(receivedBy);
    }
    return map;
  }

  FeeChallansCompanion toCompanion(bool nullToAbsent) {
    return FeeChallansCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      studentId: Value(studentId),
      classId: Value(classId),
      challanNo: Value(challanNo),
      month: Value(month),
      year: Value(year),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      tuitionFee: Value(tuitionFee),
      admissionFee: Value(admissionFee),
      examFee: Value(examFee),
      otherFee: Value(otherFee),
      arrears: Value(arrears),
      discount: Value(discount),
      fine: Value(fine),
      totalAmount: Value(totalAmount),
      issueDate: Value(issueDate),
      dueDate: Value(dueDate),
      status: Value(status),
      paidAmount: Value(paidAmount),
      paidDate: paidDate == null && nullToAbsent
          ? const Value.absent()
          : Value(paidDate),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      receivedBy: receivedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedBy),
    );
  }

  factory FeeChallan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeeChallan(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      studentId: serializer.fromJson<String>(json['student_id']),
      classId: serializer.fromJson<String>(json['class_id']),
      challanNo: serializer.fromJson<String>(json['challan_no']),
      month: serializer.fromJson<int>(json['month']),
      year: serializer.fromJson<int>(json['year']),
      title: serializer.fromJson<String?>(json['title']),
      tuitionFee: serializer.fromJson<double>(json['tuition_fee']),
      admissionFee: serializer.fromJson<double>(json['admission_fee']),
      examFee: serializer.fromJson<double>(json['exam_fee']),
      otherFee: serializer.fromJson<double>(json['other_fee']),
      arrears: serializer.fromJson<double>(json['arrears']),
      discount: serializer.fromJson<double>(json['discount']),
      fine: serializer.fromJson<double>(json['fine']),
      totalAmount: serializer.fromJson<double>(json['total_amount']),
      issueDate: serializer.fromJson<String>(json['issue_date']),
      dueDate: serializer.fromJson<String>(json['due_date']),
      status: serializer.fromJson<String>(json['status']),
      paidAmount: serializer.fromJson<double>(json['paid_amount']),
      paidDate: serializer.fromJson<String?>(json['paid_date']),
      paymentMethod: serializer.fromJson<String?>(json['payment_method']),
      receivedBy: serializer.fromJson<String?>(json['received_by']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'student_id': serializer.toJson<String>(studentId),
      'class_id': serializer.toJson<String>(classId),
      'challan_no': serializer.toJson<String>(challanNo),
      'month': serializer.toJson<int>(month),
      'year': serializer.toJson<int>(year),
      'title': serializer.toJson<String?>(title),
      'tuition_fee': serializer.toJson<double>(tuitionFee),
      'admission_fee': serializer.toJson<double>(admissionFee),
      'exam_fee': serializer.toJson<double>(examFee),
      'other_fee': serializer.toJson<double>(otherFee),
      'arrears': serializer.toJson<double>(arrears),
      'discount': serializer.toJson<double>(discount),
      'fine': serializer.toJson<double>(fine),
      'total_amount': serializer.toJson<double>(totalAmount),
      'issue_date': serializer.toJson<String>(issueDate),
      'due_date': serializer.toJson<String>(dueDate),
      'status': serializer.toJson<String>(status),
      'paid_amount': serializer.toJson<double>(paidAmount),
      'paid_date': serializer.toJson<String?>(paidDate),
      'payment_method': serializer.toJson<String?>(paymentMethod),
      'received_by': serializer.toJson<String?>(receivedBy),
    };
  }

  FeeChallan copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? studentId,
    String? classId,
    String? challanNo,
    int? month,
    int? year,
    Value<String?> title = const Value.absent(),
    double? tuitionFee,
    double? admissionFee,
    double? examFee,
    double? otherFee,
    double? arrears,
    double? discount,
    double? fine,
    double? totalAmount,
    String? issueDate,
    String? dueDate,
    String? status,
    double? paidAmount,
    Value<String?> paidDate = const Value.absent(),
    Value<String?> paymentMethod = const Value.absent(),
    Value<String?> receivedBy = const Value.absent(),
  }) => FeeChallan(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    studentId: studentId ?? this.studentId,
    classId: classId ?? this.classId,
    challanNo: challanNo ?? this.challanNo,
    month: month ?? this.month,
    year: year ?? this.year,
    title: title.present ? title.value : this.title,
    tuitionFee: tuitionFee ?? this.tuitionFee,
    admissionFee: admissionFee ?? this.admissionFee,
    examFee: examFee ?? this.examFee,
    otherFee: otherFee ?? this.otherFee,
    arrears: arrears ?? this.arrears,
    discount: discount ?? this.discount,
    fine: fine ?? this.fine,
    totalAmount: totalAmount ?? this.totalAmount,
    issueDate: issueDate ?? this.issueDate,
    dueDate: dueDate ?? this.dueDate,
    status: status ?? this.status,
    paidAmount: paidAmount ?? this.paidAmount,
    paidDate: paidDate.present ? paidDate.value : this.paidDate,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    receivedBy: receivedBy.present ? receivedBy.value : this.receivedBy,
  );
  FeeChallan copyWithCompanion(FeeChallansCompanion data) {
    return FeeChallan(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      classId: data.classId.present ? data.classId.value : this.classId,
      challanNo: data.challanNo.present ? data.challanNo.value : this.challanNo,
      month: data.month.present ? data.month.value : this.month,
      year: data.year.present ? data.year.value : this.year,
      title: data.title.present ? data.title.value : this.title,
      tuitionFee: data.tuitionFee.present
          ? data.tuitionFee.value
          : this.tuitionFee,
      admissionFee: data.admissionFee.present
          ? data.admissionFee.value
          : this.admissionFee,
      examFee: data.examFee.present ? data.examFee.value : this.examFee,
      otherFee: data.otherFee.present ? data.otherFee.value : this.otherFee,
      arrears: data.arrears.present ? data.arrears.value : this.arrears,
      discount: data.discount.present ? data.discount.value : this.discount,
      fine: data.fine.present ? data.fine.value : this.fine,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      status: data.status.present ? data.status.value : this.status,
      paidAmount: data.paidAmount.present
          ? data.paidAmount.value
          : this.paidAmount,
      paidDate: data.paidDate.present ? data.paidDate.value : this.paidDate,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      receivedBy: data.receivedBy.present
          ? data.receivedBy.value
          : this.receivedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeeChallan(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('studentId: $studentId, ')
          ..write('classId: $classId, ')
          ..write('challanNo: $challanNo, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('title: $title, ')
          ..write('tuitionFee: $tuitionFee, ')
          ..write('admissionFee: $admissionFee, ')
          ..write('examFee: $examFee, ')
          ..write('otherFee: $otherFee, ')
          ..write('arrears: $arrears, ')
          ..write('discount: $discount, ')
          ..write('fine: $fine, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('issueDate: $issueDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('paidDate: $paidDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('receivedBy: $receivedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    studentId,
    classId,
    challanNo,
    month,
    year,
    title,
    tuitionFee,
    admissionFee,
    examFee,
    otherFee,
    arrears,
    discount,
    fine,
    totalAmount,
    issueDate,
    dueDate,
    status,
    paidAmount,
    paidDate,
    paymentMethod,
    receivedBy,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeeChallan &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.studentId == this.studentId &&
          other.classId == this.classId &&
          other.challanNo == this.challanNo &&
          other.month == this.month &&
          other.year == this.year &&
          other.title == this.title &&
          other.tuitionFee == this.tuitionFee &&
          other.admissionFee == this.admissionFee &&
          other.examFee == this.examFee &&
          other.otherFee == this.otherFee &&
          other.arrears == this.arrears &&
          other.discount == this.discount &&
          other.fine == this.fine &&
          other.totalAmount == this.totalAmount &&
          other.issueDate == this.issueDate &&
          other.dueDate == this.dueDate &&
          other.status == this.status &&
          other.paidAmount == this.paidAmount &&
          other.paidDate == this.paidDate &&
          other.paymentMethod == this.paymentMethod &&
          other.receivedBy == this.receivedBy);
}

class FeeChallansCompanion extends UpdateCompanion<FeeChallan> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> studentId;
  final Value<String> classId;
  final Value<String> challanNo;
  final Value<int> month;
  final Value<int> year;
  final Value<String?> title;
  final Value<double> tuitionFee;
  final Value<double> admissionFee;
  final Value<double> examFee;
  final Value<double> otherFee;
  final Value<double> arrears;
  final Value<double> discount;
  final Value<double> fine;
  final Value<double> totalAmount;
  final Value<String> issueDate;
  final Value<String> dueDate;
  final Value<String> status;
  final Value<double> paidAmount;
  final Value<String?> paidDate;
  final Value<String?> paymentMethod;
  final Value<String?> receivedBy;
  final Value<int> rowid;
  const FeeChallansCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.classId = const Value.absent(),
    this.challanNo = const Value.absent(),
    this.month = const Value.absent(),
    this.year = const Value.absent(),
    this.title = const Value.absent(),
    this.tuitionFee = const Value.absent(),
    this.admissionFee = const Value.absent(),
    this.examFee = const Value.absent(),
    this.otherFee = const Value.absent(),
    this.arrears = const Value.absent(),
    this.discount = const Value.absent(),
    this.fine = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.status = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.paidDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.receivedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeeChallansCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String studentId,
    required String classId,
    required String challanNo,
    required int month,
    required int year,
    this.title = const Value.absent(),
    this.tuitionFee = const Value.absent(),
    this.admissionFee = const Value.absent(),
    this.examFee = const Value.absent(),
    this.otherFee = const Value.absent(),
    this.arrears = const Value.absent(),
    this.discount = const Value.absent(),
    this.fine = const Value.absent(),
    required double totalAmount,
    required String issueDate,
    required String dueDate,
    this.status = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.paidDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.receivedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       studentId = Value(studentId),
       classId = Value(classId),
       challanNo = Value(challanNo),
       month = Value(month),
       year = Value(year),
       totalAmount = Value(totalAmount),
       issueDate = Value(issueDate),
       dueDate = Value(dueDate);
  static Insertable<FeeChallan> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? studentId,
    Expression<String>? classId,
    Expression<String>? challanNo,
    Expression<int>? month,
    Expression<int>? year,
    Expression<String>? title,
    Expression<double>? tuitionFee,
    Expression<double>? admissionFee,
    Expression<double>? examFee,
    Expression<double>? otherFee,
    Expression<double>? arrears,
    Expression<double>? discount,
    Expression<double>? fine,
    Expression<double>? totalAmount,
    Expression<String>? issueDate,
    Expression<String>? dueDate,
    Expression<String>? status,
    Expression<double>? paidAmount,
    Expression<String>? paidDate,
    Expression<String>? paymentMethod,
    Expression<String>? receivedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (studentId != null) 'student_id': studentId,
      if (classId != null) 'class_id': classId,
      if (challanNo != null) 'challan_no': challanNo,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (title != null) 'title': title,
      if (tuitionFee != null) 'tuition_fee': tuitionFee,
      if (admissionFee != null) 'admission_fee': admissionFee,
      if (examFee != null) 'exam_fee': examFee,
      if (otherFee != null) 'other_fee': otherFee,
      if (arrears != null) 'arrears': arrears,
      if (discount != null) 'discount': discount,
      if (fine != null) 'fine': fine,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (issueDate != null) 'issue_date': issueDate,
      if (dueDate != null) 'due_date': dueDate,
      if (status != null) 'status': status,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (paidDate != null) 'paid_date': paidDate,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (receivedBy != null) 'received_by': receivedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeeChallansCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? studentId,
    Value<String>? classId,
    Value<String>? challanNo,
    Value<int>? month,
    Value<int>? year,
    Value<String?>? title,
    Value<double>? tuitionFee,
    Value<double>? admissionFee,
    Value<double>? examFee,
    Value<double>? otherFee,
    Value<double>? arrears,
    Value<double>? discount,
    Value<double>? fine,
    Value<double>? totalAmount,
    Value<String>? issueDate,
    Value<String>? dueDate,
    Value<String>? status,
    Value<double>? paidAmount,
    Value<String?>? paidDate,
    Value<String?>? paymentMethod,
    Value<String?>? receivedBy,
    Value<int>? rowid,
  }) {
    return FeeChallansCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      studentId: studentId ?? this.studentId,
      classId: classId ?? this.classId,
      challanNo: challanNo ?? this.challanNo,
      month: month ?? this.month,
      year: year ?? this.year,
      title: title ?? this.title,
      tuitionFee: tuitionFee ?? this.tuitionFee,
      admissionFee: admissionFee ?? this.admissionFee,
      examFee: examFee ?? this.examFee,
      otherFee: otherFee ?? this.otherFee,
      arrears: arrears ?? this.arrears,
      discount: discount ?? this.discount,
      fine: fine ?? this.fine,
      totalAmount: totalAmount ?? this.totalAmount,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      paidAmount: paidAmount ?? this.paidAmount,
      paidDate: paidDate ?? this.paidDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      receivedBy: receivedBy ?? this.receivedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (challanNo.present) {
      map['challan_no'] = Variable<String>(challanNo.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (tuitionFee.present) {
      map['tuition_fee'] = Variable<double>(tuitionFee.value);
    }
    if (admissionFee.present) {
      map['admission_fee'] = Variable<double>(admissionFee.value);
    }
    if (examFee.present) {
      map['exam_fee'] = Variable<double>(examFee.value);
    }
    if (otherFee.present) {
      map['other_fee'] = Variable<double>(otherFee.value);
    }
    if (arrears.present) {
      map['arrears'] = Variable<double>(arrears.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (fine.present) {
      map['fine'] = Variable<double>(fine.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<String>(issueDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<double>(paidAmount.value);
    }
    if (paidDate.present) {
      map['paid_date'] = Variable<String>(paidDate.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (receivedBy.present) {
      map['received_by'] = Variable<String>(receivedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeeChallansCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('studentId: $studentId, ')
          ..write('classId: $classId, ')
          ..write('challanNo: $challanNo, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('title: $title, ')
          ..write('tuitionFee: $tuitionFee, ')
          ..write('admissionFee: $admissionFee, ')
          ..write('examFee: $examFee, ')
          ..write('otherFee: $otherFee, ')
          ..write('arrears: $arrears, ')
          ..write('discount: $discount, ')
          ..write('fine: $fine, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('issueDate: $issueDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('paidDate: $paidDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('receivedBy: $receivedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimetableSlotsTable extends TimetableSlots
    with TableInfo<$TimetableSlotsTable, TimetableSlot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimetableSlotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _teacherIdMeta = const VerificationMeta(
    'teacherId',
  );
  @override
  late final GeneratedColumn<String> teacherId = GeneratedColumn<String>(
    'teacher_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dayOfWeekMeta = const VerificationMeta(
    'dayOfWeek',
  );
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
    'day_of_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodNoMeta = const VerificationMeta(
    'periodNo',
  );
  @override
  late final GeneratedColumn<int> periodNo = GeneratedColumn<int>(
    'period_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slotTypeMeta = const VerificationMeta(
    'slotType',
  );
  @override
  late final GeneratedColumn<String> slotType = GeneratedColumn<String>(
    'slot_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('class'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    classId,
    subjectId,
    teacherId,
    dayOfWeek,
    periodNo,
    startTime,
    endTime,
    slotType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timetable_slots';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimetableSlot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    }
    if (data.containsKey('teacher_id')) {
      context.handle(
        _teacherIdMeta,
        teacherId.isAcceptableOrUnknown(data['teacher_id']!, _teacherIdMeta),
      );
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
        _dayOfWeekMeta,
        dayOfWeek.isAcceptableOrUnknown(data['day_of_week']!, _dayOfWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('period_no')) {
      context.handle(
        _periodNoMeta,
        periodNo.isAcceptableOrUnknown(data['period_no']!, _periodNoMeta),
      );
    } else if (isInserting) {
      context.missing(_periodNoMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('slot_type')) {
      context.handle(
        _slotTypeMeta,
        slotType.isAcceptableOrUnknown(data['slot_type']!, _slotTypeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {classId, dayOfWeek, periodNo},
  ];
  @override
  TimetableSlot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimetableSlot(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      ),
      teacherId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}teacher_id'],
      ),
      dayOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_week'],
      )!,
      periodNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}period_no'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_time'],
      )!,
      slotType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slot_type'],
      )!,
    );
  }

  @override
  $TimetableSlotsTable createAlias(String alias) {
    return $TimetableSlotsTable(attachedDatabase, alias);
  }
}

class TimetableSlot extends DataClass implements Insertable<TimetableSlot> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String classId;

  /// Null for a break or assembly.
  final String? subjectId;
  final String? teacherId;

  /// 1..7, where 1 = Monday.
  final int dayOfWeek;
  final int periodNo;

  /// `'08:00'` — wall-clock strings, not timestamps.
  final String startTime;
  final String endTime;

  /// `SlotType.wire` — `'class'` | `'break'` | `'assembly'`.
  final String slotType;
  const TimetableSlot({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.classId,
    this.subjectId,
    this.teacherId,
    required this.dayOfWeek,
    required this.periodNo,
    required this.startTime,
    required this.endTime,
    required this.slotType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['class_id'] = Variable<String>(classId);
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<String>(subjectId);
    }
    if (!nullToAbsent || teacherId != null) {
      map['teacher_id'] = Variable<String>(teacherId);
    }
    map['day_of_week'] = Variable<int>(dayOfWeek);
    map['period_no'] = Variable<int>(periodNo);
    map['start_time'] = Variable<String>(startTime);
    map['end_time'] = Variable<String>(endTime);
    map['slot_type'] = Variable<String>(slotType);
    return map;
  }

  TimetableSlotsCompanion toCompanion(bool nullToAbsent) {
    return TimetableSlotsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      classId: Value(classId),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
      teacherId: teacherId == null && nullToAbsent
          ? const Value.absent()
          : Value(teacherId),
      dayOfWeek: Value(dayOfWeek),
      periodNo: Value(periodNo),
      startTime: Value(startTime),
      endTime: Value(endTime),
      slotType: Value(slotType),
    );
  }

  factory TimetableSlot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimetableSlot(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      classId: serializer.fromJson<String>(json['class_id']),
      subjectId: serializer.fromJson<String?>(json['subject_id']),
      teacherId: serializer.fromJson<String?>(json['teacher_id']),
      dayOfWeek: serializer.fromJson<int>(json['day_of_week']),
      periodNo: serializer.fromJson<int>(json['period_no']),
      startTime: serializer.fromJson<String>(json['start_time']),
      endTime: serializer.fromJson<String>(json['end_time']),
      slotType: serializer.fromJson<String>(json['slot_type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'class_id': serializer.toJson<String>(classId),
      'subject_id': serializer.toJson<String?>(subjectId),
      'teacher_id': serializer.toJson<String?>(teacherId),
      'day_of_week': serializer.toJson<int>(dayOfWeek),
      'period_no': serializer.toJson<int>(periodNo),
      'start_time': serializer.toJson<String>(startTime),
      'end_time': serializer.toJson<String>(endTime),
      'slot_type': serializer.toJson<String>(slotType),
    };
  }

  TimetableSlot copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? classId,
    Value<String?> subjectId = const Value.absent(),
    Value<String?> teacherId = const Value.absent(),
    int? dayOfWeek,
    int? periodNo,
    String? startTime,
    String? endTime,
    String? slotType,
  }) => TimetableSlot(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    classId: classId ?? this.classId,
    subjectId: subjectId.present ? subjectId.value : this.subjectId,
    teacherId: teacherId.present ? teacherId.value : this.teacherId,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    periodNo: periodNo ?? this.periodNo,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    slotType: slotType ?? this.slotType,
  );
  TimetableSlot copyWithCompanion(TimetableSlotsCompanion data) {
    return TimetableSlot(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      classId: data.classId.present ? data.classId.value : this.classId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      teacherId: data.teacherId.present ? data.teacherId.value : this.teacherId,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      periodNo: data.periodNo.present ? data.periodNo.value : this.periodNo,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      slotType: data.slotType.present ? data.slotType.value : this.slotType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimetableSlot(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('subjectId: $subjectId, ')
          ..write('teacherId: $teacherId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('periodNo: $periodNo, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('slotType: $slotType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    classId,
    subjectId,
    teacherId,
    dayOfWeek,
    periodNo,
    startTime,
    endTime,
    slotType,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimetableSlot &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.classId == this.classId &&
          other.subjectId == this.subjectId &&
          other.teacherId == this.teacherId &&
          other.dayOfWeek == this.dayOfWeek &&
          other.periodNo == this.periodNo &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.slotType == this.slotType);
}

class TimetableSlotsCompanion extends UpdateCompanion<TimetableSlot> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> classId;
  final Value<String?> subjectId;
  final Value<String?> teacherId;
  final Value<int> dayOfWeek;
  final Value<int> periodNo;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<String> slotType;
  final Value<int> rowid;
  const TimetableSlotsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.classId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.periodNo = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.slotType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimetableSlotsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String classId,
    this.subjectId = const Value.absent(),
    this.teacherId = const Value.absent(),
    required int dayOfWeek,
    required int periodNo,
    required String startTime,
    required String endTime,
    this.slotType = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       classId = Value(classId),
       dayOfWeek = Value(dayOfWeek),
       periodNo = Value(periodNo),
       startTime = Value(startTime),
       endTime = Value(endTime);
  static Insertable<TimetableSlot> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? classId,
    Expression<String>? subjectId,
    Expression<String>? teacherId,
    Expression<int>? dayOfWeek,
    Expression<int>? periodNo,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<String>? slotType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (classId != null) 'class_id': classId,
      if (subjectId != null) 'subject_id': subjectId,
      if (teacherId != null) 'teacher_id': teacherId,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (periodNo != null) 'period_no': periodNo,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (slotType != null) 'slot_type': slotType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimetableSlotsCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? classId,
    Value<String?>? subjectId,
    Value<String?>? teacherId,
    Value<int>? dayOfWeek,
    Value<int>? periodNo,
    Value<String>? startTime,
    Value<String>? endTime,
    Value<String>? slotType,
    Value<int>? rowid,
  }) {
    return TimetableSlotsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      classId: classId ?? this.classId,
      subjectId: subjectId ?? this.subjectId,
      teacherId: teacherId ?? this.teacherId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      periodNo: periodNo ?? this.periodNo,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      slotType: slotType ?? this.slotType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (teacherId.present) {
      map['teacher_id'] = Variable<String>(teacherId.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (periodNo.present) {
      map['period_no'] = Variable<int>(periodNo.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (slotType.present) {
      map['slot_type'] = Variable<String>(slotType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimetableSlotsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('subjectId: $subjectId, ')
          ..write('teacherId: $teacherId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('periodNo: $periodNo, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('slotType: $slotType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssignmentsTable extends Assignments
    with TableInfo<$AssignmentsTable, Assignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attachmentUrlMeta = const VerificationMeta(
    'attachmentUrl',
  );
  @override
  late final GeneratedColumn<String> attachmentUrl = GeneratedColumn<String>(
    'attachment_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assignedDateMeta = const VerificationMeta(
    'assignedDate',
  );
  @override
  late final GeneratedColumn<String> assignedDate = GeneratedColumn<String>(
    'assigned_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    classId,
    subjectId,
    title,
    description,
    attachmentUrl,
    assignedDate,
    dueDate,
    createdBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assignments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Assignment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('attachment_url')) {
      context.handle(
        _attachmentUrlMeta,
        attachmentUrl.isAcceptableOrUnknown(
          data['attachment_url']!,
          _attachmentUrlMeta,
        ),
      );
    }
    if (data.containsKey('assigned_date')) {
      context.handle(
        _assignedDateMeta,
        assignedDate.isAcceptableOrUnknown(
          data['assigned_date']!,
          _assignedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_assignedDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Assignment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Assignment(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      attachmentUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_url'],
      ),
      assignedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assigned_date'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date'],
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
    );
  }

  @override
  $AssignmentsTable createAlias(String alias) {
    return $AssignmentsTable(attachedDatabase, alias);
  }
}

class Assignment extends DataClass implements Insertable<Assignment> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String classId;
  final String? subjectId;
  final String title;
  final String? description;
  final String? attachmentUrl;
  final String assignedDate;
  final String? dueDate;
  final String? createdBy;
  const Assignment({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.classId,
    this.subjectId,
    required this.title,
    this.description,
    this.attachmentUrl,
    required this.assignedDate,
    this.dueDate,
    this.createdBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['class_id'] = Variable<String>(classId);
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<String>(subjectId);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || attachmentUrl != null) {
      map['attachment_url'] = Variable<String>(attachmentUrl);
    }
    map['assigned_date'] = Variable<String>(assignedDate);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<String>(dueDate);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    return map;
  }

  AssignmentsCompanion toCompanion(bool nullToAbsent) {
    return AssignmentsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      classId: Value(classId),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      attachmentUrl: attachmentUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentUrl),
      assignedDate: Value(assignedDate),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
    );
  }

  factory Assignment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Assignment(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      classId: serializer.fromJson<String>(json['class_id']),
      subjectId: serializer.fromJson<String?>(json['subject_id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      attachmentUrl: serializer.fromJson<String?>(json['attachment_url']),
      assignedDate: serializer.fromJson<String>(json['assigned_date']),
      dueDate: serializer.fromJson<String?>(json['due_date']),
      createdBy: serializer.fromJson<String?>(json['created_by']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'class_id': serializer.toJson<String>(classId),
      'subject_id': serializer.toJson<String?>(subjectId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'attachment_url': serializer.toJson<String?>(attachmentUrl),
      'assigned_date': serializer.toJson<String>(assignedDate),
      'due_date': serializer.toJson<String?>(dueDate),
      'created_by': serializer.toJson<String?>(createdBy),
    };
  }

  Assignment copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? classId,
    Value<String?> subjectId = const Value.absent(),
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> attachmentUrl = const Value.absent(),
    String? assignedDate,
    Value<String?> dueDate = const Value.absent(),
    Value<String?> createdBy = const Value.absent(),
  }) => Assignment(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    classId: classId ?? this.classId,
    subjectId: subjectId.present ? subjectId.value : this.subjectId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    attachmentUrl: attachmentUrl.present
        ? attachmentUrl.value
        : this.attachmentUrl,
    assignedDate: assignedDate ?? this.assignedDate,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
  );
  Assignment copyWithCompanion(AssignmentsCompanion data) {
    return Assignment(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      classId: data.classId.present ? data.classId.value : this.classId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      attachmentUrl: data.attachmentUrl.present
          ? data.attachmentUrl.value
          : this.attachmentUrl,
      assignedDate: data.assignedDate.present
          ? data.assignedDate.value
          : this.assignedDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Assignment(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('attachmentUrl: $attachmentUrl, ')
          ..write('assignedDate: $assignedDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    classId,
    subjectId,
    title,
    description,
    attachmentUrl,
    assignedDate,
    dueDate,
    createdBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Assignment &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.classId == this.classId &&
          other.subjectId == this.subjectId &&
          other.title == this.title &&
          other.description == this.description &&
          other.attachmentUrl == this.attachmentUrl &&
          other.assignedDate == this.assignedDate &&
          other.dueDate == this.dueDate &&
          other.createdBy == this.createdBy);
}

class AssignmentsCompanion extends UpdateCompanion<Assignment> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> classId;
  final Value<String?> subjectId;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> attachmentUrl;
  final Value<String> assignedDate;
  final Value<String?> dueDate;
  final Value<String?> createdBy;
  final Value<int> rowid;
  const AssignmentsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.classId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.attachmentUrl = const Value.absent(),
    this.assignedDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssignmentsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String classId,
    this.subjectId = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.attachmentUrl = const Value.absent(),
    required String assignedDate,
    this.dueDate = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       classId = Value(classId),
       title = Value(title),
       assignedDate = Value(assignedDate);
  static Insertable<Assignment> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? classId,
    Expression<String>? subjectId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? attachmentUrl,
    Expression<String>? assignedDate,
    Expression<String>? dueDate,
    Expression<String>? createdBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (classId != null) 'class_id': classId,
      if (subjectId != null) 'subject_id': subjectId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (attachmentUrl != null) 'attachment_url': attachmentUrl,
      if (assignedDate != null) 'assigned_date': assignedDate,
      if (dueDate != null) 'due_date': dueDate,
      if (createdBy != null) 'created_by': createdBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssignmentsCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? classId,
    Value<String?>? subjectId,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? attachmentUrl,
    Value<String>? assignedDate,
    Value<String?>? dueDate,
    Value<String?>? createdBy,
    Value<int>? rowid,
  }) {
    return AssignmentsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      classId: classId ?? this.classId,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      description: description ?? this.description,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      assignedDate: assignedDate ?? this.assignedDate,
      dueDate: dueDate ?? this.dueDate,
      createdBy: createdBy ?? this.createdBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (attachmentUrl.present) {
      map['attachment_url'] = Variable<String>(attachmentUrl.value);
    }
    if (assignedDate.present) {
      map['assigned_date'] = Variable<String>(assignedDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssignmentsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('attachmentUrl: $attachmentUrl, ')
          ..write('assignedDate: $assignedDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdBy: $createdBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NoticesTable extends Notices with TableInfo<$NoticesTable, Notice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoticesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFacultyOnlyMeta = const VerificationMeta(
    'isFacultyOnly',
  );
  @override
  late final GeneratedColumn<bool> isFacultyOnly = GeneratedColumn<bool>(
    'is_faculty_only',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_faculty_only" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attachmentUrlMeta = const VerificationMeta(
    'attachmentUrl',
  );
  @override
  late final GeneratedColumn<String> attachmentUrl = GeneratedColumn<String>(
    'attachment_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('normal'),
  );
  static const VerificationMeta _publishDateMeta = const VerificationMeta(
    'publishDate',
  );
  @override
  late final GeneratedColumn<String> publishDate = GeneratedColumn<String>(
    'publish_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<String> expiresAt = GeneratedColumn<String>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    classId,
    isFacultyOnly,
    title,
    body,
    attachmentUrl,
    priority,
    publishDate,
    expiresAt,
    createdBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Notice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    }
    if (data.containsKey('is_faculty_only')) {
      context.handle(
        _isFacultyOnlyMeta,
        isFacultyOnly.isAcceptableOrUnknown(
          data['is_faculty_only']!,
          _isFacultyOnlyMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('attachment_url')) {
      context.handle(
        _attachmentUrlMeta,
        attachmentUrl.isAcceptableOrUnknown(
          data['attachment_url']!,
          _attachmentUrlMeta,
        ),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('publish_date')) {
      context.handle(
        _publishDateMeta,
        publishDate.isAcceptableOrUnknown(
          data['publish_date']!,
          _publishDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_publishDateMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notice(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      ),
      isFacultyOnly: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_faculty_only'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      attachmentUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_url'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      publishDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}publish_date'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expires_at'],
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
    );
  }

  @override
  $NoticesTable createAlias(String alias) {
    return $NoticesTable(attachedDatabase, alias);
  }
}

class Notice extends DataClass implements Insertable<Notice> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;

  /// Null means the notice goes to the whole school.
  final String? classId;
  final bool isFacultyOnly;
  final String title;
  final String body;
  final String? attachmentUrl;

  /// `NoticePriority.wire` — `'normal'` | `'important'` | `'urgent'`.
  final String priority;
  final String publishDate;
  final String? expiresAt;
  final String? createdBy;
  const Notice({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    this.classId,
    required this.isFacultyOnly,
    required this.title,
    required this.body,
    this.attachmentUrl,
    required this.priority,
    required this.publishDate,
    this.expiresAt,
    this.createdBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    if (!nullToAbsent || classId != null) {
      map['class_id'] = Variable<String>(classId);
    }
    map['is_faculty_only'] = Variable<bool>(isFacultyOnly);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || attachmentUrl != null) {
      map['attachment_url'] = Variable<String>(attachmentUrl);
    }
    map['priority'] = Variable<String>(priority);
    map['publish_date'] = Variable<String>(publishDate);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<String>(expiresAt);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    return map;
  }

  NoticesCompanion toCompanion(bool nullToAbsent) {
    return NoticesCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      classId: classId == null && nullToAbsent
          ? const Value.absent()
          : Value(classId),
      isFacultyOnly: Value(isFacultyOnly),
      title: Value(title),
      body: Value(body),
      attachmentUrl: attachmentUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentUrl),
      priority: Value(priority),
      publishDate: Value(publishDate),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
    );
  }

  factory Notice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notice(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      classId: serializer.fromJson<String?>(json['class_id']),
      isFacultyOnly: serializer.fromJson<bool>(json['is_faculty_only']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      attachmentUrl: serializer.fromJson<String?>(json['attachment_url']),
      priority: serializer.fromJson<String>(json['priority']),
      publishDate: serializer.fromJson<String>(json['publish_date']),
      expiresAt: serializer.fromJson<String?>(json['expires_at']),
      createdBy: serializer.fromJson<String?>(json['created_by']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'class_id': serializer.toJson<String?>(classId),
      'is_faculty_only': serializer.toJson<bool>(isFacultyOnly),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'attachment_url': serializer.toJson<String?>(attachmentUrl),
      'priority': serializer.toJson<String>(priority),
      'publish_date': serializer.toJson<String>(publishDate),
      'expires_at': serializer.toJson<String?>(expiresAt),
      'created_by': serializer.toJson<String?>(createdBy),
    };
  }

  Notice copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    Value<String?> classId = const Value.absent(),
    bool? isFacultyOnly,
    String? title,
    String? body,
    Value<String?> attachmentUrl = const Value.absent(),
    String? priority,
    String? publishDate,
    Value<String?> expiresAt = const Value.absent(),
    Value<String?> createdBy = const Value.absent(),
  }) => Notice(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    classId: classId.present ? classId.value : this.classId,
    isFacultyOnly: isFacultyOnly ?? this.isFacultyOnly,
    title: title ?? this.title,
    body: body ?? this.body,
    attachmentUrl: attachmentUrl.present
        ? attachmentUrl.value
        : this.attachmentUrl,
    priority: priority ?? this.priority,
    publishDate: publishDate ?? this.publishDate,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
  );
  Notice copyWithCompanion(NoticesCompanion data) {
    return Notice(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      classId: data.classId.present ? data.classId.value : this.classId,
      isFacultyOnly: data.isFacultyOnly.present
          ? data.isFacultyOnly.value
          : this.isFacultyOnly,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      attachmentUrl: data.attachmentUrl.present
          ? data.attachmentUrl.value
          : this.attachmentUrl,
      priority: data.priority.present ? data.priority.value : this.priority,
      publishDate: data.publishDate.present
          ? data.publishDate.value
          : this.publishDate,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notice(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('isFacultyOnly: $isFacultyOnly, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('attachmentUrl: $attachmentUrl, ')
          ..write('priority: $priority, ')
          ..write('publishDate: $publishDate, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    classId,
    isFacultyOnly,
    title,
    body,
    attachmentUrl,
    priority,
    publishDate,
    expiresAt,
    createdBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notice &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.classId == this.classId &&
          other.isFacultyOnly == this.isFacultyOnly &&
          other.title == this.title &&
          other.body == this.body &&
          other.attachmentUrl == this.attachmentUrl &&
          other.priority == this.priority &&
          other.publishDate == this.publishDate &&
          other.expiresAt == this.expiresAt &&
          other.createdBy == this.createdBy);
}

class NoticesCompanion extends UpdateCompanion<Notice> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String?> classId;
  final Value<bool> isFacultyOnly;
  final Value<String> title;
  final Value<String> body;
  final Value<String?> attachmentUrl;
  final Value<String> priority;
  final Value<String> publishDate;
  final Value<String?> expiresAt;
  final Value<String?> createdBy;
  final Value<int> rowid;
  const NoticesCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.classId = const Value.absent(),
    this.isFacultyOnly = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.attachmentUrl = const Value.absent(),
    this.priority = const Value.absent(),
    this.publishDate = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NoticesCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    this.classId = const Value.absent(),
    this.isFacultyOnly = const Value.absent(),
    required String title,
    required String body,
    this.attachmentUrl = const Value.absent(),
    this.priority = const Value.absent(),
    required String publishDate,
    this.expiresAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       title = Value(title),
       body = Value(body),
       publishDate = Value(publishDate);
  static Insertable<Notice> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? classId,
    Expression<bool>? isFacultyOnly,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? attachmentUrl,
    Expression<String>? priority,
    Expression<String>? publishDate,
    Expression<String>? expiresAt,
    Expression<String>? createdBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (classId != null) 'class_id': classId,
      if (isFacultyOnly != null) 'is_faculty_only': isFacultyOnly,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (attachmentUrl != null) 'attachment_url': attachmentUrl,
      if (priority != null) 'priority': priority,
      if (publishDate != null) 'publish_date': publishDate,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (createdBy != null) 'created_by': createdBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NoticesCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String?>? classId,
    Value<bool>? isFacultyOnly,
    Value<String>? title,
    Value<String>? body,
    Value<String?>? attachmentUrl,
    Value<String>? priority,
    Value<String>? publishDate,
    Value<String?>? expiresAt,
    Value<String?>? createdBy,
    Value<int>? rowid,
  }) {
    return NoticesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      classId: classId ?? this.classId,
      isFacultyOnly: isFacultyOnly ?? this.isFacultyOnly,
      title: title ?? this.title,
      body: body ?? this.body,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      priority: priority ?? this.priority,
      publishDate: publishDate ?? this.publishDate,
      expiresAt: expiresAt ?? this.expiresAt,
      createdBy: createdBy ?? this.createdBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (isFacultyOnly.present) {
      map['is_faculty_only'] = Variable<bool>(isFacultyOnly.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (attachmentUrl.present) {
      map['attachment_url'] = Variable<String>(attachmentUrl.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (publishDate.present) {
      map['publish_date'] = Variable<String>(publishDate.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<String>(expiresAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoticesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('isFacultyOnly: $isFacultyOnly, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('attachmentUrl: $attachmentUrl, ')
          ..write('priority: $priority, ')
          ..write('publishDate: $publishDate, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LostItemsTable extends LostItems
    with TableInfo<$LostItemsTable, LostItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LostItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _incidentDateMeta = const VerificationMeta(
    'incidentDate',
  );
  @override
  late final GeneratedColumn<String> incidentDate = GeneratedColumn<String>(
    'incident_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reportedByMeta = const VerificationMeta(
    'reportedBy',
  );
  @override
  late final GeneratedColumn<String> reportedBy = GeneratedColumn<String>(
    'reported_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('open'),
  );
  static const VerificationMeta _moderationMeta = const VerificationMeta(
    'moderation',
  );
  @override
  late final GeneratedColumn<String> moderation = GeneratedColumn<String>(
    'moderation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _reportCountMeta = const VerificationMeta(
    'reportCount',
  );
  @override
  late final GeneratedColumn<int> reportCount = GeneratedColumn<int>(
    'report_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _moderatedByMeta = const VerificationMeta(
    'moderatedBy',
  );
  @override
  late final GeneratedColumn<String> moderatedBy = GeneratedColumn<String>(
    'moderated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photosMeta = const VerificationMeta('photos');
  @override
  late final GeneratedColumn<String> photos = GeneratedColumn<String>(
    'photos',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<String> expiresAt = GeneratedColumn<String>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    type,
    title,
    description,
    category,
    location,
    incidentDate,
    reportedBy,
    status,
    moderation,
    reportCount,
    moderatedBy,
    photos,
    expiresAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lost_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<LostItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('incident_date')) {
      context.handle(
        _incidentDateMeta,
        incidentDate.isAcceptableOrUnknown(
          data['incident_date']!,
          _incidentDateMeta,
        ),
      );
    }
    if (data.containsKey('reported_by')) {
      context.handle(
        _reportedByMeta,
        reportedBy.isAcceptableOrUnknown(data['reported_by']!, _reportedByMeta),
      );
    } else if (isInserting) {
      context.missing(_reportedByMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('moderation')) {
      context.handle(
        _moderationMeta,
        moderation.isAcceptableOrUnknown(data['moderation']!, _moderationMeta),
      );
    }
    if (data.containsKey('report_count')) {
      context.handle(
        _reportCountMeta,
        reportCount.isAcceptableOrUnknown(
          data['report_count']!,
          _reportCountMeta,
        ),
      );
    }
    if (data.containsKey('moderated_by')) {
      context.handle(
        _moderatedByMeta,
        moderatedBy.isAcceptableOrUnknown(
          data['moderated_by']!,
          _moderatedByMeta,
        ),
      );
    }
    if (data.containsKey('photos')) {
      context.handle(
        _photosMeta,
        photos.isAcceptableOrUnknown(data['photos']!, _photosMeta),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LostItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LostItem(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      incidentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}incident_date'],
      ),
      reportedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reported_by'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      moderation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}moderation'],
      )!,
      reportCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}report_count'],
      )!,
      moderatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}moderated_by'],
      ),
      photos: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photos'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expires_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LostItemsTable createAlias(String alias) {
    return $LostItemsTable(attachedDatabase, alias);
  }
}

class LostItem extends DataClass implements Insertable<LostItem> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;

  /// `LostItemType.wire` — `'lost'` | `'found'`.
  final String type;
  final String title;
  final String? description;

  /// `LostItemCategory.wire`.
  final String? category;

  /// `'near canteen'`, `'ground'`.
  final String? location;
  final String? incidentDate;
  final String reportedBy;

  /// `LostItemStatus.wire`, defaulting to `'open'`.
  final String status;

  /// `ModerationState.wire`, defaulting to `'pending'`.
  final String moderation;

  /// Auto-hides at `autoHideReportCount` (policy.dart).
  final int reportCount;
  final String? moderatedBy;

  /// JSONB → TEXT: a json array of `{key, url, thumb_url}`.
  ///
  /// Photos NEVER travel through the sync log — separate pipeline, file first
  /// then row, or peers pull a row whose image 404s (CLAUDE.md §10).
  final String photos;

  /// When the item auto-archives and its photos are deleted.
  final String? expiresAt;

  /// When the item was posted.
  ///
  /// NOTE — this column is missing from schema.sql as committed: the index
  /// `idx_lost_items_feed` at schema.sql:482 already sorts on `created_at`, so
  /// that CREATE INDEX fails against a fresh Postgres. It is also required for
  /// the 30-day expiry sweep and for the weekly per-student post limit. Adding
  /// it to schema.sql is a contract change — tell the student-app dev.
  final String createdAt;
  const LostItem({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.type,
    required this.title,
    this.description,
    this.category,
    this.location,
    this.incidentDate,
    required this.reportedBy,
    required this.status,
    required this.moderation,
    required this.reportCount,
    this.moderatedBy,
    required this.photos,
    this.expiresAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || incidentDate != null) {
      map['incident_date'] = Variable<String>(incidentDate);
    }
    map['reported_by'] = Variable<String>(reportedBy);
    map['status'] = Variable<String>(status);
    map['moderation'] = Variable<String>(moderation);
    map['report_count'] = Variable<int>(reportCount);
    if (!nullToAbsent || moderatedBy != null) {
      map['moderated_by'] = Variable<String>(moderatedBy);
    }
    map['photos'] = Variable<String>(photos);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<String>(expiresAt);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  LostItemsCompanion toCompanion(bool nullToAbsent) {
    return LostItemsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      type: Value(type),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      incidentDate: incidentDate == null && nullToAbsent
          ? const Value.absent()
          : Value(incidentDate),
      reportedBy: Value(reportedBy),
      status: Value(status),
      moderation: Value(moderation),
      reportCount: Value(reportCount),
      moderatedBy: moderatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(moderatedBy),
      photos: Value(photos),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      createdAt: Value(createdAt),
    );
  }

  factory LostItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LostItem(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String?>(json['category']),
      location: serializer.fromJson<String?>(json['location']),
      incidentDate: serializer.fromJson<String?>(json['incident_date']),
      reportedBy: serializer.fromJson<String>(json['reported_by']),
      status: serializer.fromJson<String>(json['status']),
      moderation: serializer.fromJson<String>(json['moderation']),
      reportCount: serializer.fromJson<int>(json['report_count']),
      moderatedBy: serializer.fromJson<String?>(json['moderated_by']),
      photos: serializer.fromJson<String>(json['photos']),
      expiresAt: serializer.fromJson<String?>(json['expires_at']),
      createdAt: serializer.fromJson<String>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String?>(category),
      'location': serializer.toJson<String?>(location),
      'incident_date': serializer.toJson<String?>(incidentDate),
      'reported_by': serializer.toJson<String>(reportedBy),
      'status': serializer.toJson<String>(status),
      'moderation': serializer.toJson<String>(moderation),
      'report_count': serializer.toJson<int>(reportCount),
      'moderated_by': serializer.toJson<String?>(moderatedBy),
      'photos': serializer.toJson<String>(photos),
      'expires_at': serializer.toJson<String?>(expiresAt),
      'created_at': serializer.toJson<String>(createdAt),
    };
  }

  LostItem copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? type,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> category = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<String?> incidentDate = const Value.absent(),
    String? reportedBy,
    String? status,
    String? moderation,
    int? reportCount,
    Value<String?> moderatedBy = const Value.absent(),
    String? photos,
    Value<String?> expiresAt = const Value.absent(),
    String? createdAt,
  }) => LostItem(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    type: type ?? this.type,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    category: category.present ? category.value : this.category,
    location: location.present ? location.value : this.location,
    incidentDate: incidentDate.present ? incidentDate.value : this.incidentDate,
    reportedBy: reportedBy ?? this.reportedBy,
    status: status ?? this.status,
    moderation: moderation ?? this.moderation,
    reportCount: reportCount ?? this.reportCount,
    moderatedBy: moderatedBy.present ? moderatedBy.value : this.moderatedBy,
    photos: photos ?? this.photos,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    createdAt: createdAt ?? this.createdAt,
  );
  LostItem copyWithCompanion(LostItemsCompanion data) {
    return LostItem(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      location: data.location.present ? data.location.value : this.location,
      incidentDate: data.incidentDate.present
          ? data.incidentDate.value
          : this.incidentDate,
      reportedBy: data.reportedBy.present
          ? data.reportedBy.value
          : this.reportedBy,
      status: data.status.present ? data.status.value : this.status,
      moderation: data.moderation.present
          ? data.moderation.value
          : this.moderation,
      reportCount: data.reportCount.present
          ? data.reportCount.value
          : this.reportCount,
      moderatedBy: data.moderatedBy.present
          ? data.moderatedBy.value
          : this.moderatedBy,
      photos: data.photos.present ? data.photos.value : this.photos,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LostItem(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('location: $location, ')
          ..write('incidentDate: $incidentDate, ')
          ..write('reportedBy: $reportedBy, ')
          ..write('status: $status, ')
          ..write('moderation: $moderation, ')
          ..write('reportCount: $reportCount, ')
          ..write('moderatedBy: $moderatedBy, ')
          ..write('photos: $photos, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    type,
    title,
    description,
    category,
    location,
    incidentDate,
    reportedBy,
    status,
    moderation,
    reportCount,
    moderatedBy,
    photos,
    expiresAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LostItem &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.type == this.type &&
          other.title == this.title &&
          other.description == this.description &&
          other.category == this.category &&
          other.location == this.location &&
          other.incidentDate == this.incidentDate &&
          other.reportedBy == this.reportedBy &&
          other.status == this.status &&
          other.moderation == this.moderation &&
          other.reportCount == this.reportCount &&
          other.moderatedBy == this.moderatedBy &&
          other.photos == this.photos &&
          other.expiresAt == this.expiresAt &&
          other.createdAt == this.createdAt);
}

class LostItemsCompanion extends UpdateCompanion<LostItem> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> type;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> category;
  final Value<String?> location;
  final Value<String?> incidentDate;
  final Value<String> reportedBy;
  final Value<String> status;
  final Value<String> moderation;
  final Value<int> reportCount;
  final Value<String?> moderatedBy;
  final Value<String> photos;
  final Value<String?> expiresAt;
  final Value<String> createdAt;
  final Value<int> rowid;
  const LostItemsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.location = const Value.absent(),
    this.incidentDate = const Value.absent(),
    this.reportedBy = const Value.absent(),
    this.status = const Value.absent(),
    this.moderation = const Value.absent(),
    this.reportCount = const Value.absent(),
    this.moderatedBy = const Value.absent(),
    this.photos = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LostItemsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String type,
    required String title,
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.location = const Value.absent(),
    this.incidentDate = const Value.absent(),
    required String reportedBy,
    this.status = const Value.absent(),
    this.moderation = const Value.absent(),
    this.reportCount = const Value.absent(),
    this.moderatedBy = const Value.absent(),
    this.photos = const Value.absent(),
    this.expiresAt = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       type = Value(type),
       title = Value(title),
       reportedBy = Value(reportedBy),
       createdAt = Value(createdAt);
  static Insertable<LostItem> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? location,
    Expression<String>? incidentDate,
    Expression<String>? reportedBy,
    Expression<String>? status,
    Expression<String>? moderation,
    Expression<int>? reportCount,
    Expression<String>? moderatedBy,
    Expression<String>? photos,
    Expression<String>? expiresAt,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (location != null) 'location': location,
      if (incidentDate != null) 'incident_date': incidentDate,
      if (reportedBy != null) 'reported_by': reportedBy,
      if (status != null) 'status': status,
      if (moderation != null) 'moderation': moderation,
      if (reportCount != null) 'report_count': reportCount,
      if (moderatedBy != null) 'moderated_by': moderatedBy,
      if (photos != null) 'photos': photos,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LostItemsCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? type,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? category,
    Value<String?>? location,
    Value<String?>? incidentDate,
    Value<String>? reportedBy,
    Value<String>? status,
    Value<String>? moderation,
    Value<int>? reportCount,
    Value<String?>? moderatedBy,
    Value<String>? photos,
    Value<String?>? expiresAt,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return LostItemsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      location: location ?? this.location,
      incidentDate: incidentDate ?? this.incidentDate,
      reportedBy: reportedBy ?? this.reportedBy,
      status: status ?? this.status,
      moderation: moderation ?? this.moderation,
      reportCount: reportCount ?? this.reportCount,
      moderatedBy: moderatedBy ?? this.moderatedBy,
      photos: photos ?? this.photos,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (incidentDate.present) {
      map['incident_date'] = Variable<String>(incidentDate.value);
    }
    if (reportedBy.present) {
      map['reported_by'] = Variable<String>(reportedBy.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (moderation.present) {
      map['moderation'] = Variable<String>(moderation.value);
    }
    if (reportCount.present) {
      map['report_count'] = Variable<int>(reportCount.value);
    }
    if (moderatedBy.present) {
      map['moderated_by'] = Variable<String>(moderatedBy.value);
    }
    if (photos.present) {
      map['photos'] = Variable<String>(photos.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<String>(expiresAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LostItemsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('location: $location, ')
          ..write('incidentDate: $incidentDate, ')
          ..write('reportedBy: $reportedBy, ')
          ..write('status: $status, ')
          ..write('moderation: $moderation, ')
          ..write('reportCount: $reportCount, ')
          ..write('moderatedBy: $moderatedBy, ')
          ..write('photos: $photos, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemClaimsTable extends ItemClaims
    with TableInfo<$ItemClaimsTable, ItemClaim> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemClaimsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverSeqMeta = const VerificationMeta(
    'serverSeq',
  );
  @override
  late final GeneratedColumn<int> serverSeq = GeneratedColumn<int>(
    'server_seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolIdMeta = const VerificationMeta(
    'schoolId',
  );
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
    'school_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _claimedByMeta = const VerificationMeta(
    'claimedBy',
  );
  @override
  late final GeneratedColumn<String> claimedBy = GeneratedColumn<String>(
    'claimed_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _handledByMeta = const VerificationMeta(
    'handledBy',
  );
  @override
  late final GeneratedColumn<String> handledBy = GeneratedColumn<String>(
    'handled_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    itemId,
    claimedBy,
    message,
    status,
    handledBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_claims';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItemClaim> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_seq')) {
      context.handle(
        _serverSeqMeta,
        serverSeq.isAcceptableOrUnknown(data['server_seq']!, _serverSeqMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(
        _schoolIdMeta,
        schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('claimed_by')) {
      context.handle(
        _claimedByMeta,
        claimedBy.isAcceptableOrUnknown(data['claimed_by']!, _claimedByMeta),
      );
    } else if (isInserting) {
      context.missing(_claimedByMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('handled_by')) {
      context.handle(
        _handledByMeta,
        handledBy.isAcceptableOrUnknown(data['handled_by']!, _handledByMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemClaim map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemClaim(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      serverSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_seq'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      claimedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}claimed_by'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      handledBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}handled_by'],
      ),
    );
  }

  @override
  $ItemClaimsTable createAlias(String alias) {
    return $ItemClaimsTable(attachedDatabase, alias);
  }
}

class ItemClaim extends DataClass implements Insertable<ItemClaim> {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  final String updatedAt;

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  final String? deletedAt;

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  final int? serverSeq;

  /// Optimistic concurrency counter, incremented on every local write.
  final int version;
  final String id;
  final String schoolId;
  final String itemId;
  final String claimedBy;
  final String? message;

  /// `ClaimStatus.wire`, defaulting to `'pending'`.
  final String status;
  final String? handledBy;
  const ItemClaim({
    required this.updatedAt,
    this.deletedAt,
    this.serverSeq,
    required this.version,
    required this.id,
    required this.schoolId,
    required this.itemId,
    required this.claimedBy,
    this.message,
    required this.status,
    this.handledBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || serverSeq != null) {
      map['server_seq'] = Variable<int>(serverSeq);
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['item_id'] = Variable<String>(itemId);
    map['claimed_by'] = Variable<String>(claimedBy);
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || handledBy != null) {
      map['handled_by'] = Variable<String>(handledBy);
    }
    return map;
  }

  ItemClaimsCompanion toCompanion(bool nullToAbsent) {
    return ItemClaimsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverSeq: serverSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(serverSeq),
      version: Value(version),
      id: Value(id),
      schoolId: Value(schoolId),
      itemId: Value(itemId),
      claimedBy: Value(claimedBy),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      status: Value(status),
      handledBy: handledBy == null && nullToAbsent
          ? const Value.absent()
          : Value(handledBy),
    );
  }

  factory ItemClaim.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemClaim(
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      deletedAt: serializer.fromJson<String?>(json['deleted_at']),
      serverSeq: serializer.fromJson<int?>(json['server_seq']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['school_id']),
      itemId: serializer.fromJson<String>(json['item_id']),
      claimedBy: serializer.fromJson<String>(json['claimed_by']),
      message: serializer.fromJson<String?>(json['message']),
      status: serializer.fromJson<String>(json['status']),
      handledBy: serializer.fromJson<String?>(json['handled_by']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updated_at': serializer.toJson<String>(updatedAt),
      'deleted_at': serializer.toJson<String?>(deletedAt),
      'server_seq': serializer.toJson<int?>(serverSeq),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'school_id': serializer.toJson<String>(schoolId),
      'item_id': serializer.toJson<String>(itemId),
      'claimed_by': serializer.toJson<String>(claimedBy),
      'message': serializer.toJson<String?>(message),
      'status': serializer.toJson<String>(status),
      'handled_by': serializer.toJson<String?>(handledBy),
    };
  }

  ItemClaim copyWith({
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    Value<int?> serverSeq = const Value.absent(),
    int? version,
    String? id,
    String? schoolId,
    String? itemId,
    String? claimedBy,
    Value<String?> message = const Value.absent(),
    String? status,
    Value<String?> handledBy = const Value.absent(),
  }) => ItemClaim(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverSeq: serverSeq.present ? serverSeq.value : this.serverSeq,
    version: version ?? this.version,
    id: id ?? this.id,
    schoolId: schoolId ?? this.schoolId,
    itemId: itemId ?? this.itemId,
    claimedBy: claimedBy ?? this.claimedBy,
    message: message.present ? message.value : this.message,
    status: status ?? this.status,
    handledBy: handledBy.present ? handledBy.value : this.handledBy,
  );
  ItemClaim copyWithCompanion(ItemClaimsCompanion data) {
    return ItemClaim(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverSeq: data.serverSeq.present ? data.serverSeq.value : this.serverSeq,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      claimedBy: data.claimedBy.present ? data.claimedBy.value : this.claimedBy,
      message: data.message.present ? data.message.value : this.message,
      status: data.status.present ? data.status.value : this.status,
      handledBy: data.handledBy.present ? data.handledBy.value : this.handledBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemClaim(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('itemId: $itemId, ')
          ..write('claimedBy: $claimedBy, ')
          ..write('message: $message, ')
          ..write('status: $status, ')
          ..write('handledBy: $handledBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    serverSeq,
    version,
    id,
    schoolId,
    itemId,
    claimedBy,
    message,
    status,
    handledBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemClaim &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverSeq == this.serverSeq &&
          other.version == this.version &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.itemId == this.itemId &&
          other.claimedBy == this.claimedBy &&
          other.message == this.message &&
          other.status == this.status &&
          other.handledBy == this.handledBy);
}

class ItemClaimsCompanion extends UpdateCompanion<ItemClaim> {
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int?> serverSeq;
  final Value<int> version;
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> itemId;
  final Value<String> claimedBy;
  final Value<String?> message;
  final Value<String> status;
  final Value<String?> handledBy;
  final Value<int> rowid;
  const ItemClaimsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.claimedBy = const Value.absent(),
    this.message = const Value.absent(),
    this.status = const Value.absent(),
    this.handledBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemClaimsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverSeq = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String schoolId,
    required String itemId,
    required String claimedBy,
    this.message = const Value.absent(),
    this.status = const Value.absent(),
    this.handledBy = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       schoolId = Value(schoolId),
       itemId = Value(itemId),
       claimedBy = Value(claimedBy);
  static Insertable<ItemClaim> custom({
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? serverSeq,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? itemId,
    Expression<String>? claimedBy,
    Expression<String>? message,
    Expression<String>? status,
    Expression<String>? handledBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverSeq != null) 'server_seq': serverSeq,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (itemId != null) 'item_id': itemId,
      if (claimedBy != null) 'claimed_by': claimedBy,
      if (message != null) 'message': message,
      if (status != null) 'status': status,
      if (handledBy != null) 'handled_by': handledBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemClaimsCompanion copyWith({
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int?>? serverSeq,
    Value<int>? version,
    Value<String>? id,
    Value<String>? schoolId,
    Value<String>? itemId,
    Value<String>? claimedBy,
    Value<String?>? message,
    Value<String>? status,
    Value<String?>? handledBy,
    Value<int>? rowid,
  }) {
    return ItemClaimsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverSeq: serverSeq ?? this.serverSeq,
      version: version ?? this.version,
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      itemId: itemId ?? this.itemId,
      claimedBy: claimedBy ?? this.claimedBy,
      message: message ?? this.message,
      status: status ?? this.status,
      handledBy: handledBy ?? this.handledBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (serverSeq.present) {
      map['server_seq'] = Variable<int>(serverSeq.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (claimedBy.present) {
      map['claimed_by'] = Variable<String>(claimedBy.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (handledBy.present) {
      map['handled_by'] = Variable<String>(handledBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemClaimsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverSeq: $serverSeq, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('itemId: $itemId, ')
          ..write('claimedBy: $claimedBy, ')
          ..write('message: $message, ')
          ..write('status: $status, ')
          ..write('handledBy: $handledBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutboxTable extends Outbox with TableInfo<$OutboxTable, OutboxEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
    'seq',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _opIdMeta = const VerificationMeta('opId');
  @override
  late final GeneratedColumn<String> opId = GeneratedColumn<String>(
    'op_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _tableNameRefMeta = const VerificationMeta(
    'tableNameRef',
  );
  @override
  late final GeneratedColumn<String> tableNameRef = GeneratedColumn<String>(
    'table_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<String> rowId = GeneratedColumn<String>(
    'row_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _opMeta = const VerificationMeta('op');
  @override
  late final GeneratedColumn<String> op = GeneratedColumn<String>(
    'op',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    seq,
    opId,
    tableNameRef,
    rowId,
    op,
    payload,
    createdAt,
    attempts,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutboxEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('seq')) {
      context.handle(
        _seqMeta,
        seq.isAcceptableOrUnknown(data['seq']!, _seqMeta),
      );
    }
    if (data.containsKey('op_id')) {
      context.handle(
        _opIdMeta,
        opId.isAcceptableOrUnknown(data['op_id']!, _opIdMeta),
      );
    } else if (isInserting) {
      context.missing(_opIdMeta);
    }
    if (data.containsKey('table_name')) {
      context.handle(
        _tableNameRefMeta,
        tableNameRef.isAcceptableOrUnknown(
          data['table_name']!,
          _tableNameRefMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tableNameRefMeta);
    }
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    } else if (isInserting) {
      context.missing(_rowIdMeta);
    }
    if (data.containsKey('op')) {
      context.handle(_opMeta, op.isAcceptableOrUnknown(data['op']!, _opMeta));
    } else if (isInserting) {
      context.missing(_opMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {seq};
  @override
  OutboxEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxEntry(
      seq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seq'],
      )!,
      opId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}op_id'],
      )!,
      tableNameRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}table_name'],
      )!,
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}row_id'],
      )!,
      op: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}op'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $OutboxTable createAlias(String alias) {
    return $OutboxTable(attachedDatabase, alias);
  }
}

class OutboxEntry extends DataClass implements Insertable<OutboxEntry> {
  /// Strict FIFO drain order.
  ///
  /// Ordering matters for causality: the student row must be pushed before the
  /// attendance row that references it. [opId] is a UUIDv7 and so is *roughly*
  /// chronological, but it only has millisecond resolution — marking 40
  /// students lands many ops in the same millisecond, and their relative order
  /// would be undefined. An autoincrement integer is exact.
  final int seq;

  /// Client-generated, echoed to the server as `sync_ops.op_id`.
  ///
  /// The idempotency key. If the connection drops after the server commits but
  /// before the client sees the response, the retry carries the same op_id and
  /// the server recognises the work as already done instead of duplicating it.
  final String opId;
  final String tableNameRef;
  final String rowId;

  /// `SyncOp.wire` — `'upsert'` | `'delete'`.
  ///
  /// `delete` means a tombstone was written, never that a row was removed.
  final String op;

  /// The full row, json-encoded.
  final String payload;
  final String createdAt;
  final int attempts;
  final String? lastError;
  const OutboxEntry({
    required this.seq,
    required this.opId,
    required this.tableNameRef,
    required this.rowId,
    required this.op,
    required this.payload,
    required this.createdAt,
    required this.attempts,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['seq'] = Variable<int>(seq);
    map['op_id'] = Variable<String>(opId);
    map['table_name'] = Variable<String>(tableNameRef);
    map['row_id'] = Variable<String>(rowId);
    map['op'] = Variable<String>(op);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<String>(createdAt);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  OutboxCompanion toCompanion(bool nullToAbsent) {
    return OutboxCompanion(
      seq: Value(seq),
      opId: Value(opId),
      tableNameRef: Value(tableNameRef),
      rowId: Value(rowId),
      op: Value(op),
      payload: Value(payload),
      createdAt: Value(createdAt),
      attempts: Value(attempts),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory OutboxEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxEntry(
      seq: serializer.fromJson<int>(json['seq']),
      opId: serializer.fromJson<String>(json['op_id']),
      tableNameRef: serializer.fromJson<String>(json['table_name']),
      rowId: serializer.fromJson<String>(json['row_id']),
      op: serializer.fromJson<String>(json['op']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastError: serializer.fromJson<String?>(json['last_error']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'seq': serializer.toJson<int>(seq),
      'op_id': serializer.toJson<String>(opId),
      'table_name': serializer.toJson<String>(tableNameRef),
      'row_id': serializer.toJson<String>(rowId),
      'op': serializer.toJson<String>(op),
      'payload': serializer.toJson<String>(payload),
      'created_at': serializer.toJson<String>(createdAt),
      'attempts': serializer.toJson<int>(attempts),
      'last_error': serializer.toJson<String?>(lastError),
    };
  }

  OutboxEntry copyWith({
    int? seq,
    String? opId,
    String? tableNameRef,
    String? rowId,
    String? op,
    String? payload,
    String? createdAt,
    int? attempts,
    Value<String?> lastError = const Value.absent(),
  }) => OutboxEntry(
    seq: seq ?? this.seq,
    opId: opId ?? this.opId,
    tableNameRef: tableNameRef ?? this.tableNameRef,
    rowId: rowId ?? this.rowId,
    op: op ?? this.op,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
    attempts: attempts ?? this.attempts,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  OutboxEntry copyWithCompanion(OutboxCompanion data) {
    return OutboxEntry(
      seq: data.seq.present ? data.seq.value : this.seq,
      opId: data.opId.present ? data.opId.value : this.opId,
      tableNameRef: data.tableNameRef.present
          ? data.tableNameRef.value
          : this.tableNameRef,
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      op: data.op.present ? data.op.value : this.op,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxEntry(')
          ..write('seq: $seq, ')
          ..write('opId: $opId, ')
          ..write('tableNameRef: $tableNameRef, ')
          ..write('rowId: $rowId, ')
          ..write('op: $op, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    seq,
    opId,
    tableNameRef,
    rowId,
    op,
    payload,
    createdAt,
    attempts,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxEntry &&
          other.seq == this.seq &&
          other.opId == this.opId &&
          other.tableNameRef == this.tableNameRef &&
          other.rowId == this.rowId &&
          other.op == this.op &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.attempts == this.attempts &&
          other.lastError == this.lastError);
}

class OutboxCompanion extends UpdateCompanion<OutboxEntry> {
  final Value<int> seq;
  final Value<String> opId;
  final Value<String> tableNameRef;
  final Value<String> rowId;
  final Value<String> op;
  final Value<String> payload;
  final Value<String> createdAt;
  final Value<int> attempts;
  final Value<String?> lastError;
  const OutboxCompanion({
    this.seq = const Value.absent(),
    this.opId = const Value.absent(),
    this.tableNameRef = const Value.absent(),
    this.rowId = const Value.absent(),
    this.op = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
  });
  OutboxCompanion.insert({
    this.seq = const Value.absent(),
    required String opId,
    required String tableNameRef,
    required String rowId,
    required String op,
    required String payload,
    required String createdAt,
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
  }) : opId = Value(opId),
       tableNameRef = Value(tableNameRef),
       rowId = Value(rowId),
       op = Value(op),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<OutboxEntry> custom({
    Expression<int>? seq,
    Expression<String>? opId,
    Expression<String>? tableNameRef,
    Expression<String>? rowId,
    Expression<String>? op,
    Expression<String>? payload,
    Expression<String>? createdAt,
    Expression<int>? attempts,
    Expression<String>? lastError,
  }) {
    return RawValuesInsertable({
      if (seq != null) 'seq': seq,
      if (opId != null) 'op_id': opId,
      if (tableNameRef != null) 'table_name': tableNameRef,
      if (rowId != null) 'row_id': rowId,
      if (op != null) 'op': op,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (attempts != null) 'attempts': attempts,
      if (lastError != null) 'last_error': lastError,
    });
  }

  OutboxCompanion copyWith({
    Value<int>? seq,
    Value<String>? opId,
    Value<String>? tableNameRef,
    Value<String>? rowId,
    Value<String>? op,
    Value<String>? payload,
    Value<String>? createdAt,
    Value<int>? attempts,
    Value<String?>? lastError,
  }) {
    return OutboxCompanion(
      seq: seq ?? this.seq,
      opId: opId ?? this.opId,
      tableNameRef: tableNameRef ?? this.tableNameRef,
      rowId: rowId ?? this.rowId,
      op: op ?? this.op,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (opId.present) {
      map['op_id'] = Variable<String>(opId.value);
    }
    if (tableNameRef.present) {
      map['table_name'] = Variable<String>(tableNameRef.value);
    }
    if (rowId.present) {
      map['row_id'] = Variable<String>(rowId.value);
    }
    if (op.present) {
      map['op'] = Variable<String>(op.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxCompanion(')
          ..write('seq: $seq, ')
          ..write('opId: $opId, ')
          ..write('tableNameRef: $tableNameRef, ')
          ..write('rowId: $rowId, ')
          ..write('op: $op, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

class $AttachmentOutboxTable extends AttachmentOutbox
    with TableInfo<$AttachmentOutboxTable, AttachmentOutboxEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentOutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storageKeyMeta = const VerificationMeta(
    'storageKey',
  );
  @override
  late final GeneratedColumn<String> storageKey = GeneratedColumn<String>(
    'storage_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerTableMeta = const VerificationMeta(
    'ownerTable',
  );
  @override
  late final GeneratedColumn<String> ownerTable = GeneratedColumn<String>(
    'owner_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerRowIdMeta = const VerificationMeta(
    'ownerRowId',
  );
  @override
  late final GeneratedColumn<String> ownerRowId = GeneratedColumn<String>(
    'owner_row_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localPath,
    storageKey,
    ownerTable,
    ownerRowId,
    status,
    attempts,
    lastError,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachment_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttachmentOutboxEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('storage_key')) {
      context.handle(
        _storageKeyMeta,
        storageKey.isAcceptableOrUnknown(data['storage_key']!, _storageKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_storageKeyMeta);
    }
    if (data.containsKey('owner_table')) {
      context.handle(
        _ownerTableMeta,
        ownerTable.isAcceptableOrUnknown(data['owner_table']!, _ownerTableMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerTableMeta);
    }
    if (data.containsKey('owner_row_id')) {
      context.handle(
        _ownerRowIdMeta,
        ownerRowId.isAcceptableOrUnknown(
          data['owner_row_id']!,
          _ownerRowIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ownerRowIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttachmentOutboxEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttachmentOutboxEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      storageKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}storage_key'],
      )!,
      ownerTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_table'],
      )!,
      ownerRowId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_row_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AttachmentOutboxTable createAlias(String alias) {
    return $AttachmentOutboxTable(attachedDatabase, alias);
  }
}

class AttachmentOutboxEntry extends DataClass
    implements Insertable<AttachmentOutboxEntry> {
  final String id;

  /// Absolute path on this device. Meaningless to any peer.
  final String localPath;

  /// Destination key in Supabase Storage.
  final String storageKey;

  /// Table and row this attachment belongs to, so the row can be pushed once
  /// the upload lands.
  final String ownerTable;
  final String ownerRowId;

  /// `AttachmentStatus.wire`.
  final String status;
  final int attempts;
  final String? lastError;
  final String createdAt;
  const AttachmentOutboxEntry({
    required this.id,
    required this.localPath,
    required this.storageKey,
    required this.ownerTable,
    required this.ownerRowId,
    required this.status,
    required this.attempts,
    this.lastError,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['local_path'] = Variable<String>(localPath);
    map['storage_key'] = Variable<String>(storageKey);
    map['owner_table'] = Variable<String>(ownerTable);
    map['owner_row_id'] = Variable<String>(ownerRowId);
    map['status'] = Variable<String>(status);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  AttachmentOutboxCompanion toCompanion(bool nullToAbsent) {
    return AttachmentOutboxCompanion(
      id: Value(id),
      localPath: Value(localPath),
      storageKey: Value(storageKey),
      ownerTable: Value(ownerTable),
      ownerRowId: Value(ownerRowId),
      status: Value(status),
      attempts: Value(attempts),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
    );
  }

  factory AttachmentOutboxEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttachmentOutboxEntry(
      id: serializer.fromJson<String>(json['id']),
      localPath: serializer.fromJson<String>(json['local_path']),
      storageKey: serializer.fromJson<String>(json['storage_key']),
      ownerTable: serializer.fromJson<String>(json['owner_table']),
      ownerRowId: serializer.fromJson<String>(json['owner_row_id']),
      status: serializer.fromJson<String>(json['status']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastError: serializer.fromJson<String?>(json['last_error']),
      createdAt: serializer.fromJson<String>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'local_path': serializer.toJson<String>(localPath),
      'storage_key': serializer.toJson<String>(storageKey),
      'owner_table': serializer.toJson<String>(ownerTable),
      'owner_row_id': serializer.toJson<String>(ownerRowId),
      'status': serializer.toJson<String>(status),
      'attempts': serializer.toJson<int>(attempts),
      'last_error': serializer.toJson<String?>(lastError),
      'created_at': serializer.toJson<String>(createdAt),
    };
  }

  AttachmentOutboxEntry copyWith({
    String? id,
    String? localPath,
    String? storageKey,
    String? ownerTable,
    String? ownerRowId,
    String? status,
    int? attempts,
    Value<String?> lastError = const Value.absent(),
    String? createdAt,
  }) => AttachmentOutboxEntry(
    id: id ?? this.id,
    localPath: localPath ?? this.localPath,
    storageKey: storageKey ?? this.storageKey,
    ownerTable: ownerTable ?? this.ownerTable,
    ownerRowId: ownerRowId ?? this.ownerRowId,
    status: status ?? this.status,
    attempts: attempts ?? this.attempts,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
  );
  AttachmentOutboxEntry copyWithCompanion(AttachmentOutboxCompanion data) {
    return AttachmentOutboxEntry(
      id: data.id.present ? data.id.value : this.id,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      storageKey: data.storageKey.present
          ? data.storageKey.value
          : this.storageKey,
      ownerTable: data.ownerTable.present
          ? data.ownerTable.value
          : this.ownerTable,
      ownerRowId: data.ownerRowId.present
          ? data.ownerRowId.value
          : this.ownerRowId,
      status: data.status.present ? data.status.value : this.status,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentOutboxEntry(')
          ..write('id: $id, ')
          ..write('localPath: $localPath, ')
          ..write('storageKey: $storageKey, ')
          ..write('ownerTable: $ownerTable, ')
          ..write('ownerRowId: $ownerRowId, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localPath,
    storageKey,
    ownerTable,
    ownerRowId,
    status,
    attempts,
    lastError,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachmentOutboxEntry &&
          other.id == this.id &&
          other.localPath == this.localPath &&
          other.storageKey == this.storageKey &&
          other.ownerTable == this.ownerTable &&
          other.ownerRowId == this.ownerRowId &&
          other.status == this.status &&
          other.attempts == this.attempts &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt);
}

class AttachmentOutboxCompanion extends UpdateCompanion<AttachmentOutboxEntry> {
  final Value<String> id;
  final Value<String> localPath;
  final Value<String> storageKey;
  final Value<String> ownerTable;
  final Value<String> ownerRowId;
  final Value<String> status;
  final Value<int> attempts;
  final Value<String?> lastError;
  final Value<String> createdAt;
  final Value<int> rowid;
  const AttachmentOutboxCompanion({
    this.id = const Value.absent(),
    this.localPath = const Value.absent(),
    this.storageKey = const Value.absent(),
    this.ownerTable = const Value.absent(),
    this.ownerRowId = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentOutboxCompanion.insert({
    required String id,
    required String localPath,
    required String storageKey,
    required String ownerTable,
    required String ownerRowId,
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       localPath = Value(localPath),
       storageKey = Value(storageKey),
       ownerTable = Value(ownerTable),
       ownerRowId = Value(ownerRowId),
       createdAt = Value(createdAt);
  static Insertable<AttachmentOutboxEntry> custom({
    Expression<String>? id,
    Expression<String>? localPath,
    Expression<String>? storageKey,
    Expression<String>? ownerTable,
    Expression<String>? ownerRowId,
    Expression<String>? status,
    Expression<int>? attempts,
    Expression<String>? lastError,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localPath != null) 'local_path': localPath,
      if (storageKey != null) 'storage_key': storageKey,
      if (ownerTable != null) 'owner_table': ownerTable,
      if (ownerRowId != null) 'owner_row_id': ownerRowId,
      if (status != null) 'status': status,
      if (attempts != null) 'attempts': attempts,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttachmentOutboxCompanion copyWith({
    Value<String>? id,
    Value<String>? localPath,
    Value<String>? storageKey,
    Value<String>? ownerTable,
    Value<String>? ownerRowId,
    Value<String>? status,
    Value<int>? attempts,
    Value<String?>? lastError,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return AttachmentOutboxCompanion(
      id: id ?? this.id,
      localPath: localPath ?? this.localPath,
      storageKey: storageKey ?? this.storageKey,
      ownerTable: ownerTable ?? this.ownerTable,
      ownerRowId: ownerRowId ?? this.ownerRowId,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (storageKey.present) {
      map['storage_key'] = Variable<String>(storageKey.value);
    }
    if (ownerTable.present) {
      map['owner_table'] = Variable<String>(ownerTable.value);
    }
    if (ownerRowId.present) {
      map['owner_row_id'] = Variable<String>(ownerRowId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentOutboxCompanion(')
          ..write('id: $id, ')
          ..write('localPath: $localPath, ')
          ..write('storageKey: $storageKey, ')
          ..write('ownerTable: $ownerTable, ')
          ..write('ownerRowId: $ownerRowId, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStateTable extends SyncState
    with TableInfo<$SyncStateTable, SyncStateEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncStateEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncStateEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
    );
  }

  @override
  $SyncStateTable createAlias(String alias) {
    return $SyncStateTable(attachedDatabase, alias);
  }
}

class SyncStateEntry extends DataClass implements Insertable<SyncStateEntry> {
  final String key;
  final String? value;
  const SyncStateEntry({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  SyncStateCompanion toCompanion(bool nullToAbsent) {
    return SyncStateCompanion(
      key: Value(key),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
    );
  }

  factory SyncStateEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
    };
  }

  SyncStateEntry copyWith({
    String? key,
    Value<String?> value = const Value.absent(),
  }) => SyncStateEntry(
    key: key ?? this.key,
    value: value.present ? value.value : this.value,
  );
  SyncStateEntry copyWithCompanion(SyncStateCompanion data) {
    return SyncStateEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateEntry(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateEntry &&
          other.key == this.key &&
          other.value == this.value);
}

class SyncStateCompanion extends UpdateCompanion<SyncStateEntry> {
  final Value<String> key;
  final Value<String?> value;
  final Value<int> rowid;
  const SyncStateCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStateCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<SyncStateEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStateCompanion copyWith({
    Value<String>? key,
    Value<String?>? value,
    Value<int>? rowid,
  }) {
    return SyncStateCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SchoolsTable schools = $SchoolsTable(this);
  late final $AcademicYearsTable academicYears = $AcademicYearsTable(this);
  late final $ClassesTable classes = $ClassesTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $AppUsersTable appUsers = $AppUsersTable(this);
  late final $TeachersTable teachers = $TeachersTable(this);
  late final $TeacherClassAssignmentsTable teacherClassAssignments =
      $TeacherClassAssignmentsTable(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $AttendanceTable attendance = $AttendanceTable(this);
  late final $TeacherAttendanceTable teacherAttendance =
      $TeacherAttendanceTable(this);
  late final $ExamsTable exams = $ExamsTable(this);
  late final $MarksTable marks = $MarksTable(this);
  late final $FeeStructuresTable feeStructures = $FeeStructuresTable(this);
  late final $FeeChallansTable feeChallans = $FeeChallansTable(this);
  late final $TimetableSlotsTable timetableSlots = $TimetableSlotsTable(this);
  late final $AssignmentsTable assignments = $AssignmentsTable(this);
  late final $NoticesTable notices = $NoticesTable(this);
  late final $LostItemsTable lostItems = $LostItemsTable(this);
  late final $ItemClaimsTable itemClaims = $ItemClaimsTable(this);
  late final $OutboxTable outbox = $OutboxTable(this);
  late final $AttachmentOutboxTable attachmentOutbox = $AttachmentOutboxTable(
    this,
  );
  late final $SyncStateTable syncState = $SyncStateTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    schools,
    academicYears,
    classes,
    subjects,
    appUsers,
    teachers,
    teacherClassAssignments,
    students,
    attendance,
    teacherAttendance,
    exams,
    marks,
    feeStructures,
    feeChallans,
    timetableSlots,
    assignments,
    notices,
    lostItems,
    itemClaims,
    outbox,
    attachmentOutbox,
    syncState,
  ];
}

typedef $$SchoolsTableCreateCompanionBuilder =
    SchoolsCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String name,
      Value<String?> address,
      Value<String?> phone,
      Value<String?> logoUrl,
      Value<int> rowid,
    });
typedef $$SchoolsTableUpdateCompanionBuilder =
    SchoolsCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> name,
      Value<String?> address,
      Value<String?> phone,
      Value<String?> logoUrl,
      Value<int> rowid,
    });

class $$SchoolsTableFilterComposer
    extends Composer<_$AppDatabase, $SchoolsTable> {
  $$SchoolsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SchoolsTableOrderingComposer
    extends Composer<_$AppDatabase, $SchoolsTable> {
  $$SchoolsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SchoolsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchoolsTable> {
  $$SchoolsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);
}

class $$SchoolsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SchoolsTable,
          School,
          $$SchoolsTableFilterComposer,
          $$SchoolsTableOrderingComposer,
          $$SchoolsTableAnnotationComposer,
          $$SchoolsTableCreateCompanionBuilder,
          $$SchoolsTableUpdateCompanionBuilder,
          (School, BaseReferences<_$AppDatabase, $SchoolsTable, School>),
          School,
          PrefetchHooks Function()
        > {
  $$SchoolsTableTableManager(_$AppDatabase db, $SchoolsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchoolsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchoolsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchoolsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SchoolsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                name: name,
                address: address,
                phone: phone,
                logoUrl: logoUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String name,
                Value<String?> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SchoolsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                name: name,
                address: address,
                phone: phone,
                logoUrl: logoUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SchoolsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SchoolsTable,
      School,
      $$SchoolsTableFilterComposer,
      $$SchoolsTableOrderingComposer,
      $$SchoolsTableAnnotationComposer,
      $$SchoolsTableCreateCompanionBuilder,
      $$SchoolsTableUpdateCompanionBuilder,
      (School, BaseReferences<_$AppDatabase, $SchoolsTable, School>),
      School,
      PrefetchHooks Function()
    >;
typedef $$AcademicYearsTableCreateCompanionBuilder =
    AcademicYearsCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String name,
      required String startDate,
      required String endDate,
      Value<bool> isCurrent,
      Value<int> rowid,
    });
typedef $$AcademicYearsTableUpdateCompanionBuilder =
    AcademicYearsCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> name,
      Value<String> startDate,
      Value<String> endDate,
      Value<bool> isCurrent,
      Value<int> rowid,
    });

class $$AcademicYearsTableFilterComposer
    extends Composer<_$AppDatabase, $AcademicYearsTable> {
  $$AcademicYearsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AcademicYearsTableOrderingComposer
    extends Composer<_$AppDatabase, $AcademicYearsTable> {
  $$AcademicYearsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AcademicYearsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AcademicYearsTable> {
  $$AcademicYearsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get isCurrent =>
      $composableBuilder(column: $table.isCurrent, builder: (column) => column);
}

class $$AcademicYearsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AcademicYearsTable,
          AcademicYear,
          $$AcademicYearsTableFilterComposer,
          $$AcademicYearsTableOrderingComposer,
          $$AcademicYearsTableAnnotationComposer,
          $$AcademicYearsTableCreateCompanionBuilder,
          $$AcademicYearsTableUpdateCompanionBuilder,
          (
            AcademicYear,
            BaseReferences<_$AppDatabase, $AcademicYearsTable, AcademicYear>,
          ),
          AcademicYear,
          PrefetchHooks Function()
        > {
  $$AcademicYearsTableTableManager(_$AppDatabase db, $AcademicYearsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AcademicYearsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AcademicYearsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AcademicYearsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<String> endDate = const Value.absent(),
                Value<bool> isCurrent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AcademicYearsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                name: name,
                startDate: startDate,
                endDate: endDate,
                isCurrent: isCurrent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String name,
                required String startDate,
                required String endDate,
                Value<bool> isCurrent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AcademicYearsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                name: name,
                startDate: startDate,
                endDate: endDate,
                isCurrent: isCurrent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AcademicYearsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AcademicYearsTable,
      AcademicYear,
      $$AcademicYearsTableFilterComposer,
      $$AcademicYearsTableOrderingComposer,
      $$AcademicYearsTableAnnotationComposer,
      $$AcademicYearsTableCreateCompanionBuilder,
      $$AcademicYearsTableUpdateCompanionBuilder,
      (
        AcademicYear,
        BaseReferences<_$AppDatabase, $AcademicYearsTable, AcademicYear>,
      ),
      AcademicYear,
      PrefetchHooks Function()
    >;
typedef $$ClassesTableCreateCompanionBuilder =
    ClassesCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String academicYearId,
      required int grade,
      required String section,
      required String displayName,
      Value<String?> classTeacherId,
      Value<String?> room,
      Value<int> rowid,
    });
typedef $$ClassesTableUpdateCompanionBuilder =
    ClassesCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> academicYearId,
      Value<int> grade,
      Value<String> section,
      Value<String> displayName,
      Value<String?> classTeacherId,
      Value<String?> room,
      Value<int> rowid,
    });

class $$ClassesTableFilterComposer
    extends Composer<_$AppDatabase, $ClassesTable> {
  $$ClassesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get academicYearId => $composableBuilder(
    column: $table.academicYearId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classTeacherId => $composableBuilder(
    column: $table.classTeacherId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClassesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassesTable> {
  $$ClassesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get academicYearId => $composableBuilder(
    column: $table.academicYearId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classTeacherId => $composableBuilder(
    column: $table.classTeacherId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClassesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassesTable> {
  $$ClassesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get academicYearId => $composableBuilder(
    column: $table.academicYearId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get section =>
      $composableBuilder(column: $table.section, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get classTeacherId => $composableBuilder(
    column: $table.classTeacherId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get room =>
      $composableBuilder(column: $table.room, builder: (column) => column);
}

class $$ClassesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClassesTable,
          SchoolClass,
          $$ClassesTableFilterComposer,
          $$ClassesTableOrderingComposer,
          $$ClassesTableAnnotationComposer,
          $$ClassesTableCreateCompanionBuilder,
          $$ClassesTableUpdateCompanionBuilder,
          (
            SchoolClass,
            BaseReferences<_$AppDatabase, $ClassesTable, SchoolClass>,
          ),
          SchoolClass,
          PrefetchHooks Function()
        > {
  $$ClassesTableTableManager(_$AppDatabase db, $ClassesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> academicYearId = const Value.absent(),
                Value<int> grade = const Value.absent(),
                Value<String> section = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> classTeacherId = const Value.absent(),
                Value<String?> room = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClassesCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                academicYearId: academicYearId,
                grade: grade,
                section: section,
                displayName: displayName,
                classTeacherId: classTeacherId,
                room: room,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String academicYearId,
                required int grade,
                required String section,
                required String displayName,
                Value<String?> classTeacherId = const Value.absent(),
                Value<String?> room = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClassesCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                academicYearId: academicYearId,
                grade: grade,
                section: section,
                displayName: displayName,
                classTeacherId: classTeacherId,
                room: room,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClassesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClassesTable,
      SchoolClass,
      $$ClassesTableFilterComposer,
      $$ClassesTableOrderingComposer,
      $$ClassesTableAnnotationComposer,
      $$ClassesTableCreateCompanionBuilder,
      $$ClassesTableUpdateCompanionBuilder,
      (SchoolClass, BaseReferences<_$AppDatabase, $ClassesTable, SchoolClass>),
      SchoolClass,
      PrefetchHooks Function()
    >;
typedef $$SubjectsTableCreateCompanionBuilder =
    SubjectsCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String classId,
      required String name,
      Value<String?> code,
      Value<String?> teacherId,
      Value<int> totalMarks,
      Value<int> sortOrder,
      Value<String?> icon,
      Value<int> rowid,
    });
typedef $$SubjectsTableUpdateCompanionBuilder =
    SubjectsCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> classId,
      Value<String> name,
      Value<String?> code,
      Value<String?> teacherId,
      Value<int> totalMarks,
      Value<int> sortOrder,
      Value<String?> icon,
      Value<int> rowid,
    });

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teacherId => $composableBuilder(
    column: $table.teacherId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalMarks => $composableBuilder(
    column: $table.totalMarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teacherId => $composableBuilder(
    column: $table.teacherId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalMarks => $composableBuilder(
    column: $table.totalMarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get teacherId =>
      $composableBuilder(column: $table.teacherId, builder: (column) => column);

  GeneratedColumn<int> get totalMarks => $composableBuilder(
    column: $table.totalMarks,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);
}

class $$SubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectsTable,
          Subject,
          $$SubjectsTableFilterComposer,
          $$SubjectsTableOrderingComposer,
          $$SubjectsTableAnnotationComposer,
          $$SubjectsTableCreateCompanionBuilder,
          $$SubjectsTableUpdateCompanionBuilder,
          (Subject, BaseReferences<_$AppDatabase, $SubjectsTable, Subject>),
          Subject,
          PrefetchHooks Function()
        > {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> code = const Value.absent(),
                Value<String?> teacherId = const Value.absent(),
                Value<int> totalMarks = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubjectsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                classId: classId,
                name: name,
                code: code,
                teacherId: teacherId,
                totalMarks: totalMarks,
                sortOrder: sortOrder,
                icon: icon,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String classId,
                required String name,
                Value<String?> code = const Value.absent(),
                Value<String?> teacherId = const Value.absent(),
                Value<int> totalMarks = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubjectsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                classId: classId,
                name: name,
                code: code,
                teacherId: teacherId,
                totalMarks: totalMarks,
                sortOrder: sortOrder,
                icon: icon,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectsTable,
      Subject,
      $$SubjectsTableFilterComposer,
      $$SubjectsTableOrderingComposer,
      $$SubjectsTableAnnotationComposer,
      $$SubjectsTableCreateCompanionBuilder,
      $$SubjectsTableUpdateCompanionBuilder,
      (Subject, BaseReferences<_$AppDatabase, $SubjectsTable, Subject>),
      Subject,
      PrefetchHooks Function()
    >;
typedef $$AppUsersTableCreateCompanionBuilder =
    AppUsersCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String role,
      Value<String?> email,
      Value<String?> phone,
      required String fullName,
      Value<bool> isActive,
      Value<String?> lastLoginAt,
      Value<int> rowid,
    });
typedef $$AppUsersTableUpdateCompanionBuilder =
    AppUsersCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> role,
      Value<String?> email,
      Value<String?> phone,
      Value<String> fullName,
      Value<bool> isActive,
      Value<String?> lastLoginAt,
      Value<int> rowid,
    });

class $$AppUsersTableFilterComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => column,
  );
}

class $$AppUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppUsersTable,
          AppUser,
          $$AppUsersTableFilterComposer,
          $$AppUsersTableOrderingComposer,
          $$AppUsersTableAnnotationComposer,
          $$AppUsersTableCreateCompanionBuilder,
          $$AppUsersTableUpdateCompanionBuilder,
          (AppUser, BaseReferences<_$AppDatabase, $AppUsersTable, AppUser>),
          AppUser,
          PrefetchHooks Function()
        > {
  $$AppUsersTableTableManager(_$AppDatabase db, $AppUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> lastLoginAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppUsersCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                role: role,
                email: email,
                phone: phone,
                fullName: fullName,
                isActive: isActive,
                lastLoginAt: lastLoginAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String role,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                required String fullName,
                Value<bool> isActive = const Value.absent(),
                Value<String?> lastLoginAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppUsersCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                role: role,
                email: email,
                phone: phone,
                fullName: fullName,
                isActive: isActive,
                lastLoginAt: lastLoginAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppUsersTable,
      AppUser,
      $$AppUsersTableFilterComposer,
      $$AppUsersTableOrderingComposer,
      $$AppUsersTableAnnotationComposer,
      $$AppUsersTableCreateCompanionBuilder,
      $$AppUsersTableUpdateCompanionBuilder,
      (AppUser, BaseReferences<_$AppDatabase, $AppUsersTable, AppUser>),
      AppUser,
      PrefetchHooks Function()
    >;
typedef $$TeachersTableCreateCompanionBuilder =
    TeachersCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      Value<String?> userId,
      required String schoolId,
      Value<String?> employeeNo,
      required String fullName,
      Value<String?> cnic,
      Value<String?> phone,
      Value<String?> qualification,
      Value<String?> joiningDate,
      Value<String?> photoUrl,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$TeachersTableUpdateCompanionBuilder =
    TeachersCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String?> userId,
      Value<String> schoolId,
      Value<String?> employeeNo,
      Value<String> fullName,
      Value<String?> cnic,
      Value<String?> phone,
      Value<String?> qualification,
      Value<String?> joiningDate,
      Value<String?> photoUrl,
      Value<bool> isActive,
      Value<int> rowid,
    });

class $$TeachersTableFilterComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get employeeNo => $composableBuilder(
    column: $table.employeeNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cnic => $composableBuilder(
    column: $table.cnic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qualification => $composableBuilder(
    column: $table.qualification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get joiningDate => $composableBuilder(
    column: $table.joiningDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeachersTableOrderingComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get employeeNo => $composableBuilder(
    column: $table.employeeNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cnic => $composableBuilder(
    column: $table.cnic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qualification => $composableBuilder(
    column: $table.qualification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get joiningDate => $composableBuilder(
    column: $table.joiningDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeachersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get employeeNo => $composableBuilder(
    column: $table.employeeNo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get cnic =>
      $composableBuilder(column: $table.cnic, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get qualification => $composableBuilder(
    column: $table.qualification,
    builder: (column) => column,
  );

  GeneratedColumn<String> get joiningDate => $composableBuilder(
    column: $table.joiningDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$TeachersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeachersTable,
          Teacher,
          $$TeachersTableFilterComposer,
          $$TeachersTableOrderingComposer,
          $$TeachersTableAnnotationComposer,
          $$TeachersTableCreateCompanionBuilder,
          $$TeachersTableUpdateCompanionBuilder,
          (Teacher, BaseReferences<_$AppDatabase, $TeachersTable, Teacher>),
          Teacher,
          PrefetchHooks Function()
        > {
  $$TeachersTableTableManager(_$AppDatabase db, $TeachersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeachersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeachersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeachersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String?> employeeNo = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> cnic = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> qualification = const Value.absent(),
                Value<String?> joiningDate = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeachersCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                userId: userId,
                schoolId: schoolId,
                employeeNo: employeeNo,
                fullName: fullName,
                cnic: cnic,
                phone: phone,
                qualification: qualification,
                joiningDate: joiningDate,
                photoUrl: photoUrl,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                Value<String?> userId = const Value.absent(),
                required String schoolId,
                Value<String?> employeeNo = const Value.absent(),
                required String fullName,
                Value<String?> cnic = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> qualification = const Value.absent(),
                Value<String?> joiningDate = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeachersCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                userId: userId,
                schoolId: schoolId,
                employeeNo: employeeNo,
                fullName: fullName,
                cnic: cnic,
                phone: phone,
                qualification: qualification,
                joiningDate: joiningDate,
                photoUrl: photoUrl,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TeachersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeachersTable,
      Teacher,
      $$TeachersTableFilterComposer,
      $$TeachersTableOrderingComposer,
      $$TeachersTableAnnotationComposer,
      $$TeachersTableCreateCompanionBuilder,
      $$TeachersTableUpdateCompanionBuilder,
      (Teacher, BaseReferences<_$AppDatabase, $TeachersTable, Teacher>),
      Teacher,
      PrefetchHooks Function()
    >;
typedef $$TeacherClassAssignmentsTableCreateCompanionBuilder =
    TeacherClassAssignmentsCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String teacherId,
      required String classId,
      Value<String?> subjectId,
      Value<bool> canMarkAttendance,
      Value<int> rowid,
    });
typedef $$TeacherClassAssignmentsTableUpdateCompanionBuilder =
    TeacherClassAssignmentsCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> teacherId,
      Value<String> classId,
      Value<String?> subjectId,
      Value<bool> canMarkAttendance,
      Value<int> rowid,
    });

class $$TeacherClassAssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $TeacherClassAssignmentsTable> {
  $$TeacherClassAssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teacherId => $composableBuilder(
    column: $table.teacherId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canMarkAttendance => $composableBuilder(
    column: $table.canMarkAttendance,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeacherClassAssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeacherClassAssignmentsTable> {
  $$TeacherClassAssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teacherId => $composableBuilder(
    column: $table.teacherId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canMarkAttendance => $composableBuilder(
    column: $table.canMarkAttendance,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeacherClassAssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeacherClassAssignmentsTable> {
  $$TeacherClassAssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get teacherId =>
      $composableBuilder(column: $table.teacherId, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get subjectId =>
      $composableBuilder(column: $table.subjectId, builder: (column) => column);

  GeneratedColumn<bool> get canMarkAttendance => $composableBuilder(
    column: $table.canMarkAttendance,
    builder: (column) => column,
  );
}

class $$TeacherClassAssignmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeacherClassAssignmentsTable,
          TeacherClassAssignment,
          $$TeacherClassAssignmentsTableFilterComposer,
          $$TeacherClassAssignmentsTableOrderingComposer,
          $$TeacherClassAssignmentsTableAnnotationComposer,
          $$TeacherClassAssignmentsTableCreateCompanionBuilder,
          $$TeacherClassAssignmentsTableUpdateCompanionBuilder,
          (
            TeacherClassAssignment,
            BaseReferences<
              _$AppDatabase,
              $TeacherClassAssignmentsTable,
              TeacherClassAssignment
            >,
          ),
          TeacherClassAssignment,
          PrefetchHooks Function()
        > {
  $$TeacherClassAssignmentsTableTableManager(
    _$AppDatabase db,
    $TeacherClassAssignmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeacherClassAssignmentsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TeacherClassAssignmentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TeacherClassAssignmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> teacherId = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<String?> subjectId = const Value.absent(),
                Value<bool> canMarkAttendance = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeacherClassAssignmentsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                teacherId: teacherId,
                classId: classId,
                subjectId: subjectId,
                canMarkAttendance: canMarkAttendance,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String teacherId,
                required String classId,
                Value<String?> subjectId = const Value.absent(),
                Value<bool> canMarkAttendance = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeacherClassAssignmentsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                teacherId: teacherId,
                classId: classId,
                subjectId: subjectId,
                canMarkAttendance: canMarkAttendance,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TeacherClassAssignmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeacherClassAssignmentsTable,
      TeacherClassAssignment,
      $$TeacherClassAssignmentsTableFilterComposer,
      $$TeacherClassAssignmentsTableOrderingComposer,
      $$TeacherClassAssignmentsTableAnnotationComposer,
      $$TeacherClassAssignmentsTableCreateCompanionBuilder,
      $$TeacherClassAssignmentsTableUpdateCompanionBuilder,
      (
        TeacherClassAssignment,
        BaseReferences<
          _$AppDatabase,
          $TeacherClassAssignmentsTable,
          TeacherClassAssignment
        >,
      ),
      TeacherClassAssignment,
      PrefetchHooks Function()
    >;
typedef $$StudentsTableCreateCompanionBuilder =
    StudentsCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      Value<String?> userId,
      required String schoolId,
      Value<String?> classId,
      required String admissionNo,
      Value<int?> rollNo,
      required String fullName,
      Value<String?> fatherName,
      Value<String?> guardianPhone,
      Value<String?> dateOfBirth,
      Value<String?> gender,
      Value<String?> address,
      Value<String?> documents,
      Value<String?> photoUrl,
      Value<String?> admissionDate,
      Value<String> status,
      Value<String?> leftDate,
      Value<String?> leftReason,
      Value<int> rowid,
    });
typedef $$StudentsTableUpdateCompanionBuilder =
    StudentsCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String?> userId,
      Value<String> schoolId,
      Value<String?> classId,
      Value<String> admissionNo,
      Value<int?> rollNo,
      Value<String> fullName,
      Value<String?> fatherName,
      Value<String?> guardianPhone,
      Value<String?> dateOfBirth,
      Value<String?> gender,
      Value<String?> address,
      Value<String?> documents,
      Value<String?> photoUrl,
      Value<String?> admissionDate,
      Value<String> status,
      Value<String?> leftDate,
      Value<String?> leftReason,
      Value<int> rowid,
    });

class $$StudentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get admissionNo => $composableBuilder(
    column: $table.admissionNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rollNo => $composableBuilder(
    column: $table.rollNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fatherName => $composableBuilder(
    column: $table.fatherName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get guardianPhone => $composableBuilder(
    column: $table.guardianPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documents => $composableBuilder(
    column: $table.documents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get admissionDate => $composableBuilder(
    column: $table.admissionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get leftDate => $composableBuilder(
    column: $table.leftDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get leftReason => $composableBuilder(
    column: $table.leftReason,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get admissionNo => $composableBuilder(
    column: $table.admissionNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rollNo => $composableBuilder(
    column: $table.rollNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fatherName => $composableBuilder(
    column: $table.fatherName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get guardianPhone => $composableBuilder(
    column: $table.guardianPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documents => $composableBuilder(
    column: $table.documents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get admissionDate => $composableBuilder(
    column: $table.admissionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get leftDate => $composableBuilder(
    column: $table.leftDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get leftReason => $composableBuilder(
    column: $table.leftReason,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get admissionNo => $composableBuilder(
    column: $table.admissionNo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rollNo =>
      $composableBuilder(column: $table.rollNo, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get fatherName => $composableBuilder(
    column: $table.fatherName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get guardianPhone => $composableBuilder(
    column: $table.guardianPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get documents =>
      $composableBuilder(column: $table.documents, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get admissionDate => $composableBuilder(
    column: $table.admissionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get leftDate =>
      $composableBuilder(column: $table.leftDate, builder: (column) => column);

  GeneratedColumn<String> get leftReason => $composableBuilder(
    column: $table.leftReason,
    builder: (column) => column,
  );
}

class $$StudentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentsTable,
          Student,
          $$StudentsTableFilterComposer,
          $$StudentsTableOrderingComposer,
          $$StudentsTableAnnotationComposer,
          $$StudentsTableCreateCompanionBuilder,
          $$StudentsTableUpdateCompanionBuilder,
          (Student, BaseReferences<_$AppDatabase, $StudentsTable, Student>),
          Student,
          PrefetchHooks Function()
        > {
  $$StudentsTableTableManager(_$AppDatabase db, $StudentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String?> classId = const Value.absent(),
                Value<String> admissionNo = const Value.absent(),
                Value<int?> rollNo = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> fatherName = const Value.absent(),
                Value<String?> guardianPhone = const Value.absent(),
                Value<String?> dateOfBirth = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> documents = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> admissionDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> leftDate = const Value.absent(),
                Value<String?> leftReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudentsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                userId: userId,
                schoolId: schoolId,
                classId: classId,
                admissionNo: admissionNo,
                rollNo: rollNo,
                fullName: fullName,
                fatherName: fatherName,
                guardianPhone: guardianPhone,
                dateOfBirth: dateOfBirth,
                gender: gender,
                address: address,
                documents: documents,
                photoUrl: photoUrl,
                admissionDate: admissionDate,
                status: status,
                leftDate: leftDate,
                leftReason: leftReason,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                Value<String?> userId = const Value.absent(),
                required String schoolId,
                Value<String?> classId = const Value.absent(),
                required String admissionNo,
                Value<int?> rollNo = const Value.absent(),
                required String fullName,
                Value<String?> fatherName = const Value.absent(),
                Value<String?> guardianPhone = const Value.absent(),
                Value<String?> dateOfBirth = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> documents = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> admissionDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> leftDate = const Value.absent(),
                Value<String?> leftReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudentsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                userId: userId,
                schoolId: schoolId,
                classId: classId,
                admissionNo: admissionNo,
                rollNo: rollNo,
                fullName: fullName,
                fatherName: fatherName,
                guardianPhone: guardianPhone,
                dateOfBirth: dateOfBirth,
                gender: gender,
                address: address,
                documents: documents,
                photoUrl: photoUrl,
                admissionDate: admissionDate,
                status: status,
                leftDate: leftDate,
                leftReason: leftReason,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentsTable,
      Student,
      $$StudentsTableFilterComposer,
      $$StudentsTableOrderingComposer,
      $$StudentsTableAnnotationComposer,
      $$StudentsTableCreateCompanionBuilder,
      $$StudentsTableUpdateCompanionBuilder,
      (Student, BaseReferences<_$AppDatabase, $StudentsTable, Student>),
      Student,
      PrefetchHooks Function()
    >;
typedef $$AttendanceTableCreateCompanionBuilder =
    AttendanceCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String studentId,
      required String classId,
      required String date,
      required String status,
      Value<String?> remarks,
      required String markedBy,
      required String markedAt,
      Value<int> rowid,
    });
typedef $$AttendanceTableUpdateCompanionBuilder =
    AttendanceCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> studentId,
      Value<String> classId,
      Value<String> date,
      Value<String> status,
      Value<String?> remarks,
      Value<String> markedBy,
      Value<String> markedAt,
      Value<int> rowid,
    });

class $$AttendanceTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get markedBy => $composableBuilder(
    column: $table.markedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get markedAt => $composableBuilder(
    column: $table.markedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttendanceTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get markedBy => $composableBuilder(
    column: $table.markedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get markedAt => $composableBuilder(
    column: $table.markedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttendanceTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<String> get markedBy =>
      $composableBuilder(column: $table.markedBy, builder: (column) => column);

  GeneratedColumn<String> get markedAt =>
      $composableBuilder(column: $table.markedAt, builder: (column) => column);
}

class $$AttendanceTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceTable,
          AttendanceRow,
          $$AttendanceTableFilterComposer,
          $$AttendanceTableOrderingComposer,
          $$AttendanceTableAnnotationComposer,
          $$AttendanceTableCreateCompanionBuilder,
          $$AttendanceTableUpdateCompanionBuilder,
          (
            AttendanceRow,
            BaseReferences<_$AppDatabase, $AttendanceTable, AttendanceRow>,
          ),
          AttendanceRow,
          PrefetchHooks Function()
        > {
  $$AttendanceTableTableManager(_$AppDatabase db, $AttendanceTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                Value<String> markedBy = const Value.absent(),
                Value<String> markedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                studentId: studentId,
                classId: classId,
                date: date,
                status: status,
                remarks: remarks,
                markedBy: markedBy,
                markedAt: markedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String studentId,
                required String classId,
                required String date,
                required String status,
                Value<String?> remarks = const Value.absent(),
                required String markedBy,
                required String markedAt,
                Value<int> rowid = const Value.absent(),
              }) => AttendanceCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                studentId: studentId,
                classId: classId,
                date: date,
                status: status,
                remarks: remarks,
                markedBy: markedBy,
                markedAt: markedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttendanceTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceTable,
      AttendanceRow,
      $$AttendanceTableFilterComposer,
      $$AttendanceTableOrderingComposer,
      $$AttendanceTableAnnotationComposer,
      $$AttendanceTableCreateCompanionBuilder,
      $$AttendanceTableUpdateCompanionBuilder,
      (
        AttendanceRow,
        BaseReferences<_$AppDatabase, $AttendanceTable, AttendanceRow>,
      ),
      AttendanceRow,
      PrefetchHooks Function()
    >;
typedef $$TeacherAttendanceTableCreateCompanionBuilder =
    TeacherAttendanceCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String teacherId,
      required String date,
      required String status,
      Value<String?> checkInTime,
      Value<String?> remarks,
      required String markedBy,
      required String markedAt,
      Value<int> rowid,
    });
typedef $$TeacherAttendanceTableUpdateCompanionBuilder =
    TeacherAttendanceCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> teacherId,
      Value<String> date,
      Value<String> status,
      Value<String?> checkInTime,
      Value<String?> remarks,
      Value<String> markedBy,
      Value<String> markedAt,
      Value<int> rowid,
    });

class $$TeacherAttendanceTableFilterComposer
    extends Composer<_$AppDatabase, $TeacherAttendanceTable> {
  $$TeacherAttendanceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teacherId => $composableBuilder(
    column: $table.teacherId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get markedBy => $composableBuilder(
    column: $table.markedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get markedAt => $composableBuilder(
    column: $table.markedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeacherAttendanceTableOrderingComposer
    extends Composer<_$AppDatabase, $TeacherAttendanceTable> {
  $$TeacherAttendanceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teacherId => $composableBuilder(
    column: $table.teacherId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get markedBy => $composableBuilder(
    column: $table.markedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get markedAt => $composableBuilder(
    column: $table.markedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeacherAttendanceTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeacherAttendanceTable> {
  $$TeacherAttendanceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get teacherId =>
      $composableBuilder(column: $table.teacherId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<String> get markedBy =>
      $composableBuilder(column: $table.markedBy, builder: (column) => column);

  GeneratedColumn<String> get markedAt =>
      $composableBuilder(column: $table.markedAt, builder: (column) => column);
}

class $$TeacherAttendanceTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeacherAttendanceTable,
          TeacherAttendanceRow,
          $$TeacherAttendanceTableFilterComposer,
          $$TeacherAttendanceTableOrderingComposer,
          $$TeacherAttendanceTableAnnotationComposer,
          $$TeacherAttendanceTableCreateCompanionBuilder,
          $$TeacherAttendanceTableUpdateCompanionBuilder,
          (
            TeacherAttendanceRow,
            BaseReferences<
              _$AppDatabase,
              $TeacherAttendanceTable,
              TeacherAttendanceRow
            >,
          ),
          TeacherAttendanceRow,
          PrefetchHooks Function()
        > {
  $$TeacherAttendanceTableTableManager(
    _$AppDatabase db,
    $TeacherAttendanceTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeacherAttendanceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeacherAttendanceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeacherAttendanceTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> teacherId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> checkInTime = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                Value<String> markedBy = const Value.absent(),
                Value<String> markedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeacherAttendanceCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                teacherId: teacherId,
                date: date,
                status: status,
                checkInTime: checkInTime,
                remarks: remarks,
                markedBy: markedBy,
                markedAt: markedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String teacherId,
                required String date,
                required String status,
                Value<String?> checkInTime = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                required String markedBy,
                required String markedAt,
                Value<int> rowid = const Value.absent(),
              }) => TeacherAttendanceCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                teacherId: teacherId,
                date: date,
                status: status,
                checkInTime: checkInTime,
                remarks: remarks,
                markedBy: markedBy,
                markedAt: markedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TeacherAttendanceTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeacherAttendanceTable,
      TeacherAttendanceRow,
      $$TeacherAttendanceTableFilterComposer,
      $$TeacherAttendanceTableOrderingComposer,
      $$TeacherAttendanceTableAnnotationComposer,
      $$TeacherAttendanceTableCreateCompanionBuilder,
      $$TeacherAttendanceTableUpdateCompanionBuilder,
      (
        TeacherAttendanceRow,
        BaseReferences<
          _$AppDatabase,
          $TeacherAttendanceTable,
          TeacherAttendanceRow
        >,
      ),
      TeacherAttendanceRow,
      PrefetchHooks Function()
    >;
typedef $$ExamsTableCreateCompanionBuilder =
    ExamsCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String academicYearId,
      required String name,
      required String examType,
      Value<String?> startDate,
      Value<String?> endDate,
      Value<bool> isPublished,
      Value<int> rowid,
    });
typedef $$ExamsTableUpdateCompanionBuilder =
    ExamsCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> academicYearId,
      Value<String> name,
      Value<String> examType,
      Value<String?> startDate,
      Value<String?> endDate,
      Value<bool> isPublished,
      Value<int> rowid,
    });

class $$ExamsTableFilterComposer extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get academicYearId => $composableBuilder(
    column: $table.academicYearId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examType => $composableBuilder(
    column: $table.examType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPublished => $composableBuilder(
    column: $table.isPublished,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExamsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get academicYearId => $composableBuilder(
    column: $table.academicYearId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examType => $composableBuilder(
    column: $table.examType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPublished => $composableBuilder(
    column: $table.isPublished,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get academicYearId => $composableBuilder(
    column: $table.academicYearId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get examType =>
      $composableBuilder(column: $table.examType, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get isPublished => $composableBuilder(
    column: $table.isPublished,
    builder: (column) => column,
  );
}

class $$ExamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamsTable,
          Exam,
          $$ExamsTableFilterComposer,
          $$ExamsTableOrderingComposer,
          $$ExamsTableAnnotationComposer,
          $$ExamsTableCreateCompanionBuilder,
          $$ExamsTableUpdateCompanionBuilder,
          (Exam, BaseReferences<_$AppDatabase, $ExamsTable, Exam>),
          Exam,
          PrefetchHooks Function()
        > {
  $$ExamsTableTableManager(_$AppDatabase db, $ExamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> academicYearId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> examType = const Value.absent(),
                Value<String?> startDate = const Value.absent(),
                Value<String?> endDate = const Value.absent(),
                Value<bool> isPublished = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                academicYearId: academicYearId,
                name: name,
                examType: examType,
                startDate: startDate,
                endDate: endDate,
                isPublished: isPublished,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String academicYearId,
                required String name,
                required String examType,
                Value<String?> startDate = const Value.absent(),
                Value<String?> endDate = const Value.absent(),
                Value<bool> isPublished = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                academicYearId: academicYearId,
                name: name,
                examType: examType,
                startDate: startDate,
                endDate: endDate,
                isPublished: isPublished,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamsTable,
      Exam,
      $$ExamsTableFilterComposer,
      $$ExamsTableOrderingComposer,
      $$ExamsTableAnnotationComposer,
      $$ExamsTableCreateCompanionBuilder,
      $$ExamsTableUpdateCompanionBuilder,
      (Exam, BaseReferences<_$AppDatabase, $ExamsTable, Exam>),
      Exam,
      PrefetchHooks Function()
    >;
typedef $$MarksTableCreateCompanionBuilder =
    MarksCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String examId,
      required String studentId,
      required String subjectId,
      required String classId,
      Value<double?> obtainedMarks,
      Value<double> totalMarks,
      Value<bool> isAbsent,
      Value<String?> grade,
      Value<String?> remarks,
      Value<String?> enteredBy,
      Value<int> rowid,
    });
typedef $$MarksTableUpdateCompanionBuilder =
    MarksCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> examId,
      Value<String> studentId,
      Value<String> subjectId,
      Value<String> classId,
      Value<double?> obtainedMarks,
      Value<double> totalMarks,
      Value<bool> isAbsent,
      Value<String?> grade,
      Value<String?> remarks,
      Value<String?> enteredBy,
      Value<int> rowid,
    });

class $$MarksTableFilterComposer extends Composer<_$AppDatabase, $MarksTable> {
  $$MarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examId => $composableBuilder(
    column: $table.examId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get obtainedMarks => $composableBuilder(
    column: $table.obtainedMarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalMarks => $composableBuilder(
    column: $table.totalMarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAbsent => $composableBuilder(
    column: $table.isAbsent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enteredBy => $composableBuilder(
    column: $table.enteredBy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MarksTableOrderingComposer
    extends Composer<_$AppDatabase, $MarksTable> {
  $$MarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examId => $composableBuilder(
    column: $table.examId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get obtainedMarks => $composableBuilder(
    column: $table.obtainedMarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalMarks => $composableBuilder(
    column: $table.totalMarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAbsent => $composableBuilder(
    column: $table.isAbsent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enteredBy => $composableBuilder(
    column: $table.enteredBy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $MarksTable> {
  $$MarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get examId =>
      $composableBuilder(column: $table.examId, builder: (column) => column);

  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get subjectId =>
      $composableBuilder(column: $table.subjectId, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<double> get obtainedMarks => $composableBuilder(
    column: $table.obtainedMarks,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalMarks => $composableBuilder(
    column: $table.totalMarks,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAbsent =>
      $composableBuilder(column: $table.isAbsent, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<String> get enteredBy =>
      $composableBuilder(column: $table.enteredBy, builder: (column) => column);
}

class $$MarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MarksTable,
          Mark,
          $$MarksTableFilterComposer,
          $$MarksTableOrderingComposer,
          $$MarksTableAnnotationComposer,
          $$MarksTableCreateCompanionBuilder,
          $$MarksTableUpdateCompanionBuilder,
          (Mark, BaseReferences<_$AppDatabase, $MarksTable, Mark>),
          Mark,
          PrefetchHooks Function()
        > {
  $$MarksTableTableManager(_$AppDatabase db, $MarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> examId = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<double?> obtainedMarks = const Value.absent(),
                Value<double> totalMarks = const Value.absent(),
                Value<bool> isAbsent = const Value.absent(),
                Value<String?> grade = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                Value<String?> enteredBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MarksCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                examId: examId,
                studentId: studentId,
                subjectId: subjectId,
                classId: classId,
                obtainedMarks: obtainedMarks,
                totalMarks: totalMarks,
                isAbsent: isAbsent,
                grade: grade,
                remarks: remarks,
                enteredBy: enteredBy,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String examId,
                required String studentId,
                required String subjectId,
                required String classId,
                Value<double?> obtainedMarks = const Value.absent(),
                Value<double> totalMarks = const Value.absent(),
                Value<bool> isAbsent = const Value.absent(),
                Value<String?> grade = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                Value<String?> enteredBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MarksCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                examId: examId,
                studentId: studentId,
                subjectId: subjectId,
                classId: classId,
                obtainedMarks: obtainedMarks,
                totalMarks: totalMarks,
                isAbsent: isAbsent,
                grade: grade,
                remarks: remarks,
                enteredBy: enteredBy,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MarksTable,
      Mark,
      $$MarksTableFilterComposer,
      $$MarksTableOrderingComposer,
      $$MarksTableAnnotationComposer,
      $$MarksTableCreateCompanionBuilder,
      $$MarksTableUpdateCompanionBuilder,
      (Mark, BaseReferences<_$AppDatabase, $MarksTable, Mark>),
      Mark,
      PrefetchHooks Function()
    >;
typedef $$FeeStructuresTableCreateCompanionBuilder =
    FeeStructuresCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String academicYearId,
      Value<String?> classId,
      Value<double> tuitionFee,
      Value<double> admissionFee,
      Value<double> examFee,
      Value<double> otherFee,
      Value<String?> otherLabel,
      Value<int> rowid,
    });
typedef $$FeeStructuresTableUpdateCompanionBuilder =
    FeeStructuresCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> academicYearId,
      Value<String?> classId,
      Value<double> tuitionFee,
      Value<double> admissionFee,
      Value<double> examFee,
      Value<double> otherFee,
      Value<String?> otherLabel,
      Value<int> rowid,
    });

class $$FeeStructuresTableFilterComposer
    extends Composer<_$AppDatabase, $FeeStructuresTable> {
  $$FeeStructuresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get academicYearId => $composableBuilder(
    column: $table.academicYearId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tuitionFee => $composableBuilder(
    column: $table.tuitionFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get admissionFee => $composableBuilder(
    column: $table.admissionFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get examFee => $composableBuilder(
    column: $table.examFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get otherFee => $composableBuilder(
    column: $table.otherFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherLabel => $composableBuilder(
    column: $table.otherLabel,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeeStructuresTableOrderingComposer
    extends Composer<_$AppDatabase, $FeeStructuresTable> {
  $$FeeStructuresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get academicYearId => $composableBuilder(
    column: $table.academicYearId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tuitionFee => $composableBuilder(
    column: $table.tuitionFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get admissionFee => $composableBuilder(
    column: $table.admissionFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get examFee => $composableBuilder(
    column: $table.examFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get otherFee => $composableBuilder(
    column: $table.otherFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherLabel => $composableBuilder(
    column: $table.otherLabel,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeeStructuresTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeeStructuresTable> {
  $$FeeStructuresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get academicYearId => $composableBuilder(
    column: $table.academicYearId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<double> get tuitionFee => $composableBuilder(
    column: $table.tuitionFee,
    builder: (column) => column,
  );

  GeneratedColumn<double> get admissionFee => $composableBuilder(
    column: $table.admissionFee,
    builder: (column) => column,
  );

  GeneratedColumn<double> get examFee =>
      $composableBuilder(column: $table.examFee, builder: (column) => column);

  GeneratedColumn<double> get otherFee =>
      $composableBuilder(column: $table.otherFee, builder: (column) => column);

  GeneratedColumn<String> get otherLabel => $composableBuilder(
    column: $table.otherLabel,
    builder: (column) => column,
  );
}

class $$FeeStructuresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeeStructuresTable,
          FeeStructure,
          $$FeeStructuresTableFilterComposer,
          $$FeeStructuresTableOrderingComposer,
          $$FeeStructuresTableAnnotationComposer,
          $$FeeStructuresTableCreateCompanionBuilder,
          $$FeeStructuresTableUpdateCompanionBuilder,
          (
            FeeStructure,
            BaseReferences<_$AppDatabase, $FeeStructuresTable, FeeStructure>,
          ),
          FeeStructure,
          PrefetchHooks Function()
        > {
  $$FeeStructuresTableTableManager(_$AppDatabase db, $FeeStructuresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeeStructuresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeeStructuresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeeStructuresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> academicYearId = const Value.absent(),
                Value<String?> classId = const Value.absent(),
                Value<double> tuitionFee = const Value.absent(),
                Value<double> admissionFee = const Value.absent(),
                Value<double> examFee = const Value.absent(),
                Value<double> otherFee = const Value.absent(),
                Value<String?> otherLabel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeeStructuresCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                academicYearId: academicYearId,
                classId: classId,
                tuitionFee: tuitionFee,
                admissionFee: admissionFee,
                examFee: examFee,
                otherFee: otherFee,
                otherLabel: otherLabel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String academicYearId,
                Value<String?> classId = const Value.absent(),
                Value<double> tuitionFee = const Value.absent(),
                Value<double> admissionFee = const Value.absent(),
                Value<double> examFee = const Value.absent(),
                Value<double> otherFee = const Value.absent(),
                Value<String?> otherLabel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeeStructuresCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                academicYearId: academicYearId,
                classId: classId,
                tuitionFee: tuitionFee,
                admissionFee: admissionFee,
                examFee: examFee,
                otherFee: otherFee,
                otherLabel: otherLabel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeeStructuresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeeStructuresTable,
      FeeStructure,
      $$FeeStructuresTableFilterComposer,
      $$FeeStructuresTableOrderingComposer,
      $$FeeStructuresTableAnnotationComposer,
      $$FeeStructuresTableCreateCompanionBuilder,
      $$FeeStructuresTableUpdateCompanionBuilder,
      (
        FeeStructure,
        BaseReferences<_$AppDatabase, $FeeStructuresTable, FeeStructure>,
      ),
      FeeStructure,
      PrefetchHooks Function()
    >;
typedef $$FeeChallansTableCreateCompanionBuilder =
    FeeChallansCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String studentId,
      required String classId,
      required String challanNo,
      required int month,
      required int year,
      Value<String?> title,
      Value<double> tuitionFee,
      Value<double> admissionFee,
      Value<double> examFee,
      Value<double> otherFee,
      Value<double> arrears,
      Value<double> discount,
      Value<double> fine,
      required double totalAmount,
      required String issueDate,
      required String dueDate,
      Value<String> status,
      Value<double> paidAmount,
      Value<String?> paidDate,
      Value<String?> paymentMethod,
      Value<String?> receivedBy,
      Value<int> rowid,
    });
typedef $$FeeChallansTableUpdateCompanionBuilder =
    FeeChallansCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> studentId,
      Value<String> classId,
      Value<String> challanNo,
      Value<int> month,
      Value<int> year,
      Value<String?> title,
      Value<double> tuitionFee,
      Value<double> admissionFee,
      Value<double> examFee,
      Value<double> otherFee,
      Value<double> arrears,
      Value<double> discount,
      Value<double> fine,
      Value<double> totalAmount,
      Value<String> issueDate,
      Value<String> dueDate,
      Value<String> status,
      Value<double> paidAmount,
      Value<String?> paidDate,
      Value<String?> paymentMethod,
      Value<String?> receivedBy,
      Value<int> rowid,
    });

class $$FeeChallansTableFilterComposer
    extends Composer<_$AppDatabase, $FeeChallansTable> {
  $$FeeChallansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get challanNo => $composableBuilder(
    column: $table.challanNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tuitionFee => $composableBuilder(
    column: $table.tuitionFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get admissionFee => $composableBuilder(
    column: $table.admissionFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get examFee => $composableBuilder(
    column: $table.examFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get otherFee => $composableBuilder(
    column: $table.otherFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get arrears => $composableBuilder(
    column: $table.arrears,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fine => $composableBuilder(
    column: $table.fine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paidDate => $composableBuilder(
    column: $table.paidDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receivedBy => $composableBuilder(
    column: $table.receivedBy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeeChallansTableOrderingComposer
    extends Composer<_$AppDatabase, $FeeChallansTable> {
  $$FeeChallansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get challanNo => $composableBuilder(
    column: $table.challanNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tuitionFee => $composableBuilder(
    column: $table.tuitionFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get admissionFee => $composableBuilder(
    column: $table.admissionFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get examFee => $composableBuilder(
    column: $table.examFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get otherFee => $composableBuilder(
    column: $table.otherFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get arrears => $composableBuilder(
    column: $table.arrears,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fine => $composableBuilder(
    column: $table.fine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paidDate => $composableBuilder(
    column: $table.paidDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receivedBy => $composableBuilder(
    column: $table.receivedBy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeeChallansTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeeChallansTable> {
  $$FeeChallansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get challanNo =>
      $composableBuilder(column: $table.challanNo, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get tuitionFee => $composableBuilder(
    column: $table.tuitionFee,
    builder: (column) => column,
  );

  GeneratedColumn<double> get admissionFee => $composableBuilder(
    column: $table.admissionFee,
    builder: (column) => column,
  );

  GeneratedColumn<double> get examFee =>
      $composableBuilder(column: $table.examFee, builder: (column) => column);

  GeneratedColumn<double> get otherFee =>
      $composableBuilder(column: $table.otherFee, builder: (column) => column);

  GeneratedColumn<double> get arrears =>
      $composableBuilder(column: $table.arrears, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get fine =>
      $composableBuilder(column: $table.fine, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paidDate =>
      $composableBuilder(column: $table.paidDate, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receivedBy => $composableBuilder(
    column: $table.receivedBy,
    builder: (column) => column,
  );
}

class $$FeeChallansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeeChallansTable,
          FeeChallan,
          $$FeeChallansTableFilterComposer,
          $$FeeChallansTableOrderingComposer,
          $$FeeChallansTableAnnotationComposer,
          $$FeeChallansTableCreateCompanionBuilder,
          $$FeeChallansTableUpdateCompanionBuilder,
          (
            FeeChallan,
            BaseReferences<_$AppDatabase, $FeeChallansTable, FeeChallan>,
          ),
          FeeChallan,
          PrefetchHooks Function()
        > {
  $$FeeChallansTableTableManager(_$AppDatabase db, $FeeChallansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeeChallansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeeChallansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeeChallansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<String> challanNo = const Value.absent(),
                Value<int> month = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<double> tuitionFee = const Value.absent(),
                Value<double> admissionFee = const Value.absent(),
                Value<double> examFee = const Value.absent(),
                Value<double> otherFee = const Value.absent(),
                Value<double> arrears = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> fine = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<String> issueDate = const Value.absent(),
                Value<String> dueDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> paidAmount = const Value.absent(),
                Value<String?> paidDate = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> receivedBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeeChallansCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                studentId: studentId,
                classId: classId,
                challanNo: challanNo,
                month: month,
                year: year,
                title: title,
                tuitionFee: tuitionFee,
                admissionFee: admissionFee,
                examFee: examFee,
                otherFee: otherFee,
                arrears: arrears,
                discount: discount,
                fine: fine,
                totalAmount: totalAmount,
                issueDate: issueDate,
                dueDate: dueDate,
                status: status,
                paidAmount: paidAmount,
                paidDate: paidDate,
                paymentMethod: paymentMethod,
                receivedBy: receivedBy,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String studentId,
                required String classId,
                required String challanNo,
                required int month,
                required int year,
                Value<String?> title = const Value.absent(),
                Value<double> tuitionFee = const Value.absent(),
                Value<double> admissionFee = const Value.absent(),
                Value<double> examFee = const Value.absent(),
                Value<double> otherFee = const Value.absent(),
                Value<double> arrears = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> fine = const Value.absent(),
                required double totalAmount,
                required String issueDate,
                required String dueDate,
                Value<String> status = const Value.absent(),
                Value<double> paidAmount = const Value.absent(),
                Value<String?> paidDate = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> receivedBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeeChallansCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                studentId: studentId,
                classId: classId,
                challanNo: challanNo,
                month: month,
                year: year,
                title: title,
                tuitionFee: tuitionFee,
                admissionFee: admissionFee,
                examFee: examFee,
                otherFee: otherFee,
                arrears: arrears,
                discount: discount,
                fine: fine,
                totalAmount: totalAmount,
                issueDate: issueDate,
                dueDate: dueDate,
                status: status,
                paidAmount: paidAmount,
                paidDate: paidDate,
                paymentMethod: paymentMethod,
                receivedBy: receivedBy,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeeChallansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeeChallansTable,
      FeeChallan,
      $$FeeChallansTableFilterComposer,
      $$FeeChallansTableOrderingComposer,
      $$FeeChallansTableAnnotationComposer,
      $$FeeChallansTableCreateCompanionBuilder,
      $$FeeChallansTableUpdateCompanionBuilder,
      (
        FeeChallan,
        BaseReferences<_$AppDatabase, $FeeChallansTable, FeeChallan>,
      ),
      FeeChallan,
      PrefetchHooks Function()
    >;
typedef $$TimetableSlotsTableCreateCompanionBuilder =
    TimetableSlotsCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String classId,
      Value<String?> subjectId,
      Value<String?> teacherId,
      required int dayOfWeek,
      required int periodNo,
      required String startTime,
      required String endTime,
      Value<String> slotType,
      Value<int> rowid,
    });
typedef $$TimetableSlotsTableUpdateCompanionBuilder =
    TimetableSlotsCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> classId,
      Value<String?> subjectId,
      Value<String?> teacherId,
      Value<int> dayOfWeek,
      Value<int> periodNo,
      Value<String> startTime,
      Value<String> endTime,
      Value<String> slotType,
      Value<int> rowid,
    });

class $$TimetableSlotsTableFilterComposer
    extends Composer<_$AppDatabase, $TimetableSlotsTable> {
  $$TimetableSlotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teacherId => $composableBuilder(
    column: $table.teacherId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get periodNo => $composableBuilder(
    column: $table.periodNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slotType => $composableBuilder(
    column: $table.slotType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TimetableSlotsTableOrderingComposer
    extends Composer<_$AppDatabase, $TimetableSlotsTable> {
  $$TimetableSlotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teacherId => $composableBuilder(
    column: $table.teacherId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get periodNo => $composableBuilder(
    column: $table.periodNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slotType => $composableBuilder(
    column: $table.slotType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimetableSlotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimetableSlotsTable> {
  $$TimetableSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get subjectId =>
      $composableBuilder(column: $table.subjectId, builder: (column) => column);

  GeneratedColumn<String> get teacherId =>
      $composableBuilder(column: $table.teacherId, builder: (column) => column);

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<int> get periodNo =>
      $composableBuilder(column: $table.periodNo, builder: (column) => column);

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get slotType =>
      $composableBuilder(column: $table.slotType, builder: (column) => column);
}

class $$TimetableSlotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimetableSlotsTable,
          TimetableSlot,
          $$TimetableSlotsTableFilterComposer,
          $$TimetableSlotsTableOrderingComposer,
          $$TimetableSlotsTableAnnotationComposer,
          $$TimetableSlotsTableCreateCompanionBuilder,
          $$TimetableSlotsTableUpdateCompanionBuilder,
          (
            TimetableSlot,
            BaseReferences<_$AppDatabase, $TimetableSlotsTable, TimetableSlot>,
          ),
          TimetableSlot,
          PrefetchHooks Function()
        > {
  $$TimetableSlotsTableTableManager(
    _$AppDatabase db,
    $TimetableSlotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimetableSlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimetableSlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimetableSlotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<String?> subjectId = const Value.absent(),
                Value<String?> teacherId = const Value.absent(),
                Value<int> dayOfWeek = const Value.absent(),
                Value<int> periodNo = const Value.absent(),
                Value<String> startTime = const Value.absent(),
                Value<String> endTime = const Value.absent(),
                Value<String> slotType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimetableSlotsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                classId: classId,
                subjectId: subjectId,
                teacherId: teacherId,
                dayOfWeek: dayOfWeek,
                periodNo: periodNo,
                startTime: startTime,
                endTime: endTime,
                slotType: slotType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String classId,
                Value<String?> subjectId = const Value.absent(),
                Value<String?> teacherId = const Value.absent(),
                required int dayOfWeek,
                required int periodNo,
                required String startTime,
                required String endTime,
                Value<String> slotType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimetableSlotsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                classId: classId,
                subjectId: subjectId,
                teacherId: teacherId,
                dayOfWeek: dayOfWeek,
                periodNo: periodNo,
                startTime: startTime,
                endTime: endTime,
                slotType: slotType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TimetableSlotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimetableSlotsTable,
      TimetableSlot,
      $$TimetableSlotsTableFilterComposer,
      $$TimetableSlotsTableOrderingComposer,
      $$TimetableSlotsTableAnnotationComposer,
      $$TimetableSlotsTableCreateCompanionBuilder,
      $$TimetableSlotsTableUpdateCompanionBuilder,
      (
        TimetableSlot,
        BaseReferences<_$AppDatabase, $TimetableSlotsTable, TimetableSlot>,
      ),
      TimetableSlot,
      PrefetchHooks Function()
    >;
typedef $$AssignmentsTableCreateCompanionBuilder =
    AssignmentsCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String classId,
      Value<String?> subjectId,
      required String title,
      Value<String?> description,
      Value<String?> attachmentUrl,
      required String assignedDate,
      Value<String?> dueDate,
      Value<String?> createdBy,
      Value<int> rowid,
    });
typedef $$AssignmentsTableUpdateCompanionBuilder =
    AssignmentsCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> classId,
      Value<String?> subjectId,
      Value<String> title,
      Value<String?> description,
      Value<String?> attachmentUrl,
      Value<String> assignedDate,
      Value<String?> dueDate,
      Value<String?> createdBy,
      Value<int> rowid,
    });

class $$AssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AssignmentsTable> {
  $$AssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentUrl => $composableBuilder(
    column: $table.attachmentUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assignedDate => $composableBuilder(
    column: $table.assignedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssignmentsTable> {
  $$AssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentUrl => $composableBuilder(
    column: $table.attachmentUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assignedDate => $composableBuilder(
    column: $table.assignedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssignmentsTable> {
  $$AssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get subjectId =>
      $composableBuilder(column: $table.subjectId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachmentUrl => $composableBuilder(
    column: $table.attachmentUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assignedDate => $composableBuilder(
    column: $table.assignedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);
}

class $$AssignmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssignmentsTable,
          Assignment,
          $$AssignmentsTableFilterComposer,
          $$AssignmentsTableOrderingComposer,
          $$AssignmentsTableAnnotationComposer,
          $$AssignmentsTableCreateCompanionBuilder,
          $$AssignmentsTableUpdateCompanionBuilder,
          (
            Assignment,
            BaseReferences<_$AppDatabase, $AssignmentsTable, Assignment>,
          ),
          Assignment,
          PrefetchHooks Function()
        > {
  $$AssignmentsTableTableManager(_$AppDatabase db, $AssignmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssignmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssignmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssignmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<String?> subjectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> attachmentUrl = const Value.absent(),
                Value<String> assignedDate = const Value.absent(),
                Value<String?> dueDate = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssignmentsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                classId: classId,
                subjectId: subjectId,
                title: title,
                description: description,
                attachmentUrl: attachmentUrl,
                assignedDate: assignedDate,
                dueDate: dueDate,
                createdBy: createdBy,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String classId,
                Value<String?> subjectId = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> attachmentUrl = const Value.absent(),
                required String assignedDate,
                Value<String?> dueDate = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssignmentsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                classId: classId,
                subjectId: subjectId,
                title: title,
                description: description,
                attachmentUrl: attachmentUrl,
                assignedDate: assignedDate,
                dueDate: dueDate,
                createdBy: createdBy,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AssignmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssignmentsTable,
      Assignment,
      $$AssignmentsTableFilterComposer,
      $$AssignmentsTableOrderingComposer,
      $$AssignmentsTableAnnotationComposer,
      $$AssignmentsTableCreateCompanionBuilder,
      $$AssignmentsTableUpdateCompanionBuilder,
      (
        Assignment,
        BaseReferences<_$AppDatabase, $AssignmentsTable, Assignment>,
      ),
      Assignment,
      PrefetchHooks Function()
    >;
typedef $$NoticesTableCreateCompanionBuilder =
    NoticesCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      Value<String?> classId,
      Value<bool> isFacultyOnly,
      required String title,
      required String body,
      Value<String?> attachmentUrl,
      Value<String> priority,
      required String publishDate,
      Value<String?> expiresAt,
      Value<String?> createdBy,
      Value<int> rowid,
    });
typedef $$NoticesTableUpdateCompanionBuilder =
    NoticesCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String?> classId,
      Value<bool> isFacultyOnly,
      Value<String> title,
      Value<String> body,
      Value<String?> attachmentUrl,
      Value<String> priority,
      Value<String> publishDate,
      Value<String?> expiresAt,
      Value<String?> createdBy,
      Value<int> rowid,
    });

class $$NoticesTableFilterComposer
    extends Composer<_$AppDatabase, $NoticesTable> {
  $$NoticesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFacultyOnly => $composableBuilder(
    column: $table.isFacultyOnly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentUrl => $composableBuilder(
    column: $table.attachmentUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publishDate => $composableBuilder(
    column: $table.publishDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NoticesTableOrderingComposer
    extends Composer<_$AppDatabase, $NoticesTable> {
  $$NoticesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFacultyOnly => $composableBuilder(
    column: $table.isFacultyOnly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentUrl => $composableBuilder(
    column: $table.attachmentUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publishDate => $composableBuilder(
    column: $table.publishDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NoticesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NoticesTable> {
  $$NoticesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<bool> get isFacultyOnly => $composableBuilder(
    column: $table.isFacultyOnly,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get attachmentUrl => $composableBuilder(
    column: $table.attachmentUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get publishDate => $composableBuilder(
    column: $table.publishDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);
}

class $$NoticesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NoticesTable,
          Notice,
          $$NoticesTableFilterComposer,
          $$NoticesTableOrderingComposer,
          $$NoticesTableAnnotationComposer,
          $$NoticesTableCreateCompanionBuilder,
          $$NoticesTableUpdateCompanionBuilder,
          (Notice, BaseReferences<_$AppDatabase, $NoticesTable, Notice>),
          Notice,
          PrefetchHooks Function()
        > {
  $$NoticesTableTableManager(_$AppDatabase db, $NoticesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NoticesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NoticesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NoticesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String?> classId = const Value.absent(),
                Value<bool> isFacultyOnly = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String?> attachmentUrl = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> publishDate = const Value.absent(),
                Value<String?> expiresAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NoticesCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                classId: classId,
                isFacultyOnly: isFacultyOnly,
                title: title,
                body: body,
                attachmentUrl: attachmentUrl,
                priority: priority,
                publishDate: publishDate,
                expiresAt: expiresAt,
                createdBy: createdBy,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                Value<String?> classId = const Value.absent(),
                Value<bool> isFacultyOnly = const Value.absent(),
                required String title,
                required String body,
                Value<String?> attachmentUrl = const Value.absent(),
                Value<String> priority = const Value.absent(),
                required String publishDate,
                Value<String?> expiresAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NoticesCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                classId: classId,
                isFacultyOnly: isFacultyOnly,
                title: title,
                body: body,
                attachmentUrl: attachmentUrl,
                priority: priority,
                publishDate: publishDate,
                expiresAt: expiresAt,
                createdBy: createdBy,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NoticesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NoticesTable,
      Notice,
      $$NoticesTableFilterComposer,
      $$NoticesTableOrderingComposer,
      $$NoticesTableAnnotationComposer,
      $$NoticesTableCreateCompanionBuilder,
      $$NoticesTableUpdateCompanionBuilder,
      (Notice, BaseReferences<_$AppDatabase, $NoticesTable, Notice>),
      Notice,
      PrefetchHooks Function()
    >;
typedef $$LostItemsTableCreateCompanionBuilder =
    LostItemsCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String type,
      required String title,
      Value<String?> description,
      Value<String?> category,
      Value<String?> location,
      Value<String?> incidentDate,
      required String reportedBy,
      Value<String> status,
      Value<String> moderation,
      Value<int> reportCount,
      Value<String?> moderatedBy,
      Value<String> photos,
      Value<String?> expiresAt,
      required String createdAt,
      Value<int> rowid,
    });
typedef $$LostItemsTableUpdateCompanionBuilder =
    LostItemsCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> type,
      Value<String> title,
      Value<String?> description,
      Value<String?> category,
      Value<String?> location,
      Value<String?> incidentDate,
      Value<String> reportedBy,
      Value<String> status,
      Value<String> moderation,
      Value<int> reportCount,
      Value<String?> moderatedBy,
      Value<String> photos,
      Value<String?> expiresAt,
      Value<String> createdAt,
      Value<int> rowid,
    });

class $$LostItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LostItemsTable> {
  $$LostItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get incidentDate => $composableBuilder(
    column: $table.incidentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportedBy => $composableBuilder(
    column: $table.reportedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moderation => $composableBuilder(
    column: $table.moderation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reportCount => $composableBuilder(
    column: $table.reportCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moderatedBy => $composableBuilder(
    column: $table.moderatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photos => $composableBuilder(
    column: $table.photos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LostItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LostItemsTable> {
  $$LostItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get incidentDate => $composableBuilder(
    column: $table.incidentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportedBy => $composableBuilder(
    column: $table.reportedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moderation => $composableBuilder(
    column: $table.moderation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reportCount => $composableBuilder(
    column: $table.reportCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moderatedBy => $composableBuilder(
    column: $table.moderatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photos => $composableBuilder(
    column: $table.photos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LostItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LostItemsTable> {
  $$LostItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get incidentDate => $composableBuilder(
    column: $table.incidentDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reportedBy => $composableBuilder(
    column: $table.reportedBy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get moderation => $composableBuilder(
    column: $table.moderation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reportCount => $composableBuilder(
    column: $table.reportCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get moderatedBy => $composableBuilder(
    column: $table.moderatedBy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photos =>
      $composableBuilder(column: $table.photos, builder: (column) => column);

  GeneratedColumn<String> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LostItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LostItemsTable,
          LostItem,
          $$LostItemsTableFilterComposer,
          $$LostItemsTableOrderingComposer,
          $$LostItemsTableAnnotationComposer,
          $$LostItemsTableCreateCompanionBuilder,
          $$LostItemsTableUpdateCompanionBuilder,
          (LostItem, BaseReferences<_$AppDatabase, $LostItemsTable, LostItem>),
          LostItem,
          PrefetchHooks Function()
        > {
  $$LostItemsTableTableManager(_$AppDatabase db, $LostItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LostItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LostItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LostItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> incidentDate = const Value.absent(),
                Value<String> reportedBy = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> moderation = const Value.absent(),
                Value<int> reportCount = const Value.absent(),
                Value<String?> moderatedBy = const Value.absent(),
                Value<String> photos = const Value.absent(),
                Value<String?> expiresAt = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LostItemsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                type: type,
                title: title,
                description: description,
                category: category,
                location: location,
                incidentDate: incidentDate,
                reportedBy: reportedBy,
                status: status,
                moderation: moderation,
                reportCount: reportCount,
                moderatedBy: moderatedBy,
                photos: photos,
                expiresAt: expiresAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String type,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> incidentDate = const Value.absent(),
                required String reportedBy,
                Value<String> status = const Value.absent(),
                Value<String> moderation = const Value.absent(),
                Value<int> reportCount = const Value.absent(),
                Value<String?> moderatedBy = const Value.absent(),
                Value<String> photos = const Value.absent(),
                Value<String?> expiresAt = const Value.absent(),
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => LostItemsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                type: type,
                title: title,
                description: description,
                category: category,
                location: location,
                incidentDate: incidentDate,
                reportedBy: reportedBy,
                status: status,
                moderation: moderation,
                reportCount: reportCount,
                moderatedBy: moderatedBy,
                photos: photos,
                expiresAt: expiresAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LostItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LostItemsTable,
      LostItem,
      $$LostItemsTableFilterComposer,
      $$LostItemsTableOrderingComposer,
      $$LostItemsTableAnnotationComposer,
      $$LostItemsTableCreateCompanionBuilder,
      $$LostItemsTableUpdateCompanionBuilder,
      (LostItem, BaseReferences<_$AppDatabase, $LostItemsTable, LostItem>),
      LostItem,
      PrefetchHooks Function()
    >;
typedef $$ItemClaimsTableCreateCompanionBuilder =
    ItemClaimsCompanion Function({
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      required String id,
      required String schoolId,
      required String itemId,
      required String claimedBy,
      Value<String?> message,
      Value<String> status,
      Value<String?> handledBy,
      Value<int> rowid,
    });
typedef $$ItemClaimsTableUpdateCompanionBuilder =
    ItemClaimsCompanion Function({
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int?> serverSeq,
      Value<int> version,
      Value<String> id,
      Value<String> schoolId,
      Value<String> itemId,
      Value<String> claimedBy,
      Value<String?> message,
      Value<String> status,
      Value<String?> handledBy,
      Value<int> rowid,
    });

class $$ItemClaimsTableFilterComposer
    extends Composer<_$AppDatabase, $ItemClaimsTable> {
  $$ItemClaimsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get claimedBy => $composableBuilder(
    column: $table.claimedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get handledBy => $composableBuilder(
    column: $table.handledBy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ItemClaimsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemClaimsTable> {
  $$ItemClaimsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSeq => $composableBuilder(
    column: $table.serverSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolId => $composableBuilder(
    column: $table.schoolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get claimedBy => $composableBuilder(
    column: $table.claimedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get handledBy => $composableBuilder(
    column: $table.handledBy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ItemClaimsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemClaimsTable> {
  $$ItemClaimsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverSeq =>
      $composableBuilder(column: $table.serverSeq, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolId =>
      $composableBuilder(column: $table.schoolId, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get claimedBy =>
      $composableBuilder(column: $table.claimedBy, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get handledBy =>
      $composableBuilder(column: $table.handledBy, builder: (column) => column);
}

class $$ItemClaimsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemClaimsTable,
          ItemClaim,
          $$ItemClaimsTableFilterComposer,
          $$ItemClaimsTableOrderingComposer,
          $$ItemClaimsTableAnnotationComposer,
          $$ItemClaimsTableCreateCompanionBuilder,
          $$ItemClaimsTableUpdateCompanionBuilder,
          (
            ItemClaim,
            BaseReferences<_$AppDatabase, $ItemClaimsTable, ItemClaim>,
          ),
          ItemClaim,
          PrefetchHooks Function()
        > {
  $$ItemClaimsTableTableManager(_$AppDatabase db, $ItemClaimsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemClaimsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemClaimsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemClaimsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> schoolId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> claimedBy = const Value.absent(),
                Value<String?> message = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> handledBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemClaimsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                itemId: itemId,
                claimedBy: claimedBy,
                message: message,
                status: status,
                handledBy: handledBy,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int?> serverSeq = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String schoolId,
                required String itemId,
                required String claimedBy,
                Value<String?> message = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> handledBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemClaimsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverSeq: serverSeq,
                version: version,
                id: id,
                schoolId: schoolId,
                itemId: itemId,
                claimedBy: claimedBy,
                message: message,
                status: status,
                handledBy: handledBy,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ItemClaimsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemClaimsTable,
      ItemClaim,
      $$ItemClaimsTableFilterComposer,
      $$ItemClaimsTableOrderingComposer,
      $$ItemClaimsTableAnnotationComposer,
      $$ItemClaimsTableCreateCompanionBuilder,
      $$ItemClaimsTableUpdateCompanionBuilder,
      (ItemClaim, BaseReferences<_$AppDatabase, $ItemClaimsTable, ItemClaim>),
      ItemClaim,
      PrefetchHooks Function()
    >;
typedef $$OutboxTableCreateCompanionBuilder =
    OutboxCompanion Function({
      Value<int> seq,
      required String opId,
      required String tableNameRef,
      required String rowId,
      required String op,
      required String payload,
      required String createdAt,
      Value<int> attempts,
      Value<String?> lastError,
    });
typedef $$OutboxTableUpdateCompanionBuilder =
    OutboxCompanion Function({
      Value<int> seq,
      Value<String> opId,
      Value<String> tableNameRef,
      Value<String> rowId,
      Value<String> op,
      Value<String> payload,
      Value<String> createdAt,
      Value<int> attempts,
      Value<String?> lastError,
    });

class $$OutboxTableFilterComposer
    extends Composer<_$AppDatabase, $OutboxTable> {
  $$OutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get opId => $composableBuilder(
    column: $table.opId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tableNameRef => $composableBuilder(
    column: $table.tableNameRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get op => $composableBuilder(
    column: $table.op,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OutboxTableOrderingComposer
    extends Composer<_$AppDatabase, $OutboxTable> {
  $$OutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get opId => $composableBuilder(
    column: $table.opId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tableNameRef => $composableBuilder(
    column: $table.tableNameRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get op => $composableBuilder(
    column: $table.op,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OutboxTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutboxTable> {
  $$OutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get seq =>
      $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<String> get opId =>
      $composableBuilder(column: $table.opId, builder: (column) => column);

  GeneratedColumn<String> get tableNameRef => $composableBuilder(
    column: $table.tableNameRef,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get op =>
      $composableBuilder(column: $table.op, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$OutboxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OutboxTable,
          OutboxEntry,
          $$OutboxTableFilterComposer,
          $$OutboxTableOrderingComposer,
          $$OutboxTableAnnotationComposer,
          $$OutboxTableCreateCompanionBuilder,
          $$OutboxTableUpdateCompanionBuilder,
          (
            OutboxEntry,
            BaseReferences<_$AppDatabase, $OutboxTable, OutboxEntry>,
          ),
          OutboxEntry,
          PrefetchHooks Function()
        > {
  $$OutboxTableTableManager(_$AppDatabase db, $OutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> seq = const Value.absent(),
                Value<String> opId = const Value.absent(),
                Value<String> tableNameRef = const Value.absent(),
                Value<String> rowId = const Value.absent(),
                Value<String> op = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => OutboxCompanion(
                seq: seq,
                opId: opId,
                tableNameRef: tableNameRef,
                rowId: rowId,
                op: op,
                payload: payload,
                createdAt: createdAt,
                attempts: attempts,
                lastError: lastError,
              ),
          createCompanionCallback:
              ({
                Value<int> seq = const Value.absent(),
                required String opId,
                required String tableNameRef,
                required String rowId,
                required String op,
                required String payload,
                required String createdAt,
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => OutboxCompanion.insert(
                seq: seq,
                opId: opId,
                tableNameRef: tableNameRef,
                rowId: rowId,
                op: op,
                payload: payload,
                createdAt: createdAt,
                attempts: attempts,
                lastError: lastError,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OutboxTable,
      OutboxEntry,
      $$OutboxTableFilterComposer,
      $$OutboxTableOrderingComposer,
      $$OutboxTableAnnotationComposer,
      $$OutboxTableCreateCompanionBuilder,
      $$OutboxTableUpdateCompanionBuilder,
      (OutboxEntry, BaseReferences<_$AppDatabase, $OutboxTable, OutboxEntry>),
      OutboxEntry,
      PrefetchHooks Function()
    >;
typedef $$AttachmentOutboxTableCreateCompanionBuilder =
    AttachmentOutboxCompanion Function({
      required String id,
      required String localPath,
      required String storageKey,
      required String ownerTable,
      required String ownerRowId,
      Value<String> status,
      Value<int> attempts,
      Value<String?> lastError,
      required String createdAt,
      Value<int> rowid,
    });
typedef $$AttachmentOutboxTableUpdateCompanionBuilder =
    AttachmentOutboxCompanion Function({
      Value<String> id,
      Value<String> localPath,
      Value<String> storageKey,
      Value<String> ownerTable,
      Value<String> ownerRowId,
      Value<String> status,
      Value<int> attempts,
      Value<String?> lastError,
      Value<String> createdAt,
      Value<int> rowid,
    });

class $$AttachmentOutboxTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentOutboxTable> {
  $$AttachmentOutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storageKey => $composableBuilder(
    column: $table.storageKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerTable => $composableBuilder(
    column: $table.ownerTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerRowId => $composableBuilder(
    column: $table.ownerRowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttachmentOutboxTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentOutboxTable> {
  $$AttachmentOutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storageKey => $composableBuilder(
    column: $table.storageKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerTable => $composableBuilder(
    column: $table.ownerTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerRowId => $composableBuilder(
    column: $table.ownerRowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttachmentOutboxTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentOutboxTable> {
  $$AttachmentOutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get storageKey => $composableBuilder(
    column: $table.storageKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerTable => $composableBuilder(
    column: $table.ownerTable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerRowId => $composableBuilder(
    column: $table.ownerRowId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AttachmentOutboxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttachmentOutboxTable,
          AttachmentOutboxEntry,
          $$AttachmentOutboxTableFilterComposer,
          $$AttachmentOutboxTableOrderingComposer,
          $$AttachmentOutboxTableAnnotationComposer,
          $$AttachmentOutboxTableCreateCompanionBuilder,
          $$AttachmentOutboxTableUpdateCompanionBuilder,
          (
            AttachmentOutboxEntry,
            BaseReferences<
              _$AppDatabase,
              $AttachmentOutboxTable,
              AttachmentOutboxEntry
            >,
          ),
          AttachmentOutboxEntry,
          PrefetchHooks Function()
        > {
  $$AttachmentOutboxTableTableManager(
    _$AppDatabase db,
    $AttachmentOutboxTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentOutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentOutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentOutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String> storageKey = const Value.absent(),
                Value<String> ownerTable = const Value.absent(),
                Value<String> ownerRowId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentOutboxCompanion(
                id: id,
                localPath: localPath,
                storageKey: storageKey,
                ownerTable: ownerTable,
                ownerRowId: ownerRowId,
                status: status,
                attempts: attempts,
                lastError: lastError,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String localPath,
                required String storageKey,
                required String ownerTable,
                required String ownerRowId,
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => AttachmentOutboxCompanion.insert(
                id: id,
                localPath: localPath,
                storageKey: storageKey,
                ownerTable: ownerTable,
                ownerRowId: ownerRowId,
                status: status,
                attempts: attempts,
                lastError: lastError,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttachmentOutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttachmentOutboxTable,
      AttachmentOutboxEntry,
      $$AttachmentOutboxTableFilterComposer,
      $$AttachmentOutboxTableOrderingComposer,
      $$AttachmentOutboxTableAnnotationComposer,
      $$AttachmentOutboxTableCreateCompanionBuilder,
      $$AttachmentOutboxTableUpdateCompanionBuilder,
      (
        AttachmentOutboxEntry,
        BaseReferences<
          _$AppDatabase,
          $AttachmentOutboxTable,
          AttachmentOutboxEntry
        >,
      ),
      AttachmentOutboxEntry,
      PrefetchHooks Function()
    >;
typedef $$SyncStateTableCreateCompanionBuilder =
    SyncStateCompanion Function({
      required String key,
      Value<String?> value,
      Value<int> rowid,
    });
typedef $$SyncStateTableUpdateCompanionBuilder =
    SyncStateCompanion Function({
      Value<String> key,
      Value<String?> value,
      Value<int> rowid,
    });

class $$SyncStateTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncStateTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SyncStateTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncStateTable,
          SyncStateEntry,
          $$SyncStateTableFilterComposer,
          $$SyncStateTableOrderingComposer,
          $$SyncStateTableAnnotationComposer,
          $$SyncStateTableCreateCompanionBuilder,
          $$SyncStateTableUpdateCompanionBuilder,
          (
            SyncStateEntry,
            BaseReferences<_$AppDatabase, $SyncStateTable, SyncStateEntry>,
          ),
          SyncStateEntry,
          PrefetchHooks Function()
        > {
  $$SyncStateTableTableManager(_$AppDatabase db, $SyncStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStateCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStateCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncStateTable,
      SyncStateEntry,
      $$SyncStateTableFilterComposer,
      $$SyncStateTableOrderingComposer,
      $$SyncStateTableAnnotationComposer,
      $$SyncStateTableCreateCompanionBuilder,
      $$SyncStateTableUpdateCompanionBuilder,
      (
        SyncStateEntry,
        BaseReferences<_$AppDatabase, $SyncStateTable, SyncStateEntry>,
      ),
      SyncStateEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SchoolsTableTableManager get schools =>
      $$SchoolsTableTableManager(_db, _db.schools);
  $$AcademicYearsTableTableManager get academicYears =>
      $$AcademicYearsTableTableManager(_db, _db.academicYears);
  $$ClassesTableTableManager get classes =>
      $$ClassesTableTableManager(_db, _db.classes);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$AppUsersTableTableManager get appUsers =>
      $$AppUsersTableTableManager(_db, _db.appUsers);
  $$TeachersTableTableManager get teachers =>
      $$TeachersTableTableManager(_db, _db.teachers);
  $$TeacherClassAssignmentsTableTableManager get teacherClassAssignments =>
      $$TeacherClassAssignmentsTableTableManager(
        _db,
        _db.teacherClassAssignments,
      );
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$AttendanceTableTableManager get attendance =>
      $$AttendanceTableTableManager(_db, _db.attendance);
  $$TeacherAttendanceTableTableManager get teacherAttendance =>
      $$TeacherAttendanceTableTableManager(_db, _db.teacherAttendance);
  $$ExamsTableTableManager get exams =>
      $$ExamsTableTableManager(_db, _db.exams);
  $$MarksTableTableManager get marks =>
      $$MarksTableTableManager(_db, _db.marks);
  $$FeeStructuresTableTableManager get feeStructures =>
      $$FeeStructuresTableTableManager(_db, _db.feeStructures);
  $$FeeChallansTableTableManager get feeChallans =>
      $$FeeChallansTableTableManager(_db, _db.feeChallans);
  $$TimetableSlotsTableTableManager get timetableSlots =>
      $$TimetableSlotsTableTableManager(_db, _db.timetableSlots);
  $$AssignmentsTableTableManager get assignments =>
      $$AssignmentsTableTableManager(_db, _db.assignments);
  $$NoticesTableTableManager get notices =>
      $$NoticesTableTableManager(_db, _db.notices);
  $$LostItemsTableTableManager get lostItems =>
      $$LostItemsTableTableManager(_db, _db.lostItems);
  $$ItemClaimsTableTableManager get itemClaims =>
      $$ItemClaimsTableTableManager(_db, _db.itemClaims);
  $$OutboxTableTableManager get outbox =>
      $$OutboxTableTableManager(_db, _db.outbox);
  $$AttachmentOutboxTableTableManager get attachmentOutbox =>
      $$AttachmentOutboxTableTableManager(_db, _db.attachmentOutbox);
  $$SyncStateTableTableManager get syncState =>
      $$SyncStateTableTableManager(_db, _db.syncState);
}

import 'package:uuid/uuid.dart';

final _uuid = Uuid();

/// Generates a new row id.
///
/// UUIDv7, generated on the CLIENT — never by the database. See schema.sql
/// convention 1: a teacher offline marking 40 students needs ids immediately,
/// and `DEFAULT gen_random_uuid()` cannot deliver one until the row reaches
/// Postgres, which may be hours later.
///
/// v7 (not v4) because the first 48 bits are a millisecond timestamp, so ids
/// sort chronologically. That keeps B-tree inserts appending to the right edge
/// of the index instead of scattering across it, on both SQLite and Postgres.
String newId() => _uuid.v7();

/// Generates an id for a single sync operation.
///
/// Carried on every outbox entry and echoed into `sync_ops.op_id` server-side.
/// It is what makes a retried push idempotent: if the connection drops after
/// the server committed but before the client saw the response, the retry
/// carries the same op_id and the server recognises it as already applied.
String newOpId() => _uuid.v7();

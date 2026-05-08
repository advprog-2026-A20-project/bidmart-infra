-- BidMart shared local development DB bootstrap.
-- TODO: pisahkan schema/DB per service jika kontrak final sudah stabil.

CREATE SCHEMA IF NOT EXISTS auth;
CREATE SCHEMA IF NOT EXISTS listing_query;
CREATE SCHEMA IF NOT EXISTS auction_query;
CREATE SCHEMA IF NOT EXISTS bidding_command;
CREATE SCHEMA IF NOT EXISTS wallet;
CREATE SCHEMA IF NOT EXISTS notification;

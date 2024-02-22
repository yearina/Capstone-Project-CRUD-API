CREATE TABLE akun (
    id_akun VARCHAR(16) PRIMARY KEY NOT NULL,
    nama VARCHAR(250) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    posisi VARCHAR(50) NOT NULL
);

CREATE TABLE barang (
    id_barang VARCHAR(8) PRIMARY KEY NOT NULL,
    nama VARCHAR(100) NOT NULL,
    harga_jual INT NOT NULL,
    harga_beli INT NOT NULL,
    stock INT NOT NULL,
    keterangan TEXT 
);

CREATE TABLE beli (
    id_beli VARCHAR(8) PRIMARY KEY NOT NULL,
    tgl_pembelian DATETIME NOT NULL,
    total_harga INT NOT NULL
);


CREATE TABLE transaksi (
    id_transaksi VARCHAR(8) PRIMARY KEY NOT NULL,
    id_barang VARCHAR(8) NOT NULL,
    id_beli VARCHAR(8) NOT NULL,
    jumlah INT NOT NULL,
    FOREIGN KEY (id_barang) REFERENCES barang(id_barang),
    FOREIGN KEY (id_beli) REFERENCES beli(id_beli)
);

CREATE TABLE log_barang
(
    id_log VARCHAR(8) PRIMARY KEY NOT NULL,
    id_barang VARCHAR(8) NOT NULL,
    harga_jual_lama INT NOT NULL,
    harga_jual_baru INT NOT NULL,
    harga_beli_lama INT NOT NULL,
    harga_beli_baru INT NOT NULL,
    waktu DATE NOT NULL
);

DELIMITER $$
CREATE TRIGGER update_harga_barang
    BEFORE UPDATE 
    ON barang
    FOR EACH ROW 
BEGIN
    INSERT INTO log_barang
    set id_barang = OLD.id_barang,
    harga_jual_lama=old.harga_jual,
    harga_jual_baru=new.harga_jual,
    harga_beli_lama=old.harga_beli,
    harga_beli_baru=new.harga_beli,
    waktu = NOW(); 
END$$
DELIMITER ;

// fitur tambah✔️, hapus, edit tugas
// fitur timestamp ✔️
// fitur lihat tugas
// fitur sorting tugas berdarkan (1. deadline, 2. berdasarkan input)
// fitur sorting ascending (A - Z) atau descending (Z - A)
// fitur menandai tugas yang sudah dilakukan

#include <iostream>
#include <fstream>
#include <string>
using namespace std;

void tambahTugas() {
    string tugas;

    cout << "Masukkan tugas: ";
    cin.ignore();
    getline(cin, tugas);

    time_t sekarang = time(0);
    tm *waktu = localtime(&sekarang);

    char tanggal[100];
    strftime(tanggal, sizeof(tanggal), "%d-%m-%Y %H:%M:%S", waktu);

    ofstream file("todolist.txt", ios::app);

    if (file.is_open()) {
        file << "[" << tanggal << "] " << tugas << endl;

        file.close();
        cout << "Tugas berhasil disimpan!\n";
    } else {
        cout << "Gagal membuka file!\n";
    }
}

int main() {
    int pilihan;

    do {
        cout << "\n=== TO-DO LIST ===" << endl;
        cout << "1. Tambah Tugas" << endl;
        cout << "2. Lihat Tugas" << endl;
        cout << "3. Keluar" << endl;
        cout << "Pilih menu: ";
        cin >> pilihan;

        switch(pilihan) {
            case 1:
                tambahTugas();
                break;
            case 2:
                cout << "Fitur lihat tugas belum tersedia.\n";
                break;
            case 3:
                cout << "Keluar dari program...\n";
                break;
            default:
                cout << "Pilihan tidak valid!\n";
        }

    } while(pilihan != 3);

    return 0;
}
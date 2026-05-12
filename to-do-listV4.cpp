// fitur tambah, hapus, edit tugas ✔️
// fitur timestamp ✔️
// fitur lihat tugas ✔️
// fitur sorting tugas berdarkan (1. deadline, 2. berdasarkan input)
// fitur sorting ascending (A - Z) atau descending (Z - A)
// fitur menandai tugas yang sudah dilakukan ✔️

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
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

void lihatTugas() {
    ifstream file("todolist.txt");
    string baris;
    int no = 1;

    if (file.is_open()) {
        cout << "\n=== DAFTAR TUGAS ===\n";

        while (getline(file, baris)) {
            cout << no++ << ". " << baris << endl;
        }

        file.close();

        if (no == 1) {
            cout << "Belum ada tugas.\n";
        }

    } else {
        cout << "Gagal membuka file!\n";
    }
}

void editTugas() {
    vector<string> daftar;
    string baris;

    ifstream file("todolist.txt");
    while (getline(file, baris)) {
        daftar.push_back(baris);
    }
    file.close();

    if (daftar.empty()) {
        cout << "Belum ada tugas untuk diedit.\n";
        return;
    }

    cout << "\n=== EDIT TUGAS ===\n";
    for (int i = 0; i < daftar.size(); i++) {
        cout << i + 1 << ". " << daftar[i] << endl;
    }

    int index;
    cout << "Pilih nomor tugas: ";
    cin >> index;
    cin.ignore();

    if (index < 1 || index > daftar.size()) {
        cout << "Pilihan tidak valid!\n";
        return;
    }

    string lama = daftar[index - 1];

// cari posisi tanda "] "
size_t pos = lama.find("] ");

string timestamp = "";
if (pos != string::npos) {
    timestamp = lama.substr(0, pos + 2); // ambil "[tanggal] "
}

string tugasBaru;
cout << "Masukkan tugas baru: ";
getline(cin, tugasBaru);

// gabungkan lagi
daftar[index - 1] = timestamp + tugasBaru;

    ofstream out("todolist.txt");
    for (string t : daftar) {
        out << t << endl;
    }
    out.close();

    cout << "Tugas berhasil diedit!\n";
}

void hapusTugas() {
    vector<string> daftar;
    string baris;

    ifstream file("todolist.txt");
    while (getline(file, baris)) {
        daftar.push_back(baris);
    }
    file.close();

    if (daftar.empty()) {
        cout << "Belum ada tugas untuk dihapus.\n";
        return;
    }

    cout << "\n=== HAPUS TUGAS ===\n";
    for (int i = 0; i < daftar.size(); i++) {
        cout << i + 1 << ". " << daftar[i] << endl;
    }

    int index;
    cout << "Pilih nomor tugas: ";
    cin >> index;

    if (index < 1 || index > daftar.size()) {
        cout << "Pilihan tidak valid!\n";
        return;
    }

    daftar.erase(daftar.begin() + index - 1);

    ofstream out("todolist.txt");
    for (string t : daftar) {
        out << t << endl;
    }
    out.close();

    cout << "Tugas berhasil dihapus!\n";
}

void tandaiSelesai() {
    vector<string> daftar;
    string baris;

    ifstream file("todolist.txt");
    while (getline(file, baris)) {
        daftar.push_back(baris);
    }
    file.close();

    if (daftar.empty()) {
        cout << "Belum ada tugas.\n";
        return;
    }

    cout << "\n=== TANDAI SELESAI ===\n";
    for (int i = 0; i < daftar.size(); i++) {
        cout << i + 1 << ". " << daftar[i] << endl;
    }

    int index;
    cout << "Pilih nomor tugas: ";
    cin >> index;

    if (index < 1 || index > daftar.size()) {
        cout << "Pilihan tidak valid!\n";
        return;
    }

    // ambil tugas yang dipilih
string tugas = daftar[index - 1];

// cek apakah sudah DONE
if (tugas.find("[DONE] ") != string::npos) {
    cout << "Tugas sudah ditandai selesai.\n";
    return;
}

// tambahkan label DONE
tugas = "[DONE] " + tugas;

// hapus dari posisi lama
daftar.erase(daftar.begin() + index - 1);

// masukkan ke paling bawah
daftar.push_back(tugas);

    ofstream out("todolist.txt");
    for (string t : daftar) {
        out << t << endl;
    }
    out.close();

    cout << "Tugas berhasil ditandai selesai!\n";
}

int main() {
    int pilihan;

    do {
        cout << "\n=== TO-DO LIST ===" << endl;
        cout << "1. Tambah Tugas" << endl;
        cout << "2. Lihat Tugas" << endl;
        cout << "3. Edit Tugas" << endl;
        cout << "4. Hapus Tugas" << endl;
        cout << "5. Tandai Selesai" << endl;
        cout << "6. Keluar" << endl;
        cout << "Masukkan Pilihan: ";
        cin >> pilihan;

        switch(pilihan) {
            case 1:
                tambahTugas();
                break;
            case 2:
                lihatTugas();
                break;
            case 3:
                editTugas();
                break;
            case 4:
                hapusTugas();
                break;
            case 5:
                tandaiSelesai();
            break;
            case 6:
                cout << "Keluar dari program...\n";
                break;
            default:
                cout << "Pilihan tidak valid!\n";
        }
    } while(pilihan != 6);

    return 0;
}
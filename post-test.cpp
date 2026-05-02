#include <iostream>
using namespace std;

class hitungTabunganDanSaku {
    private:
        int jumlahBulan = 0;
        int uangSakuPerBulan = 0;
        int totalPengeluaran = 0;
        int uangSaku = 0;
        int tabungan = 0; 
    public:
        void inputData() {
            int q = 0;
            cout << "\nMasukkan Jumlah Bulan: "; cin >> q;
            jumlahBulan += q;
            cout << "Masukkan uang saku per bulan: "; cin >> uangSakuPerBulan;

            for (int i = 0; i < jumlahBulan; i++) {
                int x = 0;
                cout << "Pengeluaran bulan ke-" << i + 1 << ": "; cin >> x;
                totalPengeluaran += x;
            }
        }

        void tampilData() {
            cout << "\n--- Data Pengeluaran ---" << endl;
            cout << "Jumlah Bulan = " << jumlahBulan << endl;
            cout << "Uang saku per bulan = " << uangSakuPerBulan << endl;
        }

        void hitungTabungan() {
            uangSaku = jumlahBulan * uangSakuPerBulan;
            tabungan = uangSaku - totalPengeluaran;
            cout << "\nTotal Pengeluaran = " << totalPengeluaran << endl;
            cout << "Total Uang Saku = " << uangSaku << endl;
            cout << "Total Tabungan = " << tabungan << endl;
        }
};

int main() {
    hitungTabunganDanSaku hts;

    int pilihan;
    
    do {
        cout << "\n=== PROGRAM HITUNG TABUNGAN ===" << endl;
        cout << "1. Input Uang Bulanan" << endl;
        cout << "2. Tampilkan Data Pengeluaran" << endl;
        cout << "3. Hitung Uang Bulanan dan Tabungan" << endl;
        cout << "Pilih Menu: "; cin >> pilihan;

        if (pilihan == 1) {
            hts.inputData();
        } else if (pilihan == 2) {
            hts.tampilData();
        } else if (pilihan == 3) {
            hts.hitungTabungan();
        } else {
            cout << "Pilihan tidak tersedia!" << endl;
        }

    } while (true);

    return 0;
}
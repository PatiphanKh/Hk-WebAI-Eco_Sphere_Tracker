<template>
  <div class="space-y-8">
    <!-- Header Summary Section -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4 bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
      <div>
        <p class="text-xs font-bold text-green-700 uppercase tracking-widest mb-1">Ecosystem & Green Sequestration</p>
        <h2 class="text-3xl font-black text-emerald-950 flex items-center gap-2">
          <Icon name="ph:tree-structure-bold" class="w-8 h-8 text-green-600 animate-pulse" />
          Flora Analysis & Afforestation
        </h2>
        <p class="text-xs text-gray-500 mt-1">
          ผู้ใช้งานจำลอง: <span class="font-extrabold text-emerald-900">{{ displayUserName }}</span>
        </p>
      </div>

      <!-- Quick Navigation Tabs -->
      <div class="flex gap-1.5 bg-gray-50 p-1.5 rounded-xl border border-gray-200 w-full md:w-auto">
        <button 
          v-for="t in tabs" 
          :key="t.id"
          @click="activeTab = t.id"
          class="flex-1 md:flex-none text-xs font-bold px-4 py-2.5 rounded-lg transition-all flex items-center justify-center gap-1.5"
          :class="activeTab === t.id 
            ? 'bg-[#1b4332] text-white shadow-sm' 
            : 'text-gray-600 hover:text-emerald-950 hover:bg-gray-100'"
        >
          <Icon :name="t.icon" class="w-4 h-4" />
          <span>{{ t.label }}</span>
        </button>
      </div>
    </div>

    <!-- Stats Panel -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <!-- Stat 1: Total Planted -->
      <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex items-center justify-between hover:shadow-md transition duration-300">
        <div>
          <span class="text-[10px] font-extrabold text-gray-400 uppercase tracking-wider">ต้นไม้ที่สนับสนุนแล้ว</span>
          <p class="text-3xl font-black text-gray-900 mt-2 leading-none">
            {{ myForestStats.totalTrees }} <span class="text-xs text-gray-400 font-bold">ต้น</span>
          </p>
          <span class="text-[10px] text-green-600 font-bold mt-2.5 inline-block bg-green-50 border border-green-100 px-2 py-0.5 rounded">
            ความสำเร็จของเป้าหมายป่า
          </span>
        </div>
        <div class="bg-emerald-50 text-emerald-600 p-4 rounded-2xl">
          <Icon name="ph:plant-bold" class="w-8 h-8" />
        </div>
      </div>

      <!-- Stat 2: Annual Absorption -->
      <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex items-center justify-between hover:shadow-md transition duration-300">
        <div>
          <span class="text-[10px] font-extrabold text-gray-400 uppercase tracking-wider">การดูดซับคาร์บอนต่อปี</span>
          <p class="text-3xl font-black text-gray-900 mt-2 leading-none">
            {{ myForestStats.totalCo2.toFixed(1) }} <span class="text-xs text-gray-400 font-bold">kg CO₂</span>
          </p>
          <span class="text-[10px] text-blue-600 font-bold mt-2.5 inline-block bg-blue-50 border border-blue-100 px-2 py-0.5 rounded">
            เทียบเท่าลดไฟฟ้ารถยนต์
          </span>
        </div>
        <div class="bg-blue-50 text-blue-600 p-4 rounded-2xl">
          <Icon name="ph:chart-line-up-bold" class="w-8 h-8" />
        </div>
      </div>

      <!-- Stat 3: Points Generated -->
      <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex items-center justify-between hover:shadow-md transition duration-300">
        <div>
          <span class="text-[10px] font-extrabold text-gray-400 uppercase tracking-wider">Eco Points ที่ได้จากการปลูก</span>
          <p class="text-3xl font-black text-yellow-600 mt-2 leading-none font-mono">
            +{{ myForestStats.totalPoints.toLocaleString() }} <span class="text-xs text-gray-400 font-bold">pts</span>
          </p>
          <span class="text-[10px] text-yellow-700 font-bold mt-2.5 inline-block bg-yellow-50 border border-yellow-100 px-2 py-0.5 rounded">
            ใช้แลกรับส่วนลดพาร์ทเนอร์
          </span>
        </div>
        <div class="bg-yellow-50 text-yellow-600 p-4 rounded-2xl">
          <Icon name="ph:star-bold" class="w-8 h-8" />
        </div>
      </div>
    </div>

    <!-- Active Tab Content -->
    
    <!-- Tab 1: Flora Catalog & Sponsorship -->
    <div v-if="activeTab === 'catalog'" class="space-y-6">
      <div class="flex justify-between items-center">
        <div>
          <h3 class="text-lg font-bold text-emerald-950 flex items-center gap-2">
            <Icon name="ph:leaf-bold" class="w-5 h-5 text-emerald-700" />
            สารานุกรมพันธุ์ไม้รักษ์โลก
          </h3>
          <p class="text-xs text-gray-500 mt-0.5">เลือกพันธุ์ไม้ท้องถิ่นที่มีอัตรากักเก็บสูงเพื่อเพิ่มความหลากหลายทางชีวภาพและชดเชยคาร์บอนฟุตพริ้นท์ของคุณ</p>
        </div>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div 
          v-for="tree in treeSpecies" 
          :key="tree.id"
          class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden flex flex-col justify-between hover:shadow-md hover:border-green-200 transition-all duration-300 group"
        >
          <!-- Card Header & Visual representation -->
          <div class="p-6">
            <div class="flex justify-between items-start mb-4">
              <div class="p-3.5 rounded-2xl" :class="tree.bgClass">
                <Icon :name="tree.icon" class="w-7 h-7" />
              </div>
              <span class="text-[10px] font-bold px-2.5 py-1 rounded-full uppercase tracking-wider shadow-sm"
                :class="tree.growth === 'Fast' ? 'bg-green-50 text-green-700 border border-green-100' :
                        tree.growth === 'Medium' ? 'bg-amber-50 text-amber-700 border border-amber-100' :
                        'bg-blue-50 text-blue-700 border border-blue-100'"
              >
                อัตราโต: {{ tree.growthTh }}
              </span>
            </div>

            <h4 class="text-lg font-extrabold text-gray-900 flex items-baseline gap-1.5">
              {{ tree.name }}
              <span class="text-xs text-gray-400 font-semibold italic">{{ tree.scientific }}</span>
            </h4>

            <p class="text-xs text-gray-500 leading-relaxed mt-2.5 line-clamp-3">
              {{ tree.desc }}
            </p>

            <div class="grid grid-cols-2 gap-3 mt-5 pt-5 border-t border-gray-50 text-xs">
              <div class="bg-gray-50/50 p-2.5 rounded-xl border border-gray-100">
                <p class="text-[9px] text-gray-400 font-extrabold uppercase">การดูดซับ CO₂ / ปี</p>
                <p class="font-bold text-emerald-800 text-sm mt-0.5">{{ tree.co2 }} kg/ต้น</p>
              </div>
              <div class="bg-gray-50/50 p-2.5 rounded-xl border border-gray-100">
                <p class="text-[9px] text-gray-400 font-extrabold uppercase">อายุขัยเฉลี่ย</p>
                <p class="font-bold text-gray-700 text-sm mt-0.5">{{ tree.lifespan }} ปี</p>
              </div>
            </div>

            <div class="mt-3.5 flex items-center gap-1.5 text-xs text-gray-600 bg-emerald-50/30 p-2.5 rounded-xl border border-emerald-100/50">
              <Icon name="ph:map-pin-bold" class="w-4 h-4 text-emerald-700 flex-shrink-0" />
              <span class="font-semibold line-clamp-1">ถิ่นที่อยู่: {{ tree.habitat }}</span>
            </div>
          </div>

          <!-- Actions -->
          <div class="p-6 pt-0 border-t border-gray-50 bg-gray-50/30 flex justify-between items-center gap-4">
            <div>
              <p class="text-[9px] text-gray-400 font-bold uppercase">ค่าสนับสนุนปลูก</p>
              <p class="text-base font-black text-gray-900 leading-none">฿{{ tree.cost }}</p>
            </div>
            <button 
              @click="openPlantModal(tree)"
              class="bg-[#1b4332] text-white hover:bg-[#133024] font-bold text-xs px-4 py-2.5 rounded-xl transition flex items-center gap-1.5 shadow-sm group-hover:scale-[1.02]"
            >
              <Icon name="ph:hand-heart-bold" class="w-4 h-4" />
              สนับสนุนการปลูก
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Tab 2: Carbon Forecast Simulator -->
    <div v-if="activeTab === 'simulator'" class="bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
      <div class="mb-8">
        <h3 class="text-lg font-bold text-emerald-950 flex items-center gap-2">
          <Icon name="ph:chart-line-up-bold" class="w-5 h-5 text-emerald-700 animate-bounce" />
          Afforestation Sequestration Simulator
        </h3>
        <p class="text-xs text-gray-500 mt-1">ทดลองปรับสัดส่วนการปลูกพืชสายพันธุ์ต่าง ๆ เพื่อพยากรณ์ปริมาณคาร์บอนสะสมที่สามารถกักเก็บได้ในอนาคต</p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-5 gap-8">
        <!-- Left Sliders: 3 Columns -->
        <div class="lg:col-span-3 space-y-6">
          <h4 class="text-xs font-bold text-gray-400 uppercase tracking-widest border-b border-gray-100 pb-2">จำลองจำนวนต้นไม้ที่จะปลูก</h4>
          
          <div v-for="tree in treeSpecies" :key="tree.id" class="space-y-2">
            <div class="flex justify-between items-center">
              <span class="text-xs font-extrabold text-gray-700 flex items-center gap-1.5">
                <Icon :name="tree.icon" class="w-4 h-4 text-green-700" />
                {{ tree.name }}
              </span>
              <span class="text-xs font-black text-[#1b4332] bg-green-50 border border-green-100 px-2 py-0.5 rounded">
                {{ simQuantities[tree.id] || 0 }} ต้น
              </span>
            </div>
            <div class="flex items-center gap-4">
              <input 
                type="range" 
                v-model.number="simQuantities[tree.id]" 
                min="0" 
                max="100" 
                class="w-full h-2 bg-gray-100 rounded-lg appearance-none cursor-pointer accent-[#1b4332]"
              />
              <input 
                type="number" 
                v-model.number="simQuantities[tree.id]" 
                min="0" 
                max="1000"
                class="w-16 bg-gray-50 border border-gray-200 rounded-lg px-2 py-1 text-xs text-center font-bold"
              />
            </div>
          </div>

          <div class="flex justify-end pt-3">
            <button 
              @click="resetSimulator" 
              class="text-xs text-gray-500 hover:text-emerald-700 font-bold transition flex items-center gap-1.5"
            >
              <Icon name="ph:arrows-counter-clockwise-bold" class="w-3.5 h-3.5" />
              ล้างค่าจำลองทั้งหมด
            </button>
          </div>
        </div>

        <!-- Right Results: 2 Columns -->
        <div class="lg:col-span-2 bg-[#f4faf7] p-6 rounded-2xl border border-emerald-100 flex flex-col justify-between">
          <div>
            <h4 class="text-xs font-bold text-emerald-800 uppercase tracking-widest border-b border-emerald-200/50 pb-2">คาดการณ์คาร์บอนที่กักเก็บสะสม</h4>
            
            <div class="space-y-5 mt-6">
              <!-- 1 Year -->
              <div>
                <div class="flex justify-between text-xs font-bold text-gray-500 mb-1">
                  <span>ระยะสั้น (1 ปี)</span>
                  <span class="text-[#1b4332] font-black">{{ forecastCarbon(1).toFixed(1) }} kg CO₂</span>
                </div>
                <div class="w-full bg-gray-200/60 rounded-full h-2.5 overflow-hidden">
                  <div class="bg-emerald-600 h-2.5 rounded-full transition-all duration-500" :style="{ width: Math.min(100, (forecastCarbon(1) / 500) * 100) + '%' }"></div>
                </div>
              </div>

              <!-- 5 Years -->
              <div>
                <div class="flex justify-between text-xs font-bold text-gray-500 mb-1">
                  <span>ระยะกลาง (5 ปี)</span>
                  <span class="text-[#1b4332] font-black">{{ forecastCarbon(5).toFixed(1) }} kg CO₂</span>
                </div>
                <div class="w-full bg-gray-200/60 rounded-full h-2.5 overflow-hidden">
                  <div class="bg-emerald-700 h-2.5 rounded-full transition-all duration-500" :style="{ width: Math.min(100, (forecastCarbon(5) / 2500) * 100) + '%' }"></div>
                </div>
              </div>

              <!-- 10 Years -->
              <div>
                <div class="flex justify-between text-xs font-bold text-gray-500 mb-1">
                  <span>ระยะยาว (10 ปี)</span>
                  <span class="text-[#1b4332] font-black font-mono text-sm">{{ forecastCarbon(10).toFixed(1) }} kg CO₂</span>
                </div>
                <div class="w-full bg-gray-200/60 rounded-full h-2.5 overflow-hidden">
                  <div class="bg-emerald-900 h-2.5 rounded-full transition-all duration-500" :style="{ width: Math.min(100, (forecastCarbon(10) / 5000) * 100) + '%' }"></div>
                </div>
              </div>
            </div>

            <!-- Equivalence Indicators -->
            <div class="mt-8 pt-6 border-t border-emerald-200/50 space-y-3.5">
              <p class="text-[10px] text-emerald-800 font-extrabold uppercase tracking-wider">ศักยภาพการชดเชยที่ได้ (ปีที่ 10)</p>
              
              <div class="flex items-center gap-3 text-xs">
                <div class="p-2 bg-white rounded-lg text-emerald-800 border border-emerald-100 flex-shrink-0">
                  <Icon name="ph:car-bold" class="w-4 h-4" />
                </div>
                <div>
                  <p class="text-gray-500 font-bold">หลีกเลี่ยงคาร์บอนจากรถยนต์</p>
                  <p class="font-extrabold text-gray-900">{{ (forecastCarbon(10) * 5.2).toFixed(0).toLocaleString() }} กม. ขับขี่</p>
                </div>
              </div>

              <div class="flex items-center gap-3 text-xs">
                <div class="p-2 bg-white rounded-lg text-emerald-800 border border-emerald-100 flex-shrink-0">
                  <Icon name="ph:lightning-bold" class="w-4 h-4" />
                </div>
                <div>
                  <p class="text-gray-500 font-bold">เทียบเท่าไฟฟ้าที่ประหยัดได้</p>
                  <p class="font-extrabold text-gray-900">{{ (forecastCarbon(10) * 1.6).toFixed(0).toLocaleString() }} หน่วย (kWh)</p>
                </div>
              </div>
            </div>
          </div>

          <div class="mt-6">
            <button 
              @click="applySimToForest" 
              class="w-full bg-[#1b4332] hover:bg-[#133024] text-white py-3 rounded-xl font-bold text-xs transition flex items-center justify-center gap-1.5 shadow-sm"
              :disabled="totalSimTrees === 0"
              :class="{ 'opacity-60 cursor-not-allowed': totalSimTrees === 0 }"
            >
              <Icon name="ph:shopping-cart-bold" class="w-4 h-4" />
              สั่งซื้อสนับสนุนตามแผนนี้ ({{ totalSimTrees }} ต้น)
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Tab 3: My Virtual Forest -->
    <div v-if="activeTab === 'my-forest'" class="space-y-6">
      <div class="flex justify-between items-center">
        <div>
          <h3 class="text-lg font-bold text-emerald-950 flex items-center gap-2">
            <Icon name="ph:tree-evergreen-bold" class="w-5 h-5 text-emerald-700" />
            พื้นที่ป่าจำลองของฉัน (My Forest Hub)
          </h3>
          <p class="text-xs text-gray-500 mt-0.5">ติดตามการเจริญเติบโตของพันธุ์ไม้ที่คุณได้ให้การสนับสนุนการปลูกจริงในชุมชนต่าง ๆ</p>
        </div>
        
        <button 
          v-if="myPlantedTrees.length > 0"
          @click="clearMyForest"
          class="text-xs text-red-500 font-extrabold hover:text-red-700 transition"
        >
          รีเซ็ตข้อมูลป่า
        </button>
      </div>

      <!-- Empty State -->
      <div 
        v-if="myPlantedTrees.length === 0" 
        class="bg-white py-16 px-6 text-center rounded-2xl border border-gray-100 flex flex-col items-center justify-center max-w-2xl mx-auto shadow-sm"
      >
        <div class="bg-emerald-50 text-emerald-600 p-5 rounded-full mb-4">
          <Icon name="ph:tree-evergreen-bold" class="w-12 h-12" />
        </div>
        <h4 class="text-base font-extrabold text-gray-900">คุณยังไม่มีต้นไม้ในพื้นที่ป่าส่วนตัว</h4>
        <p class="text-xs text-gray-500 max-w-sm mt-2 leading-relaxed">
          ร่วมสนับสนุนการปลูกต้นไม้สายพันธุ์ท้องถิ่นเพื่อฟื้นฟูระบบนิเวศ โดยไปที่แท็บ <span class="font-extrabold text-[#1b4332] cursor-pointer" @click="activeTab = 'catalog'">"สารานุกรมพันธุ์ไม้"</span> เพื่อเริ่มต้นปลูกต้นไม้ต้นแรกของคุณ!
        </p>
        <button 
          @click="activeTab = 'catalog'"
          class="mt-6 bg-[#1b4332] hover:bg-[#133024] text-white px-5 py-2.5 rounded-xl text-xs font-bold transition shadow-sm"
        >
          ดูพันธุ์ไม้รักษ์โลก
        </button>
      </div>

      <!-- Planted Trees List & Visualizer -->
      <div v-else class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Visual Forest Map Grid: 2 Columns -->
        <div class="lg:col-span-2 bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
          <h4 class="text-xs font-bold text-gray-400 uppercase tracking-widest border-b border-gray-50 pb-2 mb-4">
            จำลองสภาพแวดล้อมป่าของคุณ
          </h4>
          
          <!-- Virtual forest gallery -->
          <div class="grid grid-cols-5 sm:grid-cols-8 gap-4 bg-emerald-50/20 p-6 rounded-2xl border border-emerald-100/50 min-h-[300px] content-start">
            <div 
              v-for="(visualTree, idx) in forestVisualGrid" 
              :key="idx" 
              class="flex flex-col items-center justify-center group relative cursor-pointer"
            >
              <!-- Plant Visual representation -->
              <div 
                class="w-10 h-10 rounded-full flex items-center justify-center transition-all duration-300 transform group-hover:scale-110"
                :class="visualTree.stage === 'Seedling' ? 'bg-amber-100 text-amber-600 border border-amber-200' :
                        visualTree.stage === 'Sapling' ? 'bg-green-100 text-green-700 border border-green-200' :
                        'bg-emerald-800 text-white'"
              >
                <Icon :name="visualTree.icon" class="w-5 h-5 animate-bounce" :style="{ 'animation-duration': (2 + (idx % 3)) + 's' }" />
              </div>
              <span class="text-[9px] font-bold text-gray-600 mt-1 block truncate max-w-full">{{ visualTree.name }}</span>
              
              <!-- Hover Info Tooltip -->
              <div class="opacity-0 group-hover:opacity-100 transition-opacity absolute bottom-full mb-1.5 bg-gray-900/95 text-white text-[10px] p-2 rounded-lg pointer-events-none w-36 shadow-lg z-10 font-bold border border-gray-800">
                <p class="text-emerald-300">{{ visualTree.name }}</p>
                <p class="text-gray-400 font-medium">ระดับ: {{ visualTree.stageTh }}</p>
                <p class="text-gray-400 font-medium truncate">พิกัด: {{ visualTree.location }}</p>
                <p class="text-emerald-400 font-mono text-[9px] mt-0.5">กักเก็บ: {{ visualTree.co2 }} kg/ปี</p>
              </div>
            </div>
          </div>
          
          <div class="mt-4 flex flex-wrap gap-4 text-xs font-semibold text-gray-500 bg-gray-50 p-3 rounded-xl border border-gray-100">
            <div class="flex items-center gap-1.5">
              <span class="w-3.5 h-3.5 bg-amber-100 text-amber-600 border border-amber-200 rounded-full flex items-center justify-center text-[8px] font-black">🌱</span>
              <span>กล้าไม้ (Seedling)</span>
            </div>
            <div class="flex items-center gap-1.5">
              <span class="w-3.5 h-3.5 bg-green-100 text-green-700 border border-green-200 rounded-full flex items-center justify-center text-[8px] font-black">🌿</span>
              <span>รุ่นเยาว์ (Sapling)</span>
            </div>
            <div class="flex items-center gap-1.5">
              <span class="w-3.5 h-3.5 bg-emerald-800 text-white rounded-full flex items-center justify-center text-[8px] font-black">🌳</span>
              <span>โตเต็มวัย (Mature)</span>
            </div>
          </div>
        </div>

        <!-- History/Activity Log: 1 Column -->
        <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col justify-between">
          <div>
            <h4 class="text-xs font-bold text-gray-400 uppercase tracking-widest border-b border-gray-50 pb-2 mb-4">
              ประวัติการปลูกต้นไม้
            </h4>

            <div class="space-y-3.5 overflow-y-auto max-h-[350px] pr-1">
              <div 
                v-for="log in myPlantedTrees" 
                :key="log.id" 
                class="flex items-start justify-between gap-3 p-3 bg-gray-50/50 rounded-xl border border-gray-100 text-xs hover:bg-gray-50 transition"
              >
                <div class="flex gap-2.5 items-start">
                  <div class="p-2 rounded-lg bg-green-100 text-green-700 flex-shrink-0">
                    <Icon name="ph:plant-bold" class="w-4 h-4" />
                  </div>
                  <div>
                    <p class="font-extrabold text-gray-900">{{ getTreeName(log.speciesId) }} จำนวน {{ log.qty }} ต้น</p>
                    <p class="text-[10px] text-gray-400 mt-0.5">พิกัด: {{ log.location }}</p>
                    <p class="text-[9px] text-[#1b4332] font-extrabold mt-1">คาร์บอนลดลง: -{{ getTreeCo2Reduction(log.speciesId, log.qty) }} kg/ปี</p>
                  </div>
                </div>
                <div class="text-right text-[10px]">
                  <p class="text-gray-400 font-bold">{{ formatDate(log.date) }}</p>
                  <p class="font-extrabold text-emerald-800 mt-1">฿{{ log.cost }}</p>
                </div>
              </div>
            </div>
          </div>

          <div class="mt-6 border-t border-gray-100 pt-4 bg-white flex justify-between items-center text-xs">
            <div>
              <p class="text-[10px] text-gray-400 font-bold uppercase">พื้นที่ชดเชยที่สนับสนุน</p>
              <p class="text-sm font-extrabold text-emerald-950 mt-0.5">รวมทั้งหมด {{ myForestLocations.length }} โครงการ</p>
            </div>
            <button 
              @click="activeTab = 'campaigns'"
              class="text-[#1b4332] font-black hover:text-[#133024] hover:underline transition"
            >
              ดูโครงการโครงการป่า ➔
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Tab 4: Reforestation Campaigns -->
    <div v-if="activeTab === 'campaigns'" class="space-y-6">
      <div>
        <h3 class="text-lg font-bold text-emerald-950 flex items-center gap-2">
          <Icon name="ph:map-pin-bold" class="w-5 h-5 text-emerald-700" />
          โครงการฟื้นฟูระบบนิเวศชุมชน (Active Campaigns)
        </h3>
        <p class="text-xs text-gray-500 mt-0.5">เลือกสนับสนุนพื้นที่ป่าชุมชนเพื่อปลูกกล้าไม้พันธุ์ทางตรงไปฟื้นระบบนิเวศดั้งเดิม</p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div 
          v-for="campaign in campaignLocations" 
          :key="campaign.id" 
          class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col justify-between hover:shadow-md transition duration-300"
        >
          <div>
            <div class="flex justify-between items-start mb-3">
              <span class="text-xs font-black text-emerald-800 bg-emerald-50 border border-emerald-100 px-3 py-1 rounded-full">
                {{ campaign.sponsorName }}
              </span>
              <span class="text-xs font-bold text-gray-400">พิกัดทางทหาร/เขต</span>
            </div>

            <h4 class="text-base font-extrabold text-gray-900 mt-1">
              {{ campaign.name }}
            </h4>
            <p class="text-xs text-gray-500 mt-2 leading-relaxed">
              {{ campaign.desc }}
            </p>

            <div class="mt-6 space-y-2">
              <div class="flex justify-between text-xs font-bold text-gray-600">
                <span>ความคืบหน้าการปลูก</span>
                <span>{{ campaign.trees.toLocaleString() }} / {{ campaign.target.toLocaleString() }} ต้น</span>
              </div>
              <div class="w-full bg-gray-100 rounded-full h-2 overflow-hidden shadow-inner border border-gray-200/50">
                <div class="bg-emerald-600 h-2 rounded-full transition-all duration-500" :style="{ width: Math.min(100, (campaign.trees / campaign.target) * 100) + '%' }"></div>
              </div>
              <p class="text-[10px] text-right text-gray-400 font-bold">
                ขาดอีก {{ (campaign.target - campaign.trees).toLocaleString() }} ต้นจะสำเร็จโครงการ
              </p>
            </div>
          </div>

          <div class="mt-6 pt-5 border-t border-gray-50 flex justify-between items-center gap-4">
            <div class="text-xs">
              <p class="text-[9px] text-gray-400 font-extrabold">ผู้ร่วมสนับสนุนแล้ว</p>
              <p class="font-extrabold text-emerald-950 mt-0.5">340+ บัญชีชุมชน</p>
            </div>
            <button 
              @click="activeTab = 'catalog'; selectedLocation = campaign.name"
              class="border border-green-700 hover:bg-green-50 text-green-700 font-bold text-xs px-4 py-2 rounded-xl transition flex items-center gap-1.5"
            >
              <Icon name="ph:plus-bold" class="w-3.5 h-3.5" />
              เลือกลงทะเบียนปลูกป่าที่นี่
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Tree Sponsoring Confirmation Modal -->
    <div 
      v-if="isPlantModalOpen" 
      class="fixed inset-0 bg-black/60 z-50 flex items-center justify-center p-4 backdrop-blur-[2.5px] transition-all duration-300"
    >
      <div class="bg-white rounded-2xl shadow-xl border border-gray-100 w-full max-w-md overflow-hidden transform scale-100 transition-all">
        <!-- Modal Header -->
        <div class="px-6 py-4 border-b border-gray-100 flex justify-between items-center bg-[#1b4332] text-white">
          <div class="flex items-center gap-2">
            <Icon name="ph:hand-heart-bold" class="w-5 h-5 text-green-400" />
            <h3 class="font-extrabold text-sm">ยืนยันการสนับสนุนการปลูกป่า</h3>
          </div>
          <button @click="closePlantModal" class="text-white/80 hover:text-white transition">
            <Icon name="ph:x-bold" class="w-5 h-5" />
          </button>
        </div>

        <!-- Modal Body -->
        <div class="p-6 space-y-4">
          <div class="bg-emerald-50/50 p-4 rounded-xl border border-emerald-100 flex gap-3 items-center">
            <div class="p-3 bg-emerald-100 text-emerald-700 rounded-xl">
              <Icon :name="selectedTreeForPlanting.icon" class="w-6 h-6" />
            </div>
            <div>
              <p class="text-xs text-gray-500 font-semibold">พันธุ์ไม้ที่เลือก</p>
              <p class="font-extrabold text-gray-900">{{ selectedTreeForPlanting.name }} <span class="text-[10px] text-gray-400 font-normal italic">({{ selectedTreeForPlanting.scientific }})</span></p>
              <p class="text-[10px] text-emerald-700 font-bold mt-0.5">กักเก็บ CO₂: {{ selectedTreeForPlanting.co2 }} kg/ปี/ต้น</p>
            </div>
          </div>

          <!-- Quantity Input -->
          <div class="space-y-1.5 text-xs">
            <label class="block text-gray-600 font-bold">จำนวนต้นไม้ที่ต้องการปลูก (ต้น)</label>
            <div class="flex items-center gap-3">
              <button 
                @click="plantQty = Math.max(1, plantQty - 1)" 
                class="bg-gray-100 text-gray-700 hover:bg-gray-200 border border-gray-200 rounded-lg w-9 h-9 flex items-center justify-center font-extrabold"
              >
                -
              </button>
              <input 
                type="number" 
                v-model.number="plantQty" 
                min="1" 
                class="bg-gray-50 border border-gray-200 rounded-lg w-20 h-9 text-center font-black text-gray-900 focus:outline-none focus:ring-1 focus:ring-[#1b4332] focus:bg-white"
              />
              <button 
                @click="plantQty = plantQty + 1" 
                class="bg-gray-100 text-gray-700 hover:bg-gray-200 border border-gray-200 rounded-lg w-9 h-9 flex items-center justify-center font-extrabold"
              >
                +
              </button>
            </div>
          </div>

          <!-- Location Selector -->
          <div class="space-y-1.5 text-xs">
            <label class="block text-gray-600 font-bold">พิกัดโครงการปลูกป่า</label>
            <select 
              v-model="selectedLocation" 
              class="w-full bg-gray-50 border border-gray-200 rounded-xl px-3 py-2.5 font-semibold text-gray-900 focus:outline-none focus:ring-1 focus:ring-[#1b4332] focus:bg-white"
            >
              <option v-for="loc in campaignLocations" :key="loc.id" :value="loc.name">
                {{ loc.name }}
              </option>
            </select>
          </div>

          <!-- Price Calculation Summary -->
          <div class="bg-gray-50 p-4 rounded-xl border border-gray-100 text-xs space-y-2">
            <div class="flex justify-between font-bold text-gray-500">
              <span>ราคาต่อต้น:</span>
              <span>฿{{ selectedTreeForPlanting.cost }}</span>
            </div>
            <div class="flex justify-between font-bold text-gray-500">
              <span>จำนวนรวม:</span>
              <span>{{ plantQty }} ต้น</span>
            </div>
            <div class="flex justify-between font-bold text-gray-500 border-t border-gray-200/50 pt-2 text-sm text-gray-900">
              <span>ราคาสุทธิ:</span>
              <span class="font-black">฿{{ plantQty * selectedTreeForPlanting.cost }}</span>
            </div>
            <div class="flex justify-between font-extrabold text-yellow-600">
              <span>คะแนนที่จะได้รับ:</span>
              <span>+{{ plantQty * selectedTreeForPlanting.points }} pts</span>
            </div>
          </div>
        </div>

        <!-- Modal Footer -->
        <div class="px-6 py-4 bg-gray-50 border-t border-gray-100 flex justify-end gap-3.5">
          <button 
            @click="closePlantModal"
            class="px-4 py-2.5 border border-gray-200 rounded-xl text-xs font-semibold text-gray-600 hover:bg-gray-100 transition"
          >
            ยกเลิก
          </button>
          <button 
            @click="confirmPlanting"
            class="px-5 py-2.5 bg-[#1b4332] hover:bg-[#133024] text-white rounded-xl text-xs font-black transition flex items-center gap-1.5 shadow-sm"
          >
            <Icon name="ph:check-bold" class="w-4 h-4" />
            ชำระเงินและปลูกต้นไม้
          </button>
        </div>
      </div>
    </div>

    <!-- Simple Toast Notification -->
    <Transition 
      enter-active-class="transform ease-out duration-300 transition-all"
      enter-from-class="translate-y-2 opacity-0 sm:translate-y-0 sm:translate-x-2"
      enter-to-class="translate-y-0 opacity-100 sm:translate-x-0"
      leave-active-class="transition ease-in duration-200"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <div 
        v-if="toastShow" 
        class="fixed bottom-5 right-5 z-50 bg-[#1b4332] text-white px-5 py-3.5 rounded-xl border border-emerald-600 shadow-xl flex items-center gap-3 max-w-sm"
      >
        <div class="bg-white/10 p-1.5 rounded-lg text-green-300">
          <Icon name="ph:check-circle-bold" class="w-5 h-5" />
        </div>
        <div>
          <p class="text-xs font-black">สนับสนุนสำเร็จ!</p>
          <p class="text-[10px] text-green-100/90 font-bold mt-0.5">{{ toastMessage }}</p>
        </div>
        <button @click="toastShow = false" class="text-white/80 hover:text-white ml-auto">
          <Icon name="ph:x-bold" class="w-4 h-4" />
        </button>
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'

// shared states matching layout and settings.vue
const selectedUserId = useState('selected_user_id', () => 'u001')
const offsetBought = useState('offset_bought', () => false)
const isOffline = useOffline()

// Tabs configuration
const tabs = [
  { id: 'catalog', label: 'สารานุกรมพันธุ์ไม้', icon: 'ph:leaf-bold' },
  { id: 'simulator', label: 'โปรแกรมคำนวณคาร์บอน', icon: 'ph:chart-line-up-bold' },
  { id: 'my-forest', label: 'พื้นที่ป่าจำลองของฉัน', icon: 'ph:tree-evergreen-bold' },
  { id: 'campaigns', label: 'โครงการป่าชุมชน', icon: 'ph:map-pin-bold' }
]

const activeTab = ref('catalog')

// Tree Species definitions (curated Thai species)
const treeSpecies = [
  {
    id: 'yang-na',
    name: 'ยางนา',
    scientific: 'Dipterocarpus alatus',
    co2: 15,
    growth: 'Fast',
    growthTh: 'โตเร็ว',
    lifespan: 100,
    habitat: 'พื้นที่ชุ่มน้ำ ดินตะกอนแม่น้ำ',
    desc: 'ไม้ยืนต้นขนาดใหญ่ที่มีค่าทางเศรษฐกิจสูง เหมาะสำหรับการฟื้นฟูป่าต้นน้ำและสร้างร่มเงาในพื้นที่ลุ่มน้ำ',
    cost: 150,
    points: 150,
    icon: 'ph:tree',
    bgClass: 'bg-emerald-50 text-emerald-700 border border-emerald-200'
  },
  {
    id: 'phayung',
    name: 'พะยูง',
    scientific: 'Dalbergia cochinchinensis',
    co2: 12,
    growth: 'Slow',
    growthTh: 'โตช้า',
    lifespan: 80,
    habitat: 'ป่าดิบแล้ง ดินระบายน้ำดี',
    desc: 'ไม้เนื้อแข็งมูลค่าสูง อัตราการเติบโตค่อนข้างช้า แต่มีความแข็งแรงทนทาน ทนต่อสภาพแล้ง และเก็บกักคาร์บอนได้มั่นคงยาวนาน',
    cost: 300,
    points: 300,
    icon: 'ph:tree-evergreen-bold',
    bgClass: 'bg-teal-50 text-teal-700 border border-teal-200'
  },
  {
    id: 'nonthri',
    name: 'นนทรี',
    scientific: 'Peltophorum pterocarpum',
    co2: 10,
    growth: 'Fast',
    growthTh: 'โตเร็ว',
    lifespan: 50,
    habitat: 'ที่ราบทั่วไป ปรับตัวง่าย',
    desc: 'ไม้ยืนต้นโตเร็ว ผลิดอกสีเหลืองพราวพรั่ง มีความทนทานต่อสภาพแวดล้อมต่าง ๆ ช่วยฟื้นฟูสภาพดินและปรับภูมิทัศน์อย่างรวดเร็ว',
    cost: 100,
    points: 100,
    icon: 'ph:flower-bold',
    bgClass: 'bg-amber-50 text-amber-700 border border-amber-200'
  },
  {
    id: 'mangrove',
    name: 'โกงกางใบใหญ่',
    scientific: 'Rhizophora mucronata',
    co2: 22,
    growth: 'Medium',
    growthTh: 'ปานกลาง',
    lifespan: 60,
    habitat: 'ปากแม่น้ำ ดินเลนชายเลน น้ำกร่อย',
    desc: 'พันธุ์ไม้หลักของป่าชายเลน มีประสิทธิภาพการกักเก็บคาร์บอนสูงสุดในปีกอายุน้อย (Blue Carbon) และช่วยป้องกันตลิ่งพังทลาย',
    cost: 200,
    points: 200,
    icon: 'ph:drop-bold',
    bgClass: 'bg-blue-50 text-blue-700 border border-blue-200'
  },
  {
    id: 'ratchaphruek',
    name: 'ราชพฤกษ์',
    scientific: 'Cassia fistula',
    co2: 9,
    growth: 'Medium',
    growthTh: 'ปานกลาง',
    lifespan: 70,
    habitat: 'ดินร่วนซุย ทนแล้งและรักแดด',
    desc: 'ต้นคูน หรือดอกลมแล้ง ดอกสีเหลืองสง่างาม ทนทานต่อสภาพอากาศแห้งแล้ง เหมาะสำหรับการปลูกในชุมชนเมืองเพื่อความสวยงามและการกรองฝุ่น',
    cost: 120,
    points: 120,
    icon: 'ph:sun-bold',
    bgClass: 'bg-yellow-50 text-yellow-700 border border-yellow-200'
  }
]

// Active reforestation projects mapping
const campaignLocations = [
  { id: 'doi-suthep', name: 'ป่าชุมชนดอยสุเทพ (เชียงใหม่)', trees: 8240, target: 10000, desc: 'ฟื้นฟูป่าต้นน้ำหลังวิกฤตไฟป่า', sponsorName: 'มูลนิธิรักษ์ป่าดอยสุเทพ' },
  { id: 'bang-pu', name: 'ป่าชายเลนบางปู (สมุทรปราการ)', trees: 14500, target: 20000, desc: 'เพิ่มพื้นที่ป่าชายเลน แหล่งอนุบาลสัตว์น้ำชายฝั่ง', sponsorName: 'เทศบาลตำบลบางปู & เครือข่ายรักษ์เล' },
  { id: 'kanchanaburi', name: 'สวนป่าชุมชนกาญจนบุรี (กาญจนบุรี)', trees: 3100, target: 5000, desc: 'ฟื้นฟูระบบนิเวศป่าเต็งรังและสร้างแนวป้องกันฝุ่นละออง', sponsorName: 'กรมป่าไม้ชุมชน' },
  { id: 'bkk-green', name: 'พื้นที่สีเขียวสวนสาธารณะ (กรุงเทพฯ)', trees: 920, target: 2000, desc: 'สร้างปอดสีเขียวกลางเมืองหลวงเพื่อกรองฝุ่น PM2.5', sponsorName: 'กทม. สวนและป่าไม้เมือง' }
]

// User specific datasets
const userProfile = ref(null)
const myPlantedTrees = ref([])

// Simulator State
const simQuantities = ref({
  'yang-na': 5,
  'phayung': 2,
  'nonthri': 8,
  'mangrove': 4,
  'ratchaphruek': 6
})

// Sponsoring Modal States
const isPlantModalOpen = ref(false)
const selectedTreeForPlanting = ref(treeSpecies[0])
const plantQty = ref(1)
const selectedLocation = ref(campaignLocations[0].name)

// Toast State
const toastShow = ref(false)
const toastMessage = ref('')

// Supabase details matching index.vue
const SUPABASE_URL = 'https://fsqqnrjhwjhprsbquqeg.supabase.co'
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzcXFucmpod2pocHJzYnF1cWVnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEzMjkyMzEsImV4cCI6MjA5NjkwNTIzMX0.5ohCPqG2wjlSc8RFsfAOUbtG1IGVWu_FeiZhMqqWae0'
const headers = {
  apikey: SUPABASE_ANON_KEY,
  Authorization: `Bearer ${SUPABASE_ANON_KEY}`
}

// Compute display user name
const displayUserName = computed(() => {
  const uid = selectedUserId.value
  if (uid === 'u001') return 'Somchai Jaidee'
  if (uid === 'u002') return 'Alice Green'
  if (uid === 'u005') return 'Wichai Nilsuwan'
  
  if (userProfile.value) return userProfile.value.name
  return 'กำลังดึงข้อมูลผู้ใช้...'
})

// Load active user's details from database
const loadUserProfile = async () => {
  try {
    const userRes = await $fetch(`${SUPABASE_URL}/rest/v1/users?user_id=eq.${selectedUserId.value}`, { headers })
    if (userRes && userRes.length > 0) {
      userProfile.value = userRes[0]
    }
    isOffline.value = false
  } catch (err) {
    console.error('Error fetching user profile in flora analysis:', err)
    isOffline.value = true
    
    // Load from cache
    if (typeof window !== 'undefined') {
      const cached = localStorage.getItem(`offline_cache_user_data_${selectedUserId.value}`)
      if (cached) {
        try {
          const cacheData = JSON.parse(cached)
          userProfile.value = cacheData.selectedUser
        } catch (e) {
          console.error(e)
        }
      } else {
        // Fallback mockup names
        const names = {
          'u001': 'Somchai Jaidee',
          'u002': 'Alice Green',
          'u005': 'Wichai Nilsuwan',
          'u003': 'Mana Dee',
          'u004': 'Somsri Jai-ngam'
        }
        userProfile.value = {
          user_id: selectedUserId.value,
          name: names[selectedUserId.value] || 'Somchai Jaidee'
        }
      }
    }
  }
}

// Dynamic seed generator for different simulated users to populate their forests initially
const getInitialSeedForUser = (userId) => {
  const seeds = {
    'u001': [
      { id: 'seed-01', speciesId: 'yang-na', qty: 3, location: 'ป่าชุมชนดอยสุเทพ (เชียงใหม่)', date: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString(), cost: 450 },
      { id: 'seed-02', speciesId: 'mangrove', qty: 5, location: 'ป่าชายเลนบางปู (สมุทรปราการ)', date: new Date(Date.now() - 10 * 24 * 60 * 60 * 1000).toISOString(), cost: 1000 },
      { id: 'seed-03', speciesId: 'nonthri', qty: 2, location: 'สวนป่าชุมชนกาญจนบุรี (กาญจนบุรี)', date: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString(), cost: 200 }
    ],
    'u002': [
      { id: 'seed-04', speciesId: 'phayung', qty: 4, location: 'สวนป่าชุมชนกาญจนบุรี (กาญจนบุรี)', date: new Date(Date.now() - 25 * 24 * 60 * 60 * 1000).toISOString(), cost: 1200 },
      { id: 'seed-05', speciesId: 'ratchaphruek', qty: 6, location: 'พื้นที่สีเขียวสวนสาธารณะ (กรุงเทพฯ)', date: new Date(Date.now() - 12 * 24 * 60 * 60 * 1000).toISOString(), cost: 720 },
      { id: 'seed-06', speciesId: 'mangrove', qty: 2, location: 'ป่าชายเลนบางปู (สมุทรปราการ)', date: new Date(Date.now() - 4 * 24 * 60 * 60 * 1000).toISOString(), cost: 400 }
    ],
    'u003': [
      { id: 'seed-07', speciesId: 'yang-na', qty: 5, location: 'ป่าชุมชนดอยสุเทพ (เชียงใหม่)', date: new Date(Date.now() - 40 * 24 * 60 * 60 * 1000).toISOString(), cost: 750 },
      { id: 'seed-08', speciesId: 'nonthri', qty: 3, location: 'พื้นที่สีเขียวสวนสาธารณะ (กรุงเทพฯ)', date: new Date(Date.now() - 18 * 24 * 60 * 60 * 1000).toISOString(), cost: 300 }
    ],
    'u004': [
      { id: 'seed-09', speciesId: 'ratchaphruek', qty: 8, location: 'พื้นที่สีเขียวสวนสาธารณะ (กรุงเทพฯ)', date: new Date(Date.now() - 15 * 24 * 60 * 60 * 1000).toISOString(), cost: 960 },
      { id: 'seed-10', speciesId: 'yang-na', qty: 2, location: 'ป่าชุมชนดอยสุเทพ (เชียงใหม่)', date: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000).toISOString(), cost: 300 }
    ],
    'u005': [
      { id: 'seed-11', speciesId: 'mangrove', qty: 10, location: 'ป่าชายเลนบางปู (สมุทรปราการ)', date: new Date(Date.now() - 50 * 24 * 60 * 60 * 1000).toISOString(), cost: 2000 },
      { id: 'seed-12', speciesId: 'yang-na', qty: 4, location: 'สวนป่าชุมชนกาญจนบุรี (กาญจนบุรี)', date: new Date(Date.now() - 8 * 24 * 60 * 60 * 1000).toISOString(), cost: 600 }
    ]
  }

  if (seeds[userId]) {
    return seeds[userId]
  }

  // Fallback dynamic generator based on user ID numbers
  const num = parseInt(userId.replace(/\D/g, ''), 10) || 1
  const specIndex1 = num % treeSpecies.length
  const specIndex2 = (num + 2) % treeSpecies.length
  const qty1 = (num % 4) + 2
  const qty2 = (num % 3) + 3
  
  return [
    { 
      id: `seed-dyn-1-${userId}`, 
      speciesId: treeSpecies[specIndex1].id, 
      qty: qty1, 
      location: campaignLocations[num % campaignLocations.length].name, 
      date: new Date(Date.now() - (num * 4) * 24 * 60 * 60 * 1000).toISOString(), 
      cost: qty1 * treeSpecies[specIndex1].cost 
    },
    { 
      id: `seed-dyn-2-${userId}`, 
      speciesId: treeSpecies[specIndex2].id, 
      qty: qty2, 
      location: campaignLocations[specIndex2 % campaignLocations.length].name, 
      date: new Date(Date.now() - (num * 2) * 24 * 60 * 60 * 1000).toISOString(), 
      cost: qty2 * treeSpecies[specIndex2].cost 
    }
  ]
}

// Load user's planted trees from localStorage scoped by active user ID
const loadPlantedTrees = () => {
  if (typeof window !== 'undefined') {
    const key = `eco_forest_${selectedUserId.value}`
    const stored = localStorage.getItem(key)
    if (stored) {
      try {
        myPlantedTrees.value = JSON.parse(stored)
      } catch (e) {
        console.error('Error parsing planted trees:', e)
        myPlantedTrees.value = []
      }
    } else {
      // Seed initial trees dynamically for any simulated user
      const initialSeed = getInitialSeedForUser(selectedUserId.value)
      myPlantedTrees.value = initialSeed
      localStorage.setItem(key, JSON.stringify(initialSeed))
    }
  }
}

// Save current state of planted trees to localStorage
const savePlantedTrees = () => {
  if (typeof window !== 'undefined') {
    const key = `eco_forest_${selectedUserId.value}`
    localStorage.setItem(key, JSON.stringify(myPlantedTrees.value))
  }
}

// Sponsoring dialog control
const openPlantModal = (tree) => {
  selectedTreeForPlanting.value = tree
  plantQty.value = 1
  selectedLocation.value = campaignLocations[0].name
  isPlantModalOpen.value = true
}

const closePlantModal = () => {
  isPlantModalOpen.value = false
}

// Sponsoring processing action
const confirmPlanting = () => {
  const newPlanted = {
    id: 'tree-' + Date.now() + '-' + Math.floor(Math.random() * 100),
    speciesId: selectedTreeForPlanting.value.id,
    qty: plantQty.value,
    location: selectedLocation.value,
    date: new Date().toISOString(),
    cost: plantQty.value * selectedTreeForPlanting.value.cost
  }

  myPlantedTrees.value.unshift(newPlanted)
  savePlantedTrees()

  // Update simulator settings automatically to match new planting
  simQuantities.value[newPlanted.speciesId] = (simQuantities.value[newPlanted.speciesId] || 0) + newPlanted.qty

  // Trigger offset state in dashboard
  offsetBought.value = true

  // Toast confirmation
  toastMessage.value = `ปลูกต้น ${selectedTreeForPlanting.value.name} จำนวน ${plantQty.value} ต้น เรียบร้อยแล้ว (ได้รับ +${plantQty.value * selectedTreeForPlanting.value.points} pts)`
  toastShow.value = true

  closePlantModal()

  // Auto-hide toast
  setTimeout(() => {
    toastShow.value = false
  }, 4500)
}

// Reset functions
const clearMyForest = () => {
  if (confirm('คุณต้องการลบข้อมูลการปลูกต้นไม้และป่าของคุณทั้งหมดใช่หรือไม่? (การกระทำนี้จะล้างแคชประวัติ)')) {
    myPlantedTrees.value = []
    savePlantedTrees()
    toastMessage.value = 'ล้างข้อมูลป่าและประวัติเรียบร้อยแล้ว'
    toastShow.value = true
    setTimeout(() => { toastShow.value = false }, 3000)
  }
}

// Simulator carbon calculation
const forecastCarbon = (years) => {
  let annualRate = 0
  treeSpecies.forEach(tree => {
    const qty = simQuantities.value[tree.id] || 0
    annualRate += qty * tree.co2
  })
  return annualRate * years
}

const resetSimulator = () => {
  treeSpecies.forEach(t => {
    simQuantities.value[t.id] = 0
  })
}

// Apply simulator quantities as a bundle sponsor
const applySimToForest = () => {
  const listToPlant = []
  let totalCost = 0
  let totalPointsEarned = 0
  
  treeSpecies.forEach(tree => {
    const qty = simQuantities.value[tree.id] || 0
    if (qty > 0) {
      listToPlant.push({
        id: 'tree-sim-' + Date.now() + '-' + tree.id,
        speciesId: tree.id,
        qty: qty,
        location: 'โครงการความร่วมมือปลูกป่าทางอากาศ',
        date: new Date().toISOString(),
        cost: qty * tree.cost
      })
      totalCost += qty * tree.cost
      totalPointsEarned += qty * tree.points
    }
  })

  if (listToPlant.length > 0) {
    myPlantedTrees.value = [...listToPlant, ...myPlantedTrees.value]
    savePlantedTrees()

    offsetBought.value = true
    
    toastMessage.value = `ปลูกต้นไม้จำลองรวม ${totalSimTrees.value} ต้น สำเร็จ! (ได้รับ +${totalPointsEarned} pts)`
    toastShow.value = true
    setTimeout(() => { toastShow.value = false }, 4000)

    activeTab.value = 'my-forest'
  }
}

const totalSimTrees = computed(() => {
  let total = 0
  treeSpecies.forEach(t => {
    total += simQuantities.value[t.id] || 0
  })
  return total
})

// Statistics calculations of current active forest
const myForestStats = computed(() => {
  let totalTrees = 0
  let totalCo2 = 0
  let totalPoints = 0

  myPlantedTrees.value.forEach(plant => {
    const spec = treeSpecies.find(t => t.id === plant.speciesId)
    if (spec) {
      totalTrees += plant.qty
      totalCo2 += plant.qty * spec.co2
      totalPoints += plant.qty * spec.points
    }
  })

  return {
    totalTrees,
    totalCo2,
    totalPoints
  }
})

// Location metrics unique names
const myForestLocations = computed(() => {
  const locs = myPlantedTrees.value.map(p => p.location)
  return [...new Set(locs)]
})

// Visual mapping grid representing user's actual trees
const forestVisualGrid = computed(() => {
  const grid = []
  myPlantedTrees.value.forEach(plant => {
    const spec = treeSpecies.find(t => t.id === plant.speciesId)
    if (spec) {
      // Determine plant growth stage based on time passed since simulated planted date
      const plantedTime = new Date(plant.date).getTime()
      const daysPassed = (Date.now() - plantedTime) / (1000 * 60 * 60 * 24)
      
      let stage = 'Mature'
      let stageTh = 'โตเต็มวัย'
      let icon = spec.icon

      if (daysPassed < 5) {
        stage = 'Seedling'
        stageTh = 'ต้นกล้า 🌱'
        icon = 'ph:plant-bold'
      } else if (daysPassed < 20) {
        stage = 'Sapling'
        stageTh = 'รุ่นเยาว์ 🌿'
        icon = 'ph:tree-bold'
      }

      // Add individual trees to the visual forest map
      for (let i = 0; i < Math.min(10, plant.qty); i++) {
        grid.push({
          name: spec.name,
          stage,
          stageTh,
          icon,
          location: plant.location,
          co2: spec.co2
        })
      }
    }
  })
  return grid.slice(0, 48) // Limit visual display to first 48 trees to prevent clutter
})

// Helper functions for displaying trees list
const getTreeName = (speciesId) => {
  const tree = treeSpecies.find(t => t.id === speciesId)
  return tree ? tree.name : 'ต้นไม้ทั่วไป'
}

const getTreeCo2Reduction = (speciesId, qty) => {
  const tree = treeSpecies.find(t => t.id === speciesId)
  return tree ? (tree.co2 * qty).toFixed(1) : 0
}

const formatDate = (isoString) => {
  if (!isoString) return 'N/A'
  const d = new Date(isoString)
  return d.toLocaleDateString('th-TH', { day: 'numeric', month: 'short', year: '2-digit' })
}

// Watch user profile change to reload trees from local storage scoped by user
watch(selectedUserId, () => {
  loadUserProfile()
  loadPlantedTrees()
})

onMounted(async () => {
  if (typeof window !== 'undefined') {
    const saved = localStorage.getItem('selected_user_id')
    if (saved) {
      selectedUserId.value = saved
    } else {
      navigateTo('/select-profile')
      return
    }
  }
  await loadUserProfile()
  loadPlantedTrees()
})
</script>

<style scoped>
/* Custom style overrides for a premium feel */
input[type="range"]::-webkit-slider-thumb {
  background: #1b4332;
  border: 2px solid #fff;
  border-radius: 50%;
  width: 16px;
  height: 16px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.2);
}
</style>
